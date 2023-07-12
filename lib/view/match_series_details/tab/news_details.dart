import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/news_details_model.dart';
import 'package:cricbuzzapp/utils/banner_ad.dart';
import 'package:cricbuzzapp/view/match_series_details/match_series_details_controller.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:styled_text/styled_text.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newsId;

  const NewsDetailsScreen({Key? key, required this.newsId}) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  MatchSeriesDetailsController controller =
      Get.put(MatchSeriesDetailsController());

  bool setTime = false;

  @override
  void initState() {

    Future.delayed(Duration(milliseconds: screenDelayTimer),() {
      setState(() {
        setTime = true;
      });
    });

    initAdplay();


    super.initState();
    // print(widget.newsId);
  }

  @override
  void didChangeDependencies() {
    bannercall(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bannerLoad = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        interstitialAd?.show();

        interstitialAd = null;
        Get.back();
        return false;
      },
      child: Scaffold(
        body: setTime == false?Center(
          child: CupertinoActivityIndicator(
            color: Colors.red.shade900,
          ),
        ):Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: FutureBuilder(
                future: controller.getSeriesNewsDetailsData(widget.newsId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
                  } else if (snapshot.hasData) {
                    NewsDetailsModel data = snapshot.data;
                    return ScrollConfiguration(
                      behavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            expandedHeight: 200.h,
                            pinned: true,
                            snap: false,
                            leading: IconButton(
                              onPressed: (){
                                interstitialAd?.show();

                                interstitialAd = null;
                                Get.back();
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            flexibleSpace: FlexibleSpaceBar(
                              background: Image.network(
                                controller.getImage("${data.coverImage?.id}"),
                                height: 200.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            floating: false,
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                var dt = DateTime.fromMillisecondsSinceEpoch(
                                    int.parse("${data.publishTime}"));

                                var d12 = DateFormat('yyyy-MM-dd hh:mm:ss').format(dt);

                                final time = controller.findDuration(DateTime.parse(d12));

                                return Padding(
                                  padding: EdgeInsets.all(12.sp),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data.headline}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 25.sp, fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: 22.h,
                                      ),
                                      Text(
                                        '$time',
                                        style: GoogleFonts.poppins(color: Colors.grey.shade600),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      )
                                    ],
                                  ),
                                );
                              },
                              childCount: 1,
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                var text = data.content![index].content?.contentValue;

                                // for(var change in data.format![index].value!){
                                //   text = text?.replaceFirst("${data.format![0].value![0].id}","${data.format![0].value![0].value}");
                                // }

                                if (data.format!.isNotEmpty) {
                                  for (int k = 0; k < data.format!.length; k++) {
                                    for (int i = 0;
                                    i < data.format![k].value!.length;
                                    i++) {
                                      if (data.format![k].type == "italic") {
                                        // if (data.format![k].value![i].value!.contains("@B")) {
                                        for (int c = 0; c < data.format![0].value!.length; c++) {
                                          if (data.format![k].value![i].value!.contains("${data.format![0].value![c].id}")) {

                                            data.format![k].value![i].value == null
                                                ? text = text?.replaceAllMapped(
                                                "${data.format![k].value![i].id}",
                                                    (match) => "<i> </i>")
                                                : text = text?.replaceAllMapped(
                                                "${data.format![k].value![i].id}",
                                                    (match) =>
                                                "<bi>${data.format![0].value![c].value} </bi>");
                                          }
                                          else{
                                            data.format![k].value![i].value == null
                                                ? text = text?.replaceAllMapped(
                                                "${data.format![k].value![i].id}",
                                                    (match) => "<i> </i>")
                                                : text = text?.replaceAllMapped(
                                                "${data.format![k].value![i].id}",
                                                    (match) =>
                                                "<i>${data.format![k].value![i].value} </i>");
                                          }
                                        }
                                      }

                                      if (data.format![k].type == "bold" ||
                                          data.format![k].type == "links") {
                                        data.format![k].value![i].value == null
                                            ? text = text?.replaceAllMapped(
                                            "${data.format![k].value![i].id}",
                                                (match) => "<bold> </bold>")
                                            : text = text?.replaceAllMapped(
                                            "${data.format![k].value![i].id}",
                                                (match) =>
                                            "<bold>${data.format![k].value![i].value} </bold>");
                                      }

                                      if (data.format![k].type == "urls") {
                                        data.format![k].value![i].value == null
                                            ? text = text?.replaceAllMapped(
                                            "${data.format![k].value![i].id}",
                                                (match) => "<bold> </bold>")
                                            : text = text?.replaceAllMapped(
                                            "${data.format![k].value![i].id}",
                                                (match) => "");
                                      }
                                    }
                                  }
                                }

                                return Padding(
                                    padding: EdgeInsets.all(12.sp),
                                    child: StyledText(
                                      text: '$text',
                                      style: GoogleFonts.poppins(fontSize: 17.sp,wordSpacing: 3.w),
                                      tags: {
                                        'bold': StyledTextTag(style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                                        'red': StyledTextTag(style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.red)),
                                        'i': StyledTextTag(
                                            style:
                                            GoogleFonts.poppins(fontStyle: FontStyle.italic)),
                                        'bi': StyledTextTag(
                                            style:
                                            GoogleFonts.poppins(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                                      },
                                    )

                                );
                              },
                              childCount: data.content?.length,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: CupertinoActivityIndicator(color: Colors.red[700],),
                  );
                },
              ),
            ),
            // BannerAD()
            bannerAdView(),
          ],
        ),
      ),
    );
  }
}

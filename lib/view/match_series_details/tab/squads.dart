
import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/series_squad_model.dart';
import 'package:cricbuzzapp/utils/banner_ad.dart';
import 'package:cricbuzzapp/utils/nativetwo.dart';
import 'package:cricbuzzapp/view/match_series_details/match_series_details_controller.dart';
import 'package:cricbuzzapp/view/match_series_details/tab/squad_details.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SquadsScreen extends StatefulWidget {
  final String seriesId;

  const SquadsScreen({Key? key, required this.seriesId}) : super(key: key);

  @override
  State<SquadsScreen> createState() => _SquadsScreenState();
}

class _SquadsScreenState extends State<SquadsScreen> {
  MatchSeriesDetailsController controller =
      Get.put(MatchSeriesDetailsController());

  bool setTime = false;

  @override
  void initState() {

    nativecall();

    Future.delayed(Duration(milliseconds: screenDelayTimer),() {
      setState(() {
        setTime = true;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    bannercall(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bannerLoad = false;
    nativeLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return setTime == false?Center(
      child: CupertinoActivityIndicator(
        color: Colors.red.shade900,
      ),
    ):Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // NativAdScreen(),
        nativeAdView(),
        Flexible(
          child: FutureBuilder(
            future: controller.getSeriesSquadData(widget.seriesId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
              } else if (snapshot.hasData) {
                SeriesSquadsModel data = snapshot.data;
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.squads?.length,
                  itemBuilder: (context, index) {
                    return data.squads![index].imageId == null?Container(
                      height: 45.h,
                      color: Colors.black12,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: Text("${data.squads![index].squadType?.toUpperCase()}",style: GoogleFonts.poppins(fontSize: 18.sp),),
                      ),
                    ):InkWell(
                      onTap: (){
                        Get.to(()=> SquadDetailsScreen(seriesId: widget.seriesId, squadId: "${data.squads![index].squadId}",title: "${data.squads![index].squadType}",));
                      },
                      child: Container(
                        height: 45.h,
                        // color: Colors.black12,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: Row(
                            children: [
                              Image.network(
                                  controller.getImage("${data.squads![index].imageId}"),height: 35.h,width: 35.w,
                              ),
                              SizedBox(width: 10.w,),
                              Text("${data.squads![index].squadType}",style: GoogleFonts.poppins(fontSize: 18.sp),),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CupertinoActivityIndicator(color: Colors.red[700],),
              );
            },
          ),
        ),
        bannerAdView(),
        // BannerAD()
      ],
    );
  }
}

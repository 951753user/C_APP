import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/utils/banner_ad.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:flutter/cupertino.dart' as ios;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../model/browse_series_model.dart';
import '../../../../widgets/divider.dart';
import '../../../match_series_details/match_series_details_screen.dart';
import '../../more_controller.dart';

class DomesticSeriesScreen extends StatefulWidget {
  const DomesticSeriesScreen({Key? key}) : super(key: key);

  @override
  State<DomesticSeriesScreen> createState() => _DomesticSeriesScreenState();
}

class _DomesticSeriesScreenState extends State<DomesticSeriesScreen> {
  MoreController controller = Get.put(MoreController());

  String? startMonthName;
  String? endMonthName;

  bool setTime = false;

  @override
  void initState() {

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return setTime == false?Center(
      child: ios.CupertinoActivityIndicator(
        color: Colors.red.shade900,
      ),
    ):Column(
      children: [
        Flexible(
          child: FutureBuilder(
            future: controller.getSeriesDomesticData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
              } else if (snapshot.hasData) {
                BrowseInternationalSeriesModel data = snapshot.data;
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.seriesMapProto?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          color: Colors.red.shade50,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
                            child: Text(
                              "${data.seriesMapProto![index].date}",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.seriesMapProto![index].series!.length,
                            separatorBuilder: (context, index) {
                              return divider();
                            },
                            itemBuilder: (context, i) {
                              var ds = DateTime.fromMillisecondsSinceEpoch(int.parse(
                                  "${data.seriesMapProto![index].series![i].startDt}"));
                              var de = DateTime.fromMillisecondsSinceEpoch(int.parse(
                                  "${data.seriesMapProto![index].series![i].endDt}"));
                              var dfsm = DateFormat('MM').format(ds);
                              var dfem = DateFormat('MM').format(de);
                              var dfsd = DateFormat('dd').format(ds);
                              var dfed = DateFormat('dd').format(de);

                              startMonth(dfsm);
                              endMonth(dfem);
                              return InkWell(

                                onTap: (){
                                  Get.to(()=> MatchSeriesDetailsScreen(
                                      seriesId:
                                      "${data.seriesMapProto![index].series![i].id}",
                                      seriesName:
                                      "${data.seriesMapProto![index].series![i].name}"));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data.seriesMapProto![index].series![i].name}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(fontSize: 16.sp),),
                                      SizedBox(height: 5.h,),
                                      Text("$startMonthName $dfsd - $endMonthName $dfed",style: GoogleFonts.poppins(color: Colors.grey.shade600),),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              return ios.Center(child: ios.CupertinoActivityIndicator(color: Colors.red[700],));
            },
          ),
        ),
        // BannerAD(),
        bannerAdView(),
      ],
    );
  }

  startMonth(String name) {
    switch (name) {
      case "01":
        startMonthName = "Jan";
        break;
      case "02":
        startMonthName = "Feb";
        break;
      case "03":
        startMonthName = "Mar";
        break;
      case "04":
        startMonthName = "Apr";
        break;
      case "05":
        startMonthName = "May";
        break;
      case "06":
        startMonthName = "Jun";
        break;
      case "07":
        startMonthName = "Jul";
        break;
      case "08":
        startMonthName = "Aug";
        break;
      case "09":
        startMonthName = "Sep";
        break;
      case "10":
        startMonthName = "Oct";
        break;
      case "11":
        startMonthName = "Nov";
        break;
      case "12":
        startMonthName = "Dec";
        break;
    }
  }
  endMonth(String name) {
    switch (name) {
      case "01":
        endMonthName = "Jan";
        break;
      case "02":
        endMonthName = "Feb";
        break;
      case "03":
        endMonthName = "Mar";
        break;
      case "04":
        endMonthName = "Apr";
        break;
      case "05":
        endMonthName = "May";
        break;
      case "06":
        endMonthName = "Jun";
        break;
      case "07":
        endMonthName = "Jul";
        break;
      case "08":
        endMonthName = "Aug";
        break;
      case "09":
        endMonthName = "Sep";
        break;
      case "10":
        endMonthName = "Oct";
        break;
      case "11":
        endMonthName = "Nov";
        break;
      case "12":
        endMonthName = "Dec";
        break;
    }
  }
}

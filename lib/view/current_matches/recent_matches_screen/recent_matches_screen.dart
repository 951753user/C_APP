import 'dart:async';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/recent_matches_model.dart' as md;
import 'package:cricbuzzapp/utils/nativeadscreen.dart';
import 'package:cricbuzzapp/utils/nativetwo.dart';
import 'package:cricbuzzapp/view/current_matches/current_matches_controller.dart';
import 'package:cricbuzzapp/view/home_screen/home_controller.dart';
import 'package:cricbuzzapp/view/match_details/match_details.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:cricbuzzapp/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class RecentMatchesScreen extends StatefulWidget {
  const RecentMatchesScreen({Key? key}) : super(key: key);

  @override
  State<RecentMatchesScreen> createState() => _RecentMatchesScreenState();
}

class _RecentMatchesScreenState extends State<RecentMatchesScreen> {
  CurrentMatchesController controller = Get.put(CurrentMatchesController());
  bool setTime = false;

  @override
  void initState() {
    Timer(Duration(seconds: 3),(){
      setState(() {

      });
    });
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
          child: Scrollbar(
            thickness: 5,
            child: FutureBuilder(
              future: controller.getrecentMatchesData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
                } else if (snapshot.hasData) {
                  md.RecentMatchesModel data = snapshot.data;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.typeMatches?.length,
                    itemBuilder: (context, mt) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount:
                            data.typeMatches![mt].seriesMatches!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return RefreshIndicator(
                            color: Colors.red,
                            onRefresh: () async {
                              controller.getrecentMatchesData();
                              setState(() {});
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    color: Colors.red.shade50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        "${data.typeMatches![mt].seriesMatches![index].seriesAdWrapper?.seriesName}",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: data
                                          .typeMatches![mt]
                                          .seriesMatches![index]
                                          .seriesAdWrapper
                                          ?.matches
                                          ?.length,
                                      itemBuilder: (context, i) {
                                        return recentMatchesData(
                                            data, mt, index, i);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },  separatorBuilder: (BuildContext context, int index) {
                        if(index%2 == 0)
                        {
                          return NativAdScreen();
                        }
                        return Container();
                      },
                      );
                    },
                  );
                }
                return Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.red.shade900,
                  ),
                );
              },
            ),
          ),
        ),
        // BannerAD(),
        bannerAdView(),
      ],
    );
  }

  String? startMonthName;

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

  Widget recentMatchesData(
      md.RecentMatchesModel data, int matchtype, int index, int i) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(
        "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.startDate}"));

// 12 Hour format:
    var d12 = DateFormat('hh:mm a').format(dt);


    String splitdata =
        "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team1Score?.inngs1?.overs}";

    var arr = splitdata.split('.');

    String splitdata2 =
        "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team2Score?.inngs1?.overs}";

    var array = splitdata2.split('.');

    var ds = DateTime.fromMillisecondsSinceEpoch(int.parse("${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.startDate}"));
    var dfsd = DateFormat('dd').format(ds);
    var dfsm = DateFormat('MM').format(ds);

    debugPrint(dfsm);

    startMonth(dfsm);

    final d= DateTime.now().day;

    if(int.parse(dfsd) == d){
      dfsd = "Today";
    } else if(int.parse(dfsd) == d-1){
      dfsd = "Yesterday";
    } else{
      dfsd = "$startMonthName $dfsd";
    }

    String winningTeam = "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.stateTitle}";
     var winner = winningTeam.split(" ");


    return InkWell(
      onTap: () {
        // print("${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.matchId}");
        Get.to(() => MatchDetailsScreen(
              index: 1,
              Id: '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.matchId}',
          state: '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.state}',
          t1: '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName}',
          t2: '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName}',
            ));
        // print( '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.state}',);
      },
      child: Card(
        elevation: 2,
        child: SizedBox(
          // height: 200.h,
          width: 300.w,
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "$dfsd, $d12",
                          style: GoogleFonts.poppins(
                              color: Get.find<HomeController>()
                                          .themeChanger
                                          .value ==
                                      false
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade600,
                              fontSize: 13.sp),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              divider(),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            Image.network(
                              controller.getImage(
                                  '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.imageId}'),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            SizedBox(
                              width: 120.w,
                              child: Text(
                                "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName}",

                                style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                  fontWeight: winner[0] == "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName}"?FontWeight.w600:FontWeight.w500,
                                  color: winner[0] == "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName}"?Colors.black:Colors.grey,
                                    ),
                                  overflow: TextOverflow.visible
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              controller.getImage(
                                  '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.imageId}'),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            SizedBox(

                              width: 120.w,
                              child: Text(
                                "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName}",
                                style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    fontWeight: winner[0] == "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName}"?FontWeight.w600:FontWeight.w500,
                                  color: winner[0] == "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName}"?Colors.black:Colors.grey,
                                    ),
                                  overflow: TextOverflow.visible
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 35.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          data
                              .typeMatches![matchtype]
                              .seriesMatches![index]
                              .seriesAdWrapper
                              ?.matches![i]
                              .matchScore
                              ?.team1Score
                              ?.inngs1
                              ?.runs ==
                              null
                              ? Container()
                              : Text(
                            "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team1Score?.inngs1?.runs}/"
                                "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team1Score?.inngs1?.wickets?? '0'}",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600,
                              color: winner[0] == "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName}"?Colors.black:Colors.grey,),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          data
                              .typeMatches![matchtype]
                              .seriesMatches![index]
                              .seriesAdWrapper
                              ?.matches![i]
                              .matchScore
                              ?.team1Score
                              ?.inngs1
                              ?.overs ==
                              null
                              ? Container()
                              :
                          arr[1] == "6"
                              ? Text(
                            "(${int.parse(arr[0]) + 1})",
                            style: GoogleFonts.poppins(
                                color: winner[0] == "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName}"?Colors.black:Colors.grey,
                                fontSize: 13.sp),
                          )
                              :
                          Text(
                            "(${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team1Score?.inngs1?.overs})",
                            style:
                            GoogleFonts.poppins(color: winner[0] == "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName}"?Colors.black:Colors.grey, fontSize: 13.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Row(
                        children: [
                          data
                              .typeMatches![matchtype]
                              .seriesMatches![index]
                              .seriesAdWrapper
                              ?.matches![i]
                              .matchScore
                              ?.team2Score
                              ?.inngs1
                              ?.runs ==
                              null
                              ? Container()
                              : Text(
                            "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team2Score?.inngs1?.runs}/"
                                "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team2Score?.inngs1?.wickets ?? '0'}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: winner[0] == "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName}"?Colors.black:Colors.grey,),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          data
                              .typeMatches![matchtype]
                              .seriesMatches![index]
                              .seriesAdWrapper
                              ?.matches![i]
                              .matchScore
                              ?.team2Score
                              ?.inngs1
                              ?.overs ==
                              null
                              ? Container()
                              :
                          array[1] == "6"
                              ? Text(
                            "(${int.parse(array[0]) + 1})",
                            style: GoogleFonts.poppins(
                                color: winner[0] == "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName}"?Colors.black:Colors.grey,
                                fontSize: 13.sp),
                          )
                              :
                          Text(
                            "(${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team2Score?.inngs1?.overs})",
                            style:
                            GoogleFonts.poppins(color: winner[0] == "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName}"?Colors.black:Colors.grey, fontSize: 13.sp),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15.sp),
                child: Text(
                  "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.status}",
                  style:
                      GoogleFonts.poppins(color: Colors.green,fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

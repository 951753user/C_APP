// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/upcomingmatches_model.dart' as md;
import 'package:cricbuzzapp/utils/nativeadscreen.dart';
import 'package:cricbuzzapp/utils/nativetwo.dart';
import 'package:cricbuzzapp/view/current_matches/current_matches_controller.dart';
import 'package:cricbuzzapp/view/match_details/match_details.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:cricbuzzapp/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UpcomingMatchesScreen extends StatefulWidget {
  const UpcomingMatchesScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingMatchesScreen> createState() => _UpcomingMatchesScreenState();
}

class _UpcomingMatchesScreenState extends State<UpcomingMatchesScreen> {
  CurrentMatchesController controller = Get.put(CurrentMatchesController());

  final storage = const FlutterSecureStorage();

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
              future: controller.getUpcomingMatchesData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return
                      //  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
                      Center(
                          child: Text("No Data!",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 25)));
                } else if (snapshot.hasData) {
                  md.UpcomingMatchesModel data = snapshot.data;
                  return RefreshIndicator(
                    color: Colors.red,
                    onRefresh: () async {
                      controller.getUpcomingMatchesData();
                      setState(() {});
                    },
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.typeMatches?.length,
                      itemBuilder: (context, mt) {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount:
                              data.typeMatches![mt].seriesMatches!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
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
                                      return upcomingMatchesData(
                                          index, mt, data, i);
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            if (index % 2 == 0) {
                              return NativAdScreen();
                            }
                            return Container();
                          },
                        );
                      },
                    ),
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
        // BannerAD()
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

  Widget upcomingMatchesData(
      int index, int matchtype, md.UpcomingMatchesModel data, int i) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(
        "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.startDate}"));

    var ptime;
    var remid;
// 12 Hour format:
    var d12 = DateFormat('hh:mm a').format(dt);

    var ds = DateTime.fromMillisecondsSinceEpoch(int.parse("${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.startDate}"));
    var dfsd = DateFormat('dd').format(ds);
    var dfsm = DateFormat('MM').format(ds);

    debugPrint(dfsm);

    startMonth(dfsm);

    final d= DateTime.now().day;

    if(int.parse(dfsd) == d){
      dfsd = "Today";
    } else if(int.parse(dfsd) == d+1){
      dfsd = "Tomorrow";
    } else{
      dfsd = "$startMonthName $dfsd";
    }


    return InkWell(
      onTap: () {
        // Get.toNamed(AppPages.matchDetails);
        // print(
        //     '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.matchId}');
        Get.to(MatchDetailsScreen(
          Id: '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.matchId}',
          upcoming: true,
          t1: '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName}',
          t2: '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName}',
          state:
              '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.state}',
        ));
      },
      child: Card(
        elevation: 2,
        child: SizedBox(
          // height: 210.h,
          width: double.infinity,

          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                              color: Colors.deepOrange,
                              fontSize: 13.sp),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        // print(DateTime.now());

                        //2023-03-30 11:53:50.321125

                        remid = DateTime.fromMillisecondsSinceEpoch(int.parse(
                            "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.startDate}"));

                        ptime = DateFormat('yyyy-MM-dd HH:mm:ss.000000')
                            .format(remid);

                        compareReminderList.add({
                          "$ptime":
                              "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName} vs ${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName} at ${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.venueInfo?.ground}"
                        });

                        await storage.write(
                            key: "remind_compare",
                            value: jsonEncode(compareReminderList));
                        setState(() {
                          datafind = compareReminderList;
                        });

                        Fluttertoast.showToast(
                            msg:
                                "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName} vs ${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName}\n Notification Scheduled",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red[800],
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: Icon(
                          datafind != null
                              ? datafind.contains(
                                      "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName} vs ${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName} at ${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.venueInfo?.ground}")
                                  ? Icons.notifications_active_rounded
                                  : Icons.notifications_none
                              : compareReminderList.contains(
                                      '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName} vs ${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName} at ${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.venueInfo?.ground}')
                                  ? Icons.notifications_active_rounded
                                  : Icons.notifications_none,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              divider(),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150.w,
                      child: Text(
                        "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamName}",
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade600,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                    ),
                    // Spacer(),
                    SizedBox(
                      width: 150.w,
                      child: Text(
                        "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamName}",
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade600,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Image.network(
                          controller.getImage(
                              "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.imageId}"),
                          height: 40.h,
                          width: 40.w,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                            "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName}",
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  Text(
                    "VS",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, color: Colors.red[700]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Text(
                            "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName}",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis),
                        SizedBox(
                          width: 15.w,
                        ),
                        Image.network(
                          controller.getImage(
                              "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.imageId}"),
                          height: 40.h,
                          width: 40.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.all(15.sp),
                child: Text(
                    "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.venueInfo?.ground}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

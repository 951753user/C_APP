import 'dart:convert';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/series_matches_model.dart' as md;
import 'package:cricbuzzapp/utils/banner_ad.dart';
import 'package:cricbuzzapp/utils/nativetwo.dart';
import 'package:cricbuzzapp/view/home_screen/home_controller.dart';
import 'package:cricbuzzapp/view/match_details/match_details.dart';
import 'package:cricbuzzapp/view/match_series_details/match_series_details_controller.dart';
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


class MatchesScreen extends StatefulWidget {
  final String seriesId;

  const MatchesScreen({Key? key, required this.seriesId}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
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


  final storage = const FlutterSecureStorage();
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
            future: controller.getSeriesMatchesData(widget.seriesId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
              } else if (snapshot.hasData) {
                md.SeriesMatchesModel data = snapshot.data;
                return RefreshIndicator(
                  color: Colors.red,
                  onRefresh: () async {
                    controller.getSeriesMatchesData(widget.seriesId);
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemCount: data.matchDetails?.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
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
                                  "${data.matchDetails![index].matchDetailsMap?.key}",
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
                                itemCount: data.matchDetails![index]
                                    .matchDetailsMap?.match?.length,
                                itemBuilder: (context, i) {
                                  return seriesMatchData(data, index, i);
                                },
                              ),
                            ),
                          ],
                        ),
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
        bannerAdView(),
        // BannerAD()

      ],
    );

  }

  Widget seriesMatchData(md.SeriesMatchesModel data, int index, int i) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(
        "${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.startDate}"));

// 12 Hour format:
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
    return InkWell(
      onTap: () {
        // print("${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.matchId}");
        Get.to(() => MatchDetailsScreen(
              index: 0,
              Id: '${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.matchId}',
          t1:  '${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team1?.teamSName}',
          t2:  '${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team2?.teamSName}',
          state: '${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.state}',
            ));
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

                          d12,
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
                    data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.state == "Upcoming" ||
                        data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.state ==
                            "Preview" ||
                        data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.state ==
                            "Toss"
                        ?InkWell(
                      onTap:
                          () async {
                        var remid = DateTime.fromMillisecondsSinceEpoch(int.parse("${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.startDate}"));

                        var ptime = DateFormat('yyyy-MM-dd HH:mm:ss.000000').format(remid);

                        compareReminderList.add({
                          ptime: "${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team1!.teamSName} vs ${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team2!.teamSName} at ${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.venueInfo?.ground}"
                        });

                        await storage.write(key: "remind_compare", value: jsonEncode(compareReminderList)).whenComplete(() {
                          Fluttertoast.showToast(
                              msg: "${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team1!.teamSName} vs ${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team2!.teamSName}\n Notification Scheduled",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red[800],
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        });
                        setState(() {
                          datafind = compareReminderList;
                        });
                      },

                      child:
                      SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: Icon(
                          datafind != null
                              ? datafind.contains("${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team1!.teamSName} vs ${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team2!.teamSName} at ${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.venueInfo?.ground}")
                              ? Icons.notifications_active_rounded
                              : Icons.notifications_none
                              : compareReminderList.contains("${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team1!.teamSName} vs ${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team2!.teamSName} at ${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.venueInfo?.ground}")
                              ? Icons.notifications_active_rounded
                              : Icons.notifications_none,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ):Container()
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
                                "${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team1?.imageId}",
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            SizedBox(
                              width: 120.w,
                              child: Text(
                                "${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team1?.teamName}",
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    ),
                                overflow: TextOverflow.visible,
                                maxLines: 2,
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
                          children: [
                            Image.network(
                              controller.getImage(
                                "${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team2?.imageId}",
                              ),
                              height: 40.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            SizedBox(
                              width: 120.w,
                              child: Text(
                                "${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.team2?.teamName}",
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    ),
                                  overflow: TextOverflow.visible
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Visibility(
                            visible: data
                                            .matchDetails![index]
                                            .matchDetailsMap
                                            ?.match![i]
                                            .matchScore
                                            ?.team1Score
                                            ?.inngs1
                                            ?.runs ==
                                        null ||
                                    data
                                            .matchDetails![index]
                                            .matchDetailsMap
                                            ?.match![i]
                                            .matchScore
                                            ?.team1Score
                                            ?.inngs1
                                            ?.wickets ==
                                        null
                                ? false
                                : true,
                            child: Text(
                              "${data.matchDetails![index].matchDetailsMap?.match![i].matchScore?.team1Score?.inngs1?.runs}/${data.matchDetails![index].matchDetailsMap?.match![i].matchScore?.team1Score?.inngs1?.wickets}",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Visibility(
                            visible: data
                                            .matchDetails![index]
                                            .matchDetailsMap
                                            ?.match![i]
                                            .matchScore
                                            ?.team1Score
                                            ?.inngs1
                                            ?.runs ==
                                        null ||
                                    data
                                            .matchDetails![index]
                                            .matchDetailsMap
                                            ?.match![i]
                                            .matchScore
                                            ?.team1Score
                                            ?.inngs1
                                            ?.wickets ==
                                        null
                                ? false
                                : true,
                            child: Text(
                              "(${data.matchDetails![index].matchDetailsMap?.match![i].matchScore?.team1Score?.inngs1?.overs})",
                              style: GoogleFonts.poppins(
                                  color: Colors.grey, fontSize: 13.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        children: [
                          Visibility(
                            visible: data
                                            .matchDetails![index]
                                            .matchDetailsMap
                                            ?.match![i]
                                            .matchScore
                                            ?.team2Score
                                            ?.inngs1
                                            ?.runs ==
                                        null ||
                                    data
                                            .matchDetails![index]
                                            .matchDetailsMap
                                            ?.match![i]
                                            .matchScore
                                            ?.team2Score
                                            ?.inngs1
                                            ?.wickets ==
                                        null
                                ? false
                                : true,
                            child: Text(
                              "${data.matchDetails![index].matchDetailsMap?.match![i].matchScore?.team2Score?.inngs1?.runs}/${data.matchDetails![index].matchDetailsMap?.match![i].matchScore?.team2Score?.inngs1?.wickets}",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Visibility(
                            visible: data
                                            .matchDetails![index]
                                            .matchDetailsMap
                                            ?.match![i]
                                            .matchScore
                                            ?.team2Score
                                            ?.inngs1
                                            ?.runs ==
                                        null ||
                                    data
                                            .matchDetails![index]
                                            .matchDetailsMap
                                            ?.match![i]
                                            .matchScore
                                            ?.team2Score
                                            ?.inngs1
                                            ?.wickets ==
                                        null
                                ? false
                                : true,
                            child: Text(
                              "(${data.matchDetails![index].matchDetailsMap?.match![i].matchScore?.team2Score?.inngs1?.overs})",
                              style: GoogleFonts.poppins(
                                  color: Colors.grey, fontSize: 13.sp),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15.sp),
                child: data.matchDetails![index].matchDetailsMap?.match![i]
                            .matchInfo?.status ==
                        null
                    ? const Text("")
                    : Text(
                        "${data.matchDetails![index].matchDetailsMap?.match![i].matchInfo?.status}",
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

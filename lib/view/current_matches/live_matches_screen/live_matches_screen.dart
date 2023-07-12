// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/live_matches_model.dart';
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

class LiveMatchesScreen extends StatefulWidget {
  const LiveMatchesScreen({Key? key}) : super(key: key);

  @override
  State<LiveMatchesScreen> createState() => _LiveMatchesScreenState();
}

class _LiveMatchesScreenState extends State<LiveMatchesScreen> {
  CurrentMatchesController controller = Get.put(CurrentMatchesController());

  Timer? time;

  bool setTime = false;

  @override
  void initState() {
    Timer(Duration(seconds: 3),(){
      setState(() {

      });
    });
    nativecall();

    if(mounted){
      Future.delayed(Duration(milliseconds: screenDelayTimer), () {
        setState(() {
          setTime = true;
        });
      });
    }

    if(mounted){
      time = Timer.periodic(const Duration(seconds: 7), (timer) {
          controller.getLiveMatchesData();
      });
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    bannercall(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    time?.cancel();
    bannerLoad = false;
    nativeLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return setTime == false
        ? Center(
            child: CupertinoActivityIndicator(
              color: Colors.red.shade900,
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // NativAdScreen(),

              nativeAdView(),
              Flexible(
                child: FutureBuilder(
                  future: controller.getLiveMatchesData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Text("No Data!",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 25)));
                    } else if (snapshot.hasData) {
                      LiveMatchesModel data = snapshot.data;
                      return data.typeMatches!.isEmpty
                          ? Center(
                              child: Text(
                              "No Match Live!",
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ))
                          : RefreshIndicator(
                              color: Colors.red,
                              onRefresh: () async {
                                controller.getLiveMatchesData();
                                setState(() {});
                              },
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: data.typeMatches?.length,
                                itemBuilder: (context, mt) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: data
                                        .typeMatches![mt].seriesMatches!.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            color: Colors.red.shade50,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Text(
                                                "${data.typeMatches![mt].seriesMatches![index].seriesAdWrapper?.seriesName}",
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: data
                                                  .typeMatches![mt]
                                                  .seriesMatches![index]
                                                  .seriesAdWrapper
                                                  ?.matches
                                                  ?.length,
                                              itemBuilder: (context, i) {
                                                return liveMatchesData(
                                                    data, mt, index, i);
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      if (index % 1 == 0) {
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
              // BannerAD()
              bannerAdView(),
            ],
          );
  }

  Widget liveMatchesData(
      LiveMatchesModel data, int matchtype, int index, int i) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(
        "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.startDate}"));

    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);

    String splitdata =
        "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team1Score?.inngs1?.overs}";

    var arr = splitdata.split('.');

    String splitdata2 =
        "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team2Score?.inngs1?.overs}";

    var array = splitdata2.split('.');
    return InkWell(
      onTap: () {
        Get.to(
          () => MatchDetailsScreen(
            index: 1,
            Id: '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.matchId}',
            state:
                '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.state}',
            t1: '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamSName}',
            t2: '${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamSName}',
          ),
        );
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
                        Obx(
                          () => Text(
                            "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.matchDesc} - ${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.venueInfo?.city}",
                            style: GoogleFonts.poppins(
                                color: Get.find<HomeController>()
                                            .themeChanger
                                            .value ==
                                        false
                                    ? Colors.grey.shade300
                                    : Colors.grey.shade600,
                                fontSize: 12.sp),
                          ),
                        ),
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
                                  "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team1?.teamName}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.visible),
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
                                  "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchInfo?.team2?.teamName}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.visible),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 35.w,
                  ),
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
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team1Score?.inngs1?.runs ?? 00}"
                                  "/${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team1Score?.inngs1?.wickets ?? 0}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                arr[1] == "6"
                                    ? Text(
                                        "(${int.parse(arr[0]) + 1})",
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey.shade600,
                                            fontSize: 13.sp),
                                      )
                                    : Text(
                                        "(${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team1Score?.inngs1?.overs ?? 00})",
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey.shade600,
                                            fontSize: 13.sp),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 32.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team2Score?.inngs1?.runs ?? 00}"
                                  "/${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team2Score?.inngs1?.wickets ?? 0}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600),
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
                                    ? Text(
                                        "(0.0)",
                                        style: GoogleFonts.poppins(
                                            color: Colors.grey.shade600,
                                            fontSize: 13.sp),
                                      )
                                    : array[1] == "6"
                                        ? Text(
                                            "(${int.parse(array[0]) + 1})",
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey.shade600,
                                                fontSize: 13.sp),
                                          )
                                        : Text(
                                            "(${data.typeMatches![matchtype].seriesMatches![index].seriesAdWrapper?.matches![i].matchScore?.team2Score?.inngs1?.overs ?? 00})",
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey.shade600,
                                                fontSize: 13.sp),
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
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                      fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

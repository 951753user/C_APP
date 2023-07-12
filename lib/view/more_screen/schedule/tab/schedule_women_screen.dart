import 'dart:async';
import 'dart:convert';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/schedule_matches_model.dart';
import 'package:cricbuzzapp/view/home_screen/home_controller.dart';
import 'package:cricbuzzapp/view/match_details/match_details.dart';
import 'package:cricbuzzapp/view/match_series_details/match_series_details_screen.dart';
import 'package:cricbuzzapp/view/more_screen/more_controller.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:cricbuzzapp/widgets/divider.dart';
import 'package:flutter/cupertino.dart' as ios;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ScheduleWomenScreen extends StatefulWidget {
  const ScheduleWomenScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleWomenScreen> createState() => _ScheduleWomenScreenState();
}

class _ScheduleWomenScreenState extends State<ScheduleWomenScreen> {
  MoreController controller = Get.put(MoreController());

  bool setTime = false;

  @override
  void initState() {

    Future.delayed(Duration(milliseconds: screenDelayTimer),() {
      setState(() {
        setTime = true;
      });
    });
    scrollController?.addListener(_scrollListener);
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
    controller.noMoreWomenData.value = false;
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController!.offset >=
            scrollController!.position.maxScrollExtent &&
        !scrollController!.position.outOfRange) {
      scrollindex++;
      debugPrint(
          "-------------------------------+++++++++++++++++++++++++++++*******************///////////////$scrollindex");
      _getData();
    }
  }

  ScrollController? scrollController = ScrollController();
  int scrollindex = 1;

  void _getData() async {

    if (scrollindex > 2) {
      if (controller.scrollWomenFirstId.value !=
          controller.scrollWomenLastId.value) {
        controller.getScheduleWomenMoreData(controller.scrollWomenLastId.value);
      }
      debugPrint(
          "this is scroll take ---------------${controller.scrollWomenLastId.value} -------------$scrollindex");
    } else {
      controller.getScheduleWomenMoreData(controller.womenLastId.value);
      print("123456789==================================================");
      debugPrint(
          "this is scroll take ---------------${controller.scrollWomenLastId.value} -------------$scrollindex");
    }
  }

  @override
  Widget build(BuildContext context) {
    return setTime == false?Center(
      child: ios.CupertinoActivityIndicator(
        color: Colors.red.shade900,
      ),
    ):Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        Flexible(
          child: SingleChildScrollView(
            controller: scrollController,
            // physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: FutureBuilder(
                    future: controller.getScheduleWomenData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("No Data"),
                        );
                      } else if (snapshot.hasData) {
                        ScheduleMatchesModel data = snapshot.data;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.matchScheduleMap?.length,
                          itemBuilder: (context, i) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: double.infinity,
                                  color: Colors.black12,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      "${data.matchScheduleMap![i].scheduleAdWrapper?.date}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: data
                                        .matchScheduleMap![i]
                                        .scheduleAdWrapper
                                        ?.matchScheduleList
                                        ?.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(
                                                () => MatchSeriesDetailsScreen(
                                                    seriesName:
                                                        "${data.matchScheduleMap![i].scheduleAdWrapper?.matchScheduleList![index].seriesName}",
                                                    seriesId:
                                                        "${data.matchScheduleMap![i].scheduleAdWrapper?.matchScheduleList![index].seriesId}"),
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              color: Colors.red.shade50,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 300.w,
                                                      child: Text(
                                                        "${data.matchScheduleMap![i].scheduleAdWrapper?.matchScheduleList![index].seriesName}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: data
                                                  .matchScheduleMap![i]
                                                  .scheduleAdWrapper
                                                  ?.matchScheduleList![index]
                                                  .matchInfo
                                                  ?.length,
                                              itemBuilder: (context, md) {
                                                controller.womenLastId.value =
                                                    "${data.matchScheduleMap?.last.scheduleAdWrapper?.matchScheduleList?.last.matchInfo?.last.endDate}";
                                                return upcomingMatchesData(
                                                    i, index, data, md);
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return Center(
                        child: ios.CupertinoActivityIndicator(
                          color: Colors.red[800],
                        ),
                      );
                    },
                  ),
                ),
                Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.moreScheduleWomenData.length +1 ,
                    itemBuilder: (context, i) {
                      if(i<controller.moreScheduleWomenData.length){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.black12,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.date}",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Flexible(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.moreScheduleWomenData[i]
                                    .scheduleAdWrapper?.matchScheduleList?.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                                () => MatchSeriesDetailsScreen(
                                                seriesName:
                                                "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList![index].seriesName}",
                                                seriesId:
                                                "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList![index].seriesId}"),
                                          );
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          color: Colors.red.shade50,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 300.w,
                                                  child: Text(
                                                    "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList![index].seriesName}",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.black,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: controller
                                              .moreScheduleWomenData[i]
                                              .scheduleAdWrapper
                                              ?.matchScheduleList![index]
                                              .matchInfo
                                              ?.length,
                                          itemBuilder: (context, md) {
                                            controller.scrollWomenFirstId.value =
                                            "${controller.moreScheduleWomenData.first.scheduleAdWrapper?.matchScheduleList.first.matchInfo?.first.endDate}";
                                            controller.scrollWomenLastId.value =
                                            "${controller.moreScheduleWomenData.last.scheduleAdWrapper?.matchScheduleList.last.matchInfo?.last.endDate}";

                                            var dt = DateTime
                                                .fromMillisecondsSinceEpoch(int.parse(
                                                "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].startDate}"));

// 12 Hour format:
                                            var d12 =
                                            DateFormat('dd/MM/yyyy, hh:mm a')
                                                .format(dt);

                                            var remid;
                                            var ptime;

                                            return InkWell(
                                              onTap: () {
                                                // Get.toNamed(AppPages.matchDetails);
                                                Get.to(MatchDetailsScreen(
                                                  Id: '${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].matchId}',
                                                  upcoming: true,
                                                  t1: '${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team1?.teamSName}',
                                                  t2: '${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team2?.teamSName}',
                                                ));
                                              },
                                              child: Card(
                                                elevation: 2,
                                                child: Container(
                                                  // height: 156.h,
                                                  width: 300.w,
                                                  // color: Colors.white,
                                                  child: Column(
                                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                // Text(
                                                                //   "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].seriesName}",
                                                                //   style: GoogleFonts.poppins(
                                                                //       fontSize: 13.sp,
                                                                //       color: Get.find<HomeController>()
                                                                //                   .themeChanger
                                                                //                   .value ==
                                                                //               false
                                                                //           ? Colors.grey.shade200
                                                                //           : Colors.grey.shade500),
                                                                // ),
                                                                // SizedBox(
                                                                //   height: 5.h,
                                                                // ),
                                                                Text(
                                                                  // "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].startDate}",
                                                                  "$d12",
                                                                  style: GoogleFonts.poppins(
                                                                      color: Get.find<HomeController>().themeChanger.value ==
                                                                          false
                                                                          ? Colors
                                                                          .grey
                                                                          .shade300
                                                                          : Colors
                                                                          .grey
                                                                          .shade500,
                                                                      fontSize:
                                                                      13.sp),
                                                                )
                                                              ],
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                print(DateTime
                                                                    .now());

                                                                //2023-03-30 11:53:50.321125

                                                                remid = DateTime
                                                                    .fromMillisecondsSinceEpoch(
                                                                    int.parse(
                                                                        "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].startDate}"));

                                                                ptime = DateFormat(
                                                                    'yyyy-MM-dd HH:mm:ss.000000')
                                                                    .format(
                                                                    remid);

                                                                compareReminderList
                                                                    .add({
                                                                  "$ptime":
                                                                  "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team1?.teamSName} vs ${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team2?.teamSName} at ${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].venueInfo?.ground}"
                                                                });

                                                                const storage =
                                                                FlutterSecureStorage();

                                                                await storage.write(
                                                                    key:
                                                                    "remind_compare",
                                                                    value: jsonEncode(
                                                                        compareReminderList));
                                                                setState(() {
                                                                  datafind =
                                                                      compareReminderList;
                                                                });
                                                              },
                                                              child: SizedBox(
                                                                height: 30.h,
                                                                width: 30.w,
                                                                child: Icon(
                                                                  datafind != null
                                                                      ? datafind.contains(
                                                                      "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team1?.teamSName} vs ${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team2?.teamSName} at ${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].venueInfo?.ground}")
                                                                      ? Icons
                                                                      .notifications_active_rounded
                                                                      : Icons
                                                                      .notifications_none
                                                                      : compareReminderList.contains(
                                                                      '${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team1?.teamSName} vs ${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team2?.teamSName} at ${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].venueInfo?.ground}')
                                                                      ? Icons
                                                                      .notifications_active_rounded
                                                                      : Icons
                                                                      .notifications_none,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
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

                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                10.w),
                                                            child: Row(
                                                              children: [
                                                                Image.network(
                                                                  controller.getImage(
                                                                      "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team1?.imageId}"),
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                SizedBox(
                                                                  width: 15.w,
                                                                ),
                                                                Text(
                                                                    "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team1?.teamSName}",
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontSize:
                                                                      15.sp,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                    ),
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            "VS",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                color: Colors
                                                                    .red[
                                                                700]),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                10.w),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team2?.teamSName}",
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontSize:
                                                                      16.sp,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                    ),
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                                SizedBox(
                                                                  width: 15.w,
                                                                ),
                                                                Image.network(
                                                                  controller.getImage(
                                                                      "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].team2?.imageId}"),
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
                                                        padding:
                                                        EdgeInsets.all(15.0),
                                                        child: Text(
                                                          "${controller.moreScheduleWomenData[i].scheduleAdWrapper?.matchScheduleList[index].matchInfo[md].venueInfo?.ground}",
                                                          style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                      // Container(
                                                      //   height: 52.h,
                                                      //   // width: 300.w,
                                                      //   color: Colors.grey.shade100,
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment.end,
                                                      //     children: [
                                                      //       TextButton(
                                                      //           onPressed: () {},
                                                      //           child: Text(
                                                      //             "POINTS TABLE",
                                                      //             style: GoogleFonts.poppins(
                                                      //                 color: Colors.grey.shade700,
                                                      //                 fontSize: 13.sp),
                                                      //           )),
                                                      //       TextButton(
                                                      //         onPressed: () {},
                                                      //         child: Text(
                                                      //           "SCHEDULE",
                                                      //           style: GoogleFonts.poppins(
                                                      //               color: Colors.grey.shade700,
                                                      //               fontSize: 13.sp),
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else{
                        return Obx(() => controller.noMoreWomenData.value == true?Container():Padding(
                            padding: EdgeInsets.symmetric(vertical: 25.h),
                            child: Center(child: ios.CupertinoActivityIndicator(color: Colors.red.shade900,radius: 15.sp,))));
                      }

                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // BannerAD(),
        bannerAdView(),
      ],
    );
  }

  Widget upcomingMatchesData(
      int index, int matchtype, ScheduleMatchesModel data, int i) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(
        "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].startDate}"));

// 12 Hour format:
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);

    var remid;
    var ptime;

    return InkWell(
      onTap: () {
        // Get.toNamed(AppPages.matchDetails);
        Get.to(MatchDetailsScreen(
          Id: '${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].matchId}',
          upcoming: true,
          t1: '${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team1?.teamSName}',
          t2: '${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team2?.teamSName}',
        ));
      },
      child: Card(
        elevation: 2,
        child: Container(
          // height: 156.h,
          width: 300.w,
          // color: Colors.white,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].seriesName}",
                        //   style: GoogleFonts.poppins(
                        //       fontSize: 13.sp,
                        //       color: Get.find<HomeController>()
                        //                   .themeChanger
                        //                   .value ==
                        //               false
                        //           ? Colors.grey.shade200
                        //           : Colors.grey.shade500),
                        // ),
                        // SizedBox(
                        //   height: 5.h,
                        // ),
                        Text(
                          // "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].startDate}",
                          "$d12",
                          style: GoogleFonts.poppins(
                              color: Get.find<HomeController>()
                                          .themeChanger
                                          .value ==
                                      false
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade500,
                              fontSize: 13.sp),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        print(DateTime.now());

                        //2023-03-30 11:53:50.321125

                        remid = DateTime.fromMillisecondsSinceEpoch(int.parse(
                            "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].startDate}"));

                        ptime = DateFormat('yyyy-MM-dd HH:mm:ss.000000')
                            .format(remid);

                        compareReminderList.add({
                          "$ptime":
                              "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team1?.teamSName} vs ${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team2?.teamSName} at ${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].venueInfo?.ground}"
                        });

                        const storage = FlutterSecureStorage();

                        await storage.write(
                            key: "remind_compare",
                            value: jsonEncode(compareReminderList));
                        setState(() {
                          datafind = compareReminderList;
                        });
                      },
                      child: SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: Icon(
                          datafind != null
                              ? datafind.contains(
                                      "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team1?.teamSName} vs ${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team2?.teamSName} at ${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].venueInfo?.ground}")
                                  ? Icons.notifications_active_rounded
                                  : Icons.notifications_none
                              : compareReminderList.contains(
                                      '${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team1?.teamSName} vs ${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team2?.teamSName} at ${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].venueInfo?.ground}')
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Image.network(
                          controller.getImage(
                              "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team1?.imageId}"),
                          height: 40.h,
                          width: 40.w,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                            "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team1?.teamSName}",
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
                            "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team2?.teamSName}",
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
                              "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].team2?.imageId}"),
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
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "${data.matchScheduleMap![index].scheduleAdWrapper?.matchScheduleList![matchtype].matchInfo![i].venueInfo?.ground}",
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              // Container(
              //   height: 52.h,
              //   // width: 300.w,
              //   color: Colors.grey.shade100,
              //   child: Row(
              //     mainAxisAlignment:
              //         MainAxisAlignment.end,
              //     children: [
              //       TextButton(
              //           onPressed: () {},
              //           child: Text(
              //             "POINTS TABLE",
              //             style: GoogleFonts.poppins(
              //                 color: Colors.grey.shade700,
              //                 fontSize: 13.sp),
              //           )),
              //       TextButton(
              //         onPressed: () {},
              //         child: Text(
              //           "SCHEDULE",
              //           style: GoogleFonts.poppins(
              //               color: Colors.grey.shade700,
              //               fontSize: 13.sp),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

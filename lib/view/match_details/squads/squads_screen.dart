import 'dart:async';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/squads_model.dart';
import 'package:cricbuzzapp/view/home_screen/home_controller.dart';
import 'package:cricbuzzapp/view/match_details/match_details_controller.dart';
import 'package:cricbuzzapp/view/player_details_screen.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SquadScreen extends StatefulWidget {
  final String matchId;
  final bool? upcoming;

  const SquadScreen({Key? key, required this.matchId, this.upcoming})
      : super(key: key);

  @override
  State<SquadScreen> createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
  MatchDetailsController controller = Get.put(MatchDetailsController());

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
    ):widget.upcoming == true
        ? Center(
            child: Text("No Data!",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 25)),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // NativAdScreen(),
              nativeAdView(),
              Flexible(
                child: FutureBuilder(
                  future: controller.getSquadData(widget.matchId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Text("No Data!",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 25)));
                      // return  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
                    } else if (snapshot.hasData) {
                      SquadsModel data = snapshot.data;
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),

                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              color: Colors.red.shade50,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          controller.playerImage(
                                              '${data.team1?.team?.imageId}'),
                                          height: 35.h,
                                          width: 35.w,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          "${data.team1?.team?.teamSName}",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              color: Colors.grey.shade700),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${data.team2?.team?.teamSName}",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              color: Colors.grey.shade700),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Image.network(
                                          controller.playerImage(
                                              '${data.team2?.team?.imageId}'),
                                          height: 35.h,
                                          width: 35.w,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  data.team1?.players?.squad?.isEmpty == true
                                      ? false
                                      : true,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "SQUAD",
                                      style:
                                          GoogleFonts.poppins(fontSize: 16.sp),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: ListView.builder(
                                          itemCount: data
                                              .team1?.players?.squad?.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Get.to(PlayerDetailsScreen(
                                                    playerId:
                                                        "${data.team1?.players?.squad?[index].id}",
                                                    playerName:
                                                        "${data.team1?.players?.squad?[index].fullName}"));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(5.sp),
                                                child: Container(
                                                  height: 50.h,
                                                  width: 100.h,
                                                  color:
                                                      Get.find<HomeController>()
                                                                  .themeChanger
                                                                  .value ==
                                                              true
                                                          ? Colors.black12
                                                          : Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(6.sp),
                                                    child: Row(
                                                      children: [
                                                        // CachedNetworkImage(
                                                        //   imageUrl: "http://via.placeholder.com/350x150",
                                                        //   imageBuilder: (context, imageProvider) => Container(
                                                        //     width: 80.h,
                                                        //     height: 80.0,
                                                        //     decoration: BoxDecoration(
                                                        //       shape: BoxShape.circle,
                                                        //       image: DecorationImage(
                                                        //           image: imageProvider, fit: BoxFit.cover),
                                                        //     ),
                                                        //   ),
                                                        //   placeholder: (context, url) => CupertinoActivityIndicator(),
                                                        //   errorWidget: (context, url, error) => Icon(Icons.error),
                                                        // ),
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(controller
                                                                  .playerImage(
                                                                      '${data.team1?.players?.squad![index].faceImageId}')),
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade50,
                                                          radius: 17.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        SizedBox(
                                                          width: 120.w,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${data.team1?.players?.squad![index].name}",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            12.sp),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              Text(
                                                                "${data.team1?.players?.squad![index].role}",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            12.sp),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: ListView.builder(
                                          itemCount: data
                                              .team2?.players?.squad?.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Get.to(PlayerDetailsScreen(
                                                    playerId:
                                                        "${data.team2?.players?.squad?[index].id}",
                                                    playerName:
                                                        "${data.team2?.players?.squad?[index].fullName}"));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(5.sp),
                                                child: Container(
                                                  height: 50.h,
                                                  width: 100.h,
                                                  color:
                                                      Get.find<HomeController>()
                                                                  .themeChanger
                                                                  .value ==
                                                              true
                                                          ? Colors.black12
                                                          : Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(6.sp),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(
                                                          width: 120.w,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                  "${data.team2?.players?.squad![index].name}",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          fontSize: 12
                                                                              .sp),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end),
                                                              Text(
                                                                  "${data.team2?.players?.squad![index].role}",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          fontSize: 12
                                                                              .sp),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end)
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(controller
                                                                  .playerImage(
                                                                      '${data.team2?.players?.squad![index].faceImageId}')),
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade50,
                                                          radius: 17.sp,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                                visible:
                                    data.team1?.players?.playingXi?.isEmpty ==
                                            true
                                        ? false
                                        : true,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "PLAYING XI",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: ListView.builder(
                                            itemCount: data.team1?.players
                                                ?.playingXi?.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.to(PlayerDetailsScreen(
                                                      playerId:
                                                          "${data.team1?.players?.playingXi?[index].id}",
                                                      playerName:
                                                          "${data.team1?.players?.playingXi?[index].fullName}"));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Container(
                                                    height: 50.h,
                                                    width: 100.h,
                                                    color:
                                                        Get.find<HomeController>()
                                                                    .themeChanger
                                                                    .value ==
                                                                true
                                                            ? Colors.black12
                                                            : Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(6.sp),
                                                      child: Row(
                                                        children: [
                                                          Hero(
                                                            tag: "avatar-${data.team1?.players?.playingXi![index].faceImageId}",
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(controller
                                                                      .playerImage(
                                                                          '${data.team1?.players?.playingXi![index].faceImageId}')),
                                                              backgroundColor:
                                                                  Colors.red
                                                                      .shade50,
                                                              radius: 17.sp,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 4.w,
                                                          ),
                                                          SizedBox(
                                                            width: 120.w,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "${data.team1?.players?.playingXi![index].name}",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          fontSize:
                                                                              12.sp),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Text(
                                                                  "${data.team1?.players?.playingXi![index].role}",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          fontSize:
                                                                              12.sp),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: ListView.builder(
                                            itemCount: data.team2?.players
                                                ?.playingXi?.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.to(PlayerDetailsScreen(
                                                      playerId:
                                                          "${data.team2?.players?.playingXi?[index].id}",
                                                      playerName:
                                                          "${data.team2?.players?.playingXi?[index].fullName}"));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Container(
                                                    height: 50.h,
                                                    width: 100.h,
                                                    color:
                                                        Get.find<HomeController>()
                                                                    .themeChanger
                                                                    .value ==
                                                                true
                                                            ? Colors.black12
                                                            : Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(6.sp),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          SizedBox(
                                                            width: 120.w,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                    "${data.team2?.players?.playingXi![index].name}",
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize: 12
                                                                            .sp),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end),
                                                                Text(
                                                                    "${data.team2?.players?.playingXi![index].role}",
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize: 12
                                                                            .sp),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end)
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 4.w,
                                                          ),
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(controller
                                                                    .playerImage(
                                                                        '${data.team2?.players?.playingXi![index].faceImageId}')),
                                                            backgroundColor:
                                                                Colors.red
                                                                    .shade50,
                                                            radius: 17.sp,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                            Visibility(
                              visible:
                                  data.team1?.players?.bench?.isEmpty == true
                                      ? false
                                      : true,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "BENCH",
                                      style:
                                          GoogleFonts.poppins(fontSize: 16.sp),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: ListView.builder(
                                          itemCount: data
                                              .team1?.players?.bench?.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Get.to(PlayerDetailsScreen(
                                                    playerId:
                                                        "${data.team1?.players?.bench?[index].id}",
                                                    playerName:
                                                        "${data.team1?.players?.bench?[index].fullName}"));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(5.sp),
                                                child: Container(
                                                  height: 50.h,
                                                  width: 100.h,
                                                  color:
                                                      Get.find<HomeController>()
                                                                  .themeChanger
                                                                  .value ==
                                                              true
                                                          ? Colors.black12
                                                          : Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(6.sp),
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(controller
                                                                  .playerImage(
                                                                      '${data.team1?.players?.bench![index].faceImageId}')),
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade50,
                                                          radius: 17.sp,
                                                        ),
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        SizedBox(
                                                          width: 120.w,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${data.team1?.players?.bench![index].name}",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            12.sp),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              Text(
                                                                "${data.team1?.players?.bench![index].role}",
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            12.sp),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: ListView.builder(
                                          itemCount: data
                                              .team2?.players?.bench?.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Get.to(PlayerDetailsScreen(
                                                    playerId:
                                                        "${data.team2?.players?.bench?[index].id}",
                                                    playerName:
                                                        "${data.team2?.players?.bench?[index].fullName}"));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(5.sp),
                                                child: Container(
                                                  height: 50.h,
                                                  width: 100.h,
                                                  color:
                                                      Get.find<HomeController>()
                                                                  .themeChanger
                                                                  .value ==
                                                              true
                                                          ? Colors.black12
                                                          : Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(6.sp),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(
                                                          width: 120.w,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                  "${data.team2?.players?.bench![index].name}",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          fontSize: 12
                                                                              .sp),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end),
                                                              Text(
                                                                  "${data.team2?.players?.bench![index].role}",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          fontSize: 12
                                                                              .sp),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end)
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(controller
                                                                  .playerImage(
                                                                      '${data.team2?.players?.bench![index].faceImageId}')),
                                                          backgroundColor:
                                                              Colors
                                                                  .red.shade50,
                                                          radius: 17.sp,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(
                        child: CupertinoActivityIndicator(
                      color: Colors.red[700],
                    ));
                  },
                ),
              ),
              // BannerAD()
              bannerAdView(),
            ],
          );
  }
}

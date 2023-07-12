import 'dart:async';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/model/scorecard_model.dart';
import 'package:cricbuzzapp/utils/banner_ad.dart';
import 'package:cricbuzzapp/utils/nativetwo.dart';
import 'package:cricbuzzapp/view/match_details/match_details_controller.dart';
import 'package:cricbuzzapp/view/player_details_screen.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:cricbuzzapp/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';

class ScoreBoardScreen extends StatefulWidget {
  final String matchId;
  final bool? upcoming;

  const ScoreBoardScreen({Key? key, required this.matchId, this.upcoming})
      : super(key: key);

  @override
  State<ScoreBoardScreen> createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends State<ScoreBoardScreen> {
  MatchDetailsController controller = Get.put(MatchDetailsController());
  Timer? time;

  bool setTime = false;

  @override
  void initState() {
    nativecall();

    Future.delayed(Duration(milliseconds: screenDelayTimer),() {
      setState(() {
        setTime = true;
      });
    });

    time = Timer.periodic(Duration(seconds: 5), (timer) {
      controller.getScorecardData(widget.matchId);
    });

    super.initState();
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

      children: [
        // NativAdScreen(),
        nativeAdView(),
        Flexible(
          child: widget.upcoming == true
              ?  Center(
                  child: Text("No Data!",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 25)),
                )
              : FutureBuilder(
                  future: controller.getScorecardData(widget.matchId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
                    } else if (snapshot.hasData) {
                      ScorecardModel data = snapshot.data;
                      return data.scoreCard!.isEmpty
                          ?  Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Match Not Started!",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                            )
                          : data.scoreCard!.isEmpty
                              ? Container()
                              : SingleChildScrollView(
                                // physics: BouncingScrollPhysics(),

                                child: Column(
                                    children: [


                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          // color: Colors.grey,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: ExpansionTile(
                                              iconColor: Colors.red[200],
                                              initiallyExpanded: true,
                                              collapsedIconColor: Colors.red[900],
                                              collapsedTextColor:
                                                  Colors.grey.shade600,
                                              textColor: Colors.grey.shade600,
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      "${data.scoreCard![0].batTeamDetails?.batTeamName}",
                                                      style: GoogleFonts.poppins(
                                                          // color: Colors.white,
                                                          fontSize: 17.sp,
                                                          fontWeight: FontWeight.w500,),
                                                        overflow: TextOverflow.ellipsis
                                                    ),
                                                  ),
                                                  Text(
                                                    "${data.scoreCard![0].scoreDetails?.runs}-${data.scoreCard![0].scoreDetails?.wickets} (${data.scoreCard![0].scoreDetails?.overs})",
                                                    style: GoogleFonts.poppins(
                                                        // color: Colors.white,
                                                        fontSize: 15.sp),
                                                  ),
                                                ],
                                              ),
                                              children: [
                                                SizedBox(
                                                  height: 600.h,
                                                  child: ListView.builder(
                                                    itemCount: 1,
                                                    itemBuilder: (context, index) {
                                                      return Column(
                                                        children: [
                                                          SingleChildScrollView(

                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: DataTable(
                                                              headingRowColor:
                                                                  MaterialStateColor
                                                                      .resolveWith(
                                                                          (states) =>
                                                                              Colors
                                                                                  .red
                                                                                  .shade50),
                                                              columnSpacing: 17,
                                                              columns:  [
                                                                DataColumn(
                                                                  label: Text(
                                                                    "Batter",
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    "R",
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    "B",
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    "4s",
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    "6s",
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text(
                                                                    "SR",
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                              ],
                                                              rows: List.generate(
                                                                  data
                                                                      .scoreCard![0]
                                                                      .batTeamDetails!
                                                                      .batsmenData!
                                                                      .length,
                                                                  (index) {
                                                                return DataRow(
                                                                  cells: [
                                                                    DataCell(
                                                                      InkWell(
                                                                        onTap: () {
                                                                          Get.to(PlayerDetailsScreen(
                                                                              playerId:
                                                                                  "${data.scoreCard![0].batTeamDetails!.batsmenData![index].batId}",
                                                                              playerName:
                                                                                  "${data.scoreCard![0].batTeamDetails!.batsmenData![index].batName}"));
                                                                        },
                                                                        child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment
                                                                                  .center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                          children: [
                                                                            Text(
                                                                                "${data.scoreCard![0].batTeamDetails?.batsmenData?[index].batName}",style: GoogleFonts.poppins()),
                                                                            SizedBox(
                                                                              width:
                                                                                  100.w,
                                                                              child:
                                                                                  Text(
                                                                                "${data.scoreCard![0].batTeamDetails?.batsmenData?[index].outDesc}",
                                                                                overflow:
                                                                                    TextOverflow.ellipsis,
                                                                                style:
                                                                                    GoogleFonts.poppins(color: Colors.grey.shade600),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataCell(Text(
                                                                        "${data.scoreCard![0].batTeamDetails?.batsmenData?[index].runs}",style: GoogleFonts.poppins())),
                                                                    DataCell(Text(
                                                                        "${data.scoreCard![0].batTeamDetails?.batsmenData?[index].balls}",style: GoogleFonts.poppins())),
                                                                    DataCell(Text(
                                                                        "${data.scoreCard![0].batTeamDetails?.batsmenData?[index].fours}",style: GoogleFonts.poppins())),
                                                                    DataCell(Text(
                                                                        "${data.scoreCard![0].batTeamDetails?.batsmenData?[index].sixes}",style: GoogleFonts.poppins())),
                                                                    DataCell(Text(
                                                                        "${data.scoreCard![0].batTeamDetails?.batsmenData?[index].strikeRate}",style: GoogleFonts.poppins())),
                                                                  ],
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                          const Divider(
                                                            thickness: 3,
                                                          ),
                                                          SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: DataTable(
                                                              headingRowColor:
                                                                  MaterialStateColor
                                                                      .resolveWith(
                                                                          (states) =>
                                                                              Colors
                                                                                  .red
                                                                                  .shade50),
                                                              columnSpacing: 30,
                                                              columns:  [
                                                                DataColumn(
                                                                  label: Text(
                                                                    "Bowler",
                                                                    style: GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                DataColumn(
                                                                  label: Text("O",
                                                                      style: GoogleFonts.poppins(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color: Colors
                                                                              .black)),
                                                                ),
                                                                DataColumn(
                                                                  label: Text("M",
                                                                      style: GoogleFonts.poppins(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color: Colors
                                                                              .black)),
                                                                ),
                                                                DataColumn(
                                                                  label: Text("R",
                                                                      style: GoogleFonts.poppins(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color: Colors
                                                                              .black)),
                                                                ),
                                                                DataColumn(
                                                                  label: Text("W",
                                                                      style: GoogleFonts.poppins(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color: Colors
                                                                              .black)),
                                                                ),
                                                                DataColumn(
                                                                  label: Text("ER",
                                                                      style: GoogleFonts.poppins(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color: Colors
                                                                              .black)),
                                                                ),
                                                              ],
                                                              rows: List.generate(
                                                                  data
                                                                      .scoreCard![0]
                                                                      .bowlTeamDetails!
                                                                      .bowlersData!
                                                                      .length,
                                                                  (index) {
                                                                return DataRow(
                                                                  cells: [
                                                                    DataCell(
                                                                      InkWell(
                                                                        onTap: () {
                                                                          Get.to(PlayerDetailsScreen(
                                                                              playerId:
                                                                                  "${data.scoreCard![0].bowlTeamDetails!.bowlersData![index].bowlerId}",
                                                                              playerName:
                                                                                  "${data.scoreCard![0].bowlTeamDetails!.bowlersData![index].bowlName}"));
                                                                        },
                                                                        child: Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment
                                                                                  .spaceEvenly,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                          children: [
                                                                            Text(
                                                                                "${data.scoreCard?[0].bowlTeamDetails?.bowlersData?[index].bowlName}",style: GoogleFonts.poppins()),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    DataCell(Text(
                                                                        "${data.scoreCard?[0].bowlTeamDetails?.bowlersData?[index].overs}",style: GoogleFonts.poppins())),
                                                                    DataCell(Text(
                                                                        "${data.scoreCard?[0].bowlTeamDetails?.bowlersData?[index].maidens}",style: GoogleFonts.poppins())),
                                                                    DataCell(Text(
                                                                        "${data.scoreCard?[0].bowlTeamDetails?.bowlersData?[index].runs}",style: GoogleFonts.poppins())),
                                                                    DataCell(Text(
                                                                        "${data.scoreCard?[0].bowlTeamDetails?.bowlersData?[index].wickets}",style: GoogleFonts.poppins())),
                                                                    DataCell(Text(
                                                                        "${data.scoreCard?[0].bowlTeamDetails?.bowlersData?[index].economy}",style: GoogleFonts.poppins())),
                                                                  ],
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      data.scoreCard!.length == 1
                                          ? Text("")
                                          : Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                // color: Colors.grey,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: ExpansionTile(
                                                    iconColor: Colors.red[200],
                                                    initiallyExpanded: true,
                                                    collapsedIconColor:
                                                        Colors.red[900],
                                                    collapsedTextColor:
                                                        Colors.grey.shade600,
                                                    textColor: Colors.grey.shade600,

                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            "${data.scoreCard![1].batTeamDetails?.batTeamName}",
                                                            style: GoogleFonts.poppins(
                                                                // color: Colors.white,
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight.w500,),
                                                              overflow: TextOverflow.ellipsis
                                                          ),
                                                        ),
                                                        Text(
                                                          "${data.scoreCard![1].scoreDetails?.runs}-${data.scoreCard![1].scoreDetails?.wickets} (${data.scoreCard![1].scoreDetails?.overs})",
                                                          style: GoogleFonts.poppins(
                                                              // color: Colors.white,
                                                              fontSize: 15.sp),
                                                        ),
                                                      ],
                                                    ),

                                                    children: [
                                                      SizedBox(
                                                        height: 500.h,
                                                        child: ListView.builder(
                                                          itemCount: 1,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Column(
                                                                children: [
                                                                  DataTable(
                                                                    headingRowColor:
                                                                        MaterialStateColor.resolveWith(
                                                                            (states) =>
                                                                                Colors
                                                                                    .red
                                                                                    .shade50),
                                                                    columnSpacing: 17,
                                                                    columns:  [
                                                                      DataColumn(
                                                                        label: Text(
                                                                            "Batter",
                                                                            style: GoogleFonts.poppins(
                                                                                fontWeight: FontWeight
                                                                                    .bold,
                                                                                color:
                                                                                    Colors.black)),
                                                                      ),
                                                                      DataColumn(
                                                                        label: Text(
                                                                            "R",
                                                                            style: GoogleFonts.poppins(
                                                                                fontWeight: FontWeight
                                                                                    .bold,
                                                                                color:
                                                                                    Colors.black)),
                                                                      ),
                                                                      DataColumn(
                                                                        label: Text(
                                                                            "B",
                                                                            style: GoogleFonts.poppins(
                                                                                fontWeight: FontWeight
                                                                                    .bold,
                                                                                color:
                                                                                    Colors.black)),
                                                                      ),
                                                                      DataColumn(
                                                                        label: Text(
                                                                            "4s",
                                                                            style: GoogleFonts.poppins(
                                                                                fontWeight: FontWeight
                                                                                    .bold,
                                                                                color:
                                                                                    Colors.black)),
                                                                      ),
                                                                      DataColumn(
                                                                        label: Text(
                                                                            "6s",
                                                                            style: GoogleFonts.poppins(
                                                                                fontWeight: FontWeight
                                                                                    .bold,
                                                                                color:
                                                                                    Colors.black)),
                                                                      ),
                                                                      DataColumn(
                                                                        label: Text(
                                                                            "SR",
                                                                            style: GoogleFonts.poppins(
                                                                                fontWeight: FontWeight
                                                                                    .bold,
                                                                                color:
                                                                                    Colors.black)),
                                                                      ),
                                                                    ],
                                                                    rows: List.generate(
                                                                        data
                                                                            .scoreCard![
                                                                                1]
                                                                            .batTeamDetails!
                                                                            .batsmenData!
                                                                            .length,
                                                                        (index) {
                                                                      return DataRow(
                                                                        cells: [
                                                                          DataCell(
                                                                            InkWell(
                                                                              onTap:
                                                                                  () {
                                                                                Get.to(PlayerDetailsScreen(
                                                                                    playerId: "${data.scoreCard![1].batTeamDetails!.batsmenData![index].batId}",
                                                                                    playerName: "${data.scoreCard![1].batTeamDetails!.batsmenData![index].batName}"));
                                                                              },
                                                                              child:
                                                                                  Column(
                                                                                mainAxisAlignment:
                                                                                    MainAxisAlignment.spaceEvenly,
                                                                                crossAxisAlignment:
                                                                                    CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text("${data.scoreCard?[1].batTeamDetails?.batsmenData?[index].batName}",style: GoogleFonts.poppins()),
                                                                                  Container(
                                                                                    width: 130.w,
                                                                                    child: Text(
                                                                                      "${data.scoreCard?[1].batTeamDetails?.batsmenData?[index].outDesc}",
                                                                                      style: GoogleFonts.poppins(
                                                                                      ),
                                                                                        overflow: TextOverflow.ellipsis
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          DataCell(Text(
                                                                              "${data.scoreCard?[1].batTeamDetails?.batsmenData?[index].runs}",style: GoogleFonts.poppins())),
                                                                          DataCell(Text(
                                                                              "${data.scoreCard?[1].batTeamDetails?.batsmenData?[index].balls}",style: GoogleFonts.poppins())),
                                                                          DataCell(Text(
                                                                              "${data.scoreCard?[1].batTeamDetails?.batsmenData?[index].fours}",style: GoogleFonts.poppins())),
                                                                          DataCell(Text(
                                                                              "${data.scoreCard?[1].batTeamDetails?.batsmenData?[index].sixes}",style: GoogleFonts.poppins())),
                                                                          DataCell(Text(
                                                                              "${data.scoreCard?[1].batTeamDetails?.batsmenData?[index].strikeRate}",style: GoogleFonts.poppins())),
                                                                        ],
                                                                      );
                                                                    }),
                                                                  ),
                                                                  Divider(
                                                                    thickness: 4,
                                                                  ),
                                                                  SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: DataTable(
                                                                      headingRowColor:
                                                                          MaterialStateColor.resolveWith(
                                                                              (states) => Colors
                                                                                  .red
                                                                                  .shade50),
                                                                      columnSpacing:
                                                                          17,
                                                                      columns:  [
                                                                        DataColumn(
                                                                          label: Text(
                                                                            "Bowler",
                                                                            style: GoogleFonts.poppins(
                                                                                fontWeight: FontWeight
                                                                                    .bold,
                                                                                color:
                                                                                    Colors.black),
                                                                          ),
                                                                        ),
                                                                        DataColumn(
                                                                          label: Text(
                                                                              "O",
                                                                              style: GoogleFonts.poppins(
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                  color: Colors.black)),
                                                                        ),
                                                                        DataColumn(
                                                                          label: Text(
                                                                              "M",
                                                                              style: GoogleFonts.poppins(
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                  color: Colors.black)),
                                                                        ),
                                                                        DataColumn(
                                                                          label: Text(
                                                                              "R",
                                                                              style: GoogleFonts.poppins(
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                  color: Colors.black)),
                                                                        ),
                                                                        DataColumn(
                                                                          label: Text(
                                                                              "W",
                                                                              style: GoogleFonts.poppins(
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                  color: Colors.black)),
                                                                        ),
                                                                        DataColumn(
                                                                          label: Text(
                                                                              "ER",
                                                                              style: GoogleFonts.poppins(
                                                                                  fontWeight:
                                                                                      FontWeight.bold,
                                                                                  color: Colors.black)),
                                                                        ),
                                                                      ],
                                                                      rows: List.generate(
                                                                          data
                                                                              .scoreCard![
                                                                                  1]
                                                                              .bowlTeamDetails!
                                                                              .bowlersData!
                                                                              .length,
                                                                          (index) {
                                                                        return DataRow(
                                                                          cells: [
                                                                            DataCell(
                                                                              InkWell(
                                                                                onTap:
                                                                                    () {
                                                                                  Get.to(PlayerDetailsScreen(
                                                                                      playerId: "${data.scoreCard![1].bowlTeamDetails!.bowlersData![index].bowlerId}",
                                                                                      playerName: "${data.scoreCard![1].bowlTeamDetails!.bowlersData![index].bowlName}"));
                                                                                },
                                                                                child:
                                                                                    Column(
                                                                                  mainAxisAlignment:
                                                                                      MainAxisAlignment.spaceEvenly,
                                                                                  crossAxisAlignment:
                                                                                      CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text("${data.scoreCard?[1].bowlTeamDetails?.bowlersData?[index].bowlName}",style: GoogleFonts.poppins()),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            DataCell(Text(
                                                                                "${data.scoreCard?[1].bowlTeamDetails?.bowlersData?[index].overs}",style: GoogleFonts.poppins())),
                                                                            DataCell(Text(
                                                                                "${data.scoreCard?[1].bowlTeamDetails?.bowlersData?[index].maidens}",style: GoogleFonts.poppins())),
                                                                            DataCell(Text(
                                                                                "${data.scoreCard?[1].bowlTeamDetails?.bowlersData?[index].runs}",style: GoogleFonts.poppins())),
                                                                            DataCell(Text(
                                                                                "${data.scoreCard?[1].bowlTeamDetails?.bowlersData?[index].wickets}",style: GoogleFonts.poppins())),
                                                                            DataCell(Text(
                                                                                "${data.scoreCard?[1].bowlTeamDetails?.bowlersData?[index].economy}",style: GoogleFonts.poppins())),
                                                                          ],
                                                                        );
                                                                      }),
                                                                    ),
                                                                  ),
                                                                  Divider(
                                                                    thickness: 5,
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),

                                    ],
                                  ),
                                );
                    }
                    return Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.red[700],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

}

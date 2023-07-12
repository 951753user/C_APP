import 'dart:async';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/commentarymodel.dart';
import 'package:cricbuzzapp/model/commentarytwomodel.dart';
import 'package:cricbuzzapp/utils/banner_ad.dart';
import 'package:cricbuzzapp/view/match_details/match_details_controller.dart';
import 'package:cricbuzzapp/view/player_details_screen.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:cricbuzzapp/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:styled_text/styled_text.dart';

class LiveScreen extends StatefulWidget {
  final String Id;
  final String? stste;
  final bool? upcoming;

  const LiveScreen({Key? key, required this.Id, this.upcoming, this.stste})
      : super(key: key);

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  MatchDetailsController controller = Get.put(MatchDetailsController());

  Timer? time;

  bool setTime = false;

  @override
  void initState() {
    print(widget.Id);
    print(widget.stste);

    nativecall();



    Future.delayed(Duration(milliseconds: screenDelayTimer),() {
      setState(() {
        setTime = true;
      });
    });

    scrollController?.addListener(_scrollListener);

    time = Timer.periodic(const Duration(seconds: 7), (timer) {
        controller.commentaryapi(widget.Id);
    });
    super.initState();
  }

  void _scrollListener() {
    if (scrollController!.offset >=
            scrollController!.position.maxScrollExtent &&
        !scrollController!.position.outOfRange) {
      scrollindex++;
      debugPrint(
          "++++++++++++--------------***********////////////$scrollindex");
      _getData();
    }
  }

  String inningId = '';
  String timeStamp = '';
  String firstscrollId = "";
  String firstscrollTimeStamp = "";

  // String newdataId = '';
  // String newTimeStamp = "";


  @override
  void didChangeDependencies() {
    bannercall(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return setTime == false?Center(
      child: CupertinoActivityIndicator(
        color: Colors.red.shade900,
      ),
    ):RefreshIndicator(
        color: Colors.red,
        onRefresh: () async {
          // controller.matchdetailapi(widget.Id);
          controller.commentaryapi(widget.Id);
          controller.commentarytwoapi(widget.Id);
          setState(() {});
        },
        child: widget.stste == "Complete" ||
                widget.stste == "In Progress" ||
                widget.stste == "Innings Break" ||
                widget.stste == "State.COMPLETE" ||
                widget.stste == "Rain" ||
                widget.stste == "Stumps"
            ? live()
            : nolive());
  }

  Widget live() {
    return widget.upcoming == true
        ? Center(
            child: Text("No Data!!",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 25)),
          )
        : FutureBuilder(
            future: controller.commentaryapi(widget.Id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "No Data!",
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ));
              } else if (snapshot.hasData) {
                CommentaryModel data = snapshot.data;

                String splitdata =
                    "${data.miniscore!.matchScoreDetails!.inningsScoreList!.isEmpty ? '' : data.miniscore?.matchScoreDetails?.inningsScoreList?[0].overs}";

                var arr = splitdata.split('.');

                String splitdata2 =
                    "${data.miniscore?.matchScoreDetails?.inningsScoreList?.length == 1 || data.miniscore!.matchScoreDetails!.inningsScoreList!.isEmpty ? "" : data.miniscore?.matchScoreDetails?.inningsScoreList?[1].overs}";

                var array = splitdata2.split('.');

                return Column(
                  children: [
                    data.miniscore!.matchScoreDetails!.inningsScoreList!.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "${data.miniscore!.matchScoreDetails!.customStatus!}",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 15.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 55.w,
                                            child: Text(
                                              "${data.miniscore?.matchScoreDetails?.inningsScoreList?[0].batTeamName}",
                                              style: GoogleFonts.poppins(
                                                fontSize: 22.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          Text(
                                            "${data.miniscore?.matchScoreDetails?.inningsScoreList?[0].score}-${data.miniscore?.matchScoreDetails?.inningsScoreList?[0].wickets}  (${arr[1] == "6" ? int.parse(arr[0]) + 1 : data.miniscore?.matchScoreDetails?.inningsScoreList?[0].overs})",
                                            style: GoogleFonts.poppins(
                                              fontSize: 22.sp,
                                            ),
                                          ),
                                          Spacer(),
                                          Column(
                                            children: [
                                              Text(
                                                "CRR",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey.shade600,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(height: 2.h),
                                              Text(
                                                "${data.miniscore?.currentRunRate}",
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      data.miniscore?.matchScoreDetails
                                                  ?.inningsScoreList?.length ==
                                              1
                                          ? Container()
                                          : Row(
                                              children: [
                                                SizedBox(
                                                  width: 55.w,
                                                  child: Text(
                                                    "${data.miniscore?.matchScoreDetails?.inningsScoreList?[1].batTeamName}",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 22.sp,
                                                        color: Colors
                                                            .grey.shade600),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Text(
                                                  "${data.miniscore?.matchScoreDetails?.inningsScoreList?[1].score}-${data.miniscore?.matchScoreDetails?.inningsScoreList?[1].wickets} "
                                                  " (${data.miniscore?.matchScoreDetails?.inningsScoreList?[1].overs == null ? 0.0 : array[1] == "6" ? int.parse(array[0]) + 1 : data.miniscore?.matchScoreDetails?.inningsScoreList?[1].overs})",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 22.sp,
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                              ],
                                            ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        "${data.miniscore?.matchScoreDetails?.customStatus}",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                    divider(),
                    // NativAdScreen(),
                    nativeAdView(),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
                        child: ListView.builder(
                          // shrinkWrap: true,
                          controller: scrollController,
                          // physics: BouncingScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                widget.stste == "Complete"||
                                    widget.stste == "State.COMPLETE"?Container():DataTable(
                                  columnSpacing: 20,
                                  headingRowColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.red.shade50),
                                  headingRowHeight: 30.h,
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        "Batter",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "R",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "B",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "4s",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "6s",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "SR",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                  rows: [
                                    DataRow(
                                      cells: [
                                        DataCell(SizedBox(
                                            width: 120.w,
                                            child: Text(
                                              "${data.miniscore?.batsmanStriker?.batName}",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                        DataCell(Text(
                                            "${data.miniscore?.batsmanStriker?.batRuns}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold))),
                                        DataCell(Text(
                                            "${data.miniscore?.batsmanStriker?.batBalls}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold))),
                                        DataCell(Text(
                                            "${data.miniscore?.batsmanStriker?.batFours}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold))),
                                        DataCell(Text(
                                            "${data.miniscore?.batsmanStriker?.batSixes}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold))),
                                        DataCell(Text(
                                            "${data.miniscore?.batsmanStriker?.batStrikeRate}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold))),
                                      ],
                                    ),
                                    DataRow(
                                      cells: [
                                        DataCell(SizedBox(
                                            width: 120.w,
                                            child: Text(
                                              "${data.miniscore?.batsmanNonStriker?.batName}",
                                              style: GoogleFonts.poppins(),
                                            ))),
                                        DataCell(Text(
                                            "${data.miniscore?.batsmanNonStriker?.batRuns}",
                                            style: GoogleFonts.poppins())),
                                        DataCell(Text(
                                            "${data.miniscore?.batsmanNonStriker?.batBalls}",
                                            style: GoogleFonts.poppins())),
                                        DataCell(Text(
                                            "${data.miniscore?.batsmanNonStriker?.batFours}",
                                            style: GoogleFonts.poppins())),
                                        DataCell(Text(
                                            "${data.miniscore?.batsmanNonStriker?.batSixes}",
                                            style: GoogleFonts.poppins())),
                                        DataCell(Text(
                                            "${data.miniscore?.batsmanNonStriker?.batStrikeRate}",
                                            style: GoogleFonts.poppins())),
                                      ],
                                    ),
                                  ],
                                ),
                                widget.stste == "Complete"||
                                    widget.stste == "State.COMPLETE"?Container():DataTable(
                                  headingRowColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.red.shade50),
                                  columnSpacing: 23,
                                  dataRowHeight: 35.h,
                                  headingRowHeight: 30.h,
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        "Bowler",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "O",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "M",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "R",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "W",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "ER",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                  rows: [
                                    DataRow(
                                      cells: [
                                        DataCell(SizedBox(
                                            width: 120.w,
                                            child: Text(
                                                "${data.miniscore?.bowlerStriker?.bowlName}",
                                                style: GoogleFonts.poppins()))),
                                        DataCell(Text(
                                            "${data.miniscore?.bowlerStriker?.bowlOvs}",
                                            style: GoogleFonts.poppins())),
                                        DataCell(Text(
                                            "${data.miniscore?.bowlerStriker?.bowlMaidens}",
                                            style: GoogleFonts.poppins())),
                                        DataCell(Text(
                                            "${data.miniscore?.bowlerStriker?.bowlRuns}",
                                            style: GoogleFonts.poppins())),
                                        DataCell(Text(
                                            "${data.miniscore?.bowlerStriker?.bowlWkts}",
                                            style: GoogleFonts.poppins())),
                                        DataCell(Text(
                                            "${data.miniscore?.bowlerStriker?.bowlEcon}",
                                            style: GoogleFonts.poppins())),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                divider(),
                                data.matchHeader!.playersOfTheMatch!.isEmpty
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            top: 8,
                                            right: 15,
                                            bottom: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "PLAYER OF THE MATCH",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15.sp),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(PlayerDetailsScreen(
                                                    playerId:
                                                        "${data.matchHeader?.playersOfTheMatch?[index].id}",
                                                    playerName:
                                                        "${data.matchHeader?.playersOfTheMatch?[index].name}"));
                                              },
                                              child: Row(
                                                children: [

                                                  CircleAvatar(
                                                    backgroundImage:
                                                    NetworkImage(controller
                                                        .playerImage(
                                                        '${data.matchHeader?.playersOfTheMatch?[index].faceImageId}')),
                                                    backgroundColor:
                                                    Colors
                                                        .red.shade50,
                                                    radius: 25.sp,
                                                  ),

                                                  // Container(
                                                  //   height: 60.h,
                                                  //   width: 60.w,
                                                  //   decoration:
                                                  //       const BoxDecoration(
                                                  //           shape:
                                                  //               BoxShape.circle),
                                                  //   child: Image.network(
                                                  //       controller.playerImage(
                                                  //           "${data.matchHeader?.playersOfTheMatch?[index].faceImageId}")),
                                                  // ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  Text(
                                                    "${data.matchHeader?.playersOfTheMatch?[index].fullName}",
                                                    style: GoogleFonts.poppins(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            const Divider(
                                              thickness: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                data.matchHeader!.playersOfTheSeries!.isEmpty
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            top: 8,
                                            right: 15,
                                            bottom: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "PLAYER OF THE SERIES",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15.sp),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(PlayerDetailsScreen(
                                                    playerId:
                                                        "${data.matchHeader?.playersOfTheSeries?[index].id}",
                                                    playerName:
                                                        "${data.matchHeader?.playersOfTheSeries?[index].name}"));
                                              },
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 50.h,
                                                    width: 50.w,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle),
                                                    child: Image.network(
                                                        controller.playerImage(
                                                            "${data.matchHeader?.playersOfTheSeries?[index].faceImageId}")),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  Text(
                                                      "${data.matchHeader?.playersOfTheSeries?[index].fullName}",
                                                      style:
                                                          GoogleFonts.poppins()),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            const Divider(
                                              thickness: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                // scrollindex != 1?scrollindex > 2?Container():CupertinoActivityIndicator(color: Colors.red[800],):
                                Flexible(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: data.commentaryList?.length,
                                    itemBuilder: (context, index) {
                                      inningId =
                                          "${data.commentaryList?.last.inningsId}";
                                      timeStamp =
                                          "${data.commentaryList?.last.timestamp}";


                                      String splitdata =
                                          "${data.commentaryList![index].overNumber}";

                                      var arr = splitdata.split('.');

                                      var text =
                                          data.commentaryList![index].commText;

                                      if (data.commentaryList![index]
                                              .commentaryFormats!.bold ==
                                          null) {
                                        text =
                                            data.commentaryList![index].commText;
                                      } else {
                                        for (var i = 0;
                                            i <
                                                data
                                                    .commentaryList![index]
                                                    .commentaryFormats!
                                                    .bold!
                                                    .formatId!
                                                    .length;
                                            i++) {
                                          text = text?.replaceAllMapped(
                                              "${data.commentaryList![index].commentaryFormats!.bold?.formatId![i]}",
                                              (match) =>
                                                  "<bold>${data.commentaryList![index].commentaryFormats!.bold?.formatValue![i]} </bold>");

                                          text = text?.replaceAllMapped(
                                              "\\n", (match) => "\n");
                                        }
                                      }
                                      // }

                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.w,
                                            right: 15.w,
                                            top: 10.h,
                                            bottom: 10.h),
                                        child: Column(
                                          children: [
                                            data.commentaryList![index]
                                                        .overSeparator ==
                                                    null
                                                ? Container()
                                                : Padding(
                                                    padding: EdgeInsets.all(8.sp),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 90.w,
                                                              child: Text(
                                                                "OVER  ${int.parse(arr[0]) + 1}",
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                "${data.commentaryList![index].overSeparator?.oSummary} (${data.commentaryList![index].overSeparator?.runs} RUNS)",
                                                                maxLines: 2,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
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
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "${data.commentaryList![index].overSeparator?.batTeamName}"),
                                                                Text(
                                                                    "${data.commentaryList![index].overSeparator?.score}/${data.commentaryList![index].overSeparator?.wickets}")
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "${data.commentaryList![index].overSeparator?.batStrikerNames![0]}"),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Text(
                                                                    "${data.commentaryList![index].overSeparator?.batNonStrikerNames![0]}"),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Text(
                                                                    "${data.commentaryList![index].overSeparator?.bowlNames![0]}")
                                                              ],
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                    "${data.commentaryList![index].overSeparator?.batStrikerRuns}(${data.commentaryList![index].overSeparator?.batStrikerBalls})"),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Text(
                                                                    "${data.commentaryList![index].overSeparator?.batNonStrikerRuns}(${data.commentaryList![index].overSeparator?.batNonStrikerBalls})"),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Text(
                                                                    "${data.commentaryList![index].overSeparator?.bowlRuns}-${data.commentaryList![index].overSeparator?.bowlWickets}")
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        divider()
                                                      ],
                                                    ),
                                                  ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width: data
                                                                .commentaryList?[
                                                                    index]
                                                                .overNumber ==
                                                            null
                                                        ? 0
                                                        : 60.w,
                                                    child: data
                                                                .commentaryList?[
                                                                    index]
                                                                .overNumber ==
                                                            null
                                                        ? Container()
                                                        : Column(
                                                            children: [
                                                              Text(
                                                                "${data.commentaryList?[index].overNumber}",
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              if (data
                                                                  .commentaryList![
                                                                      index]
                                                                  .event!
                                                                  .contains(
                                                                      "FOUR"))
                                                                Container(
                                                                  height: 20.h,
                                                                  width: 20.w,
                                                                  child: Image.asset(
                                                                      "assets/image/four.png"),
                                                                ),
                                                              if (data
                                                                  .commentaryList![
                                                                      index]
                                                                  .event!
                                                                  .contains(
                                                                      "SIX"))
                                                                Container(
                                                                  height: 20.h,
                                                                  width: 20.w,
                                                                  child: Image.asset(
                                                                      "assets/image/six.png"),
                                                                ),
                                                              if (data
                                                                  .commentaryList![
                                                                      index]
                                                                  .event!
                                                                  .contains(
                                                                      "WICKET"))
                                                                Container(
                                                                  height: 20.h,
                                                                  width: 20.w,
                                                                  child:
                                                                      Image.asset(
                                                                    "assets/image/wicket.png",
                                                                    color: Colors
                                                                        .red[800],
                                                                  ),
                                                                )
                                                            ],
                                                          )),
                                                data.commentaryList![index]
                                                            .commentaryFormats !=
                                                        null
                                                    ? Flexible(
                                                        child: StyledText(
                                                          text: "$text",
                                                          style:
                                                              GoogleFonts.poppins(
                                                                  fontSize:
                                                                      15.sp),
                                                          tags: {
                                                            'bold': StyledTextTag(
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700),
                                                            ),
                                                          },
                                                        ),
                                                      )
                                                    : Flexible(
                                                        child: Text(
                                                            "${data.commentaryList?[index].commText}"))
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Obx(
                            ()=> Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          controller.matchesCommentaryData.length +
                                              1,
                                      itemBuilder: (context, index) {
                                        if(index < controller.matchesCommentaryData.length){
                                          firstscrollTimeStamp = "${controller.matchesCommentaryData.first.timestamp}";
                                          firstscrollId = "${controller.matchesCommentaryData.first.inningsId}";

                                          scrollTimeStamp =
                                          "${controller.matchesCommentaryData.last.timestamp}";
                                          scrollId =
                                          "${controller.matchesCommentaryData.last.inningsId}";


                                          String splitdata =
                                              "${controller.matchesCommentaryData[index].overNumber}";


                                          var arr = splitdata.split('.');

                                          var text = controller
                                              .matchesCommentaryData[index].commText;

                                          if (controller.matchesCommentaryData[index]
                                              .commentaryFormats!.bold ==
                                              null) {
                                            text = controller
                                                .matchesCommentaryData[index]
                                                .commText;
                                          } else {
                                            for (var i = 0;
                                            i <
                                                controller
                                                    .matchesCommentaryData[index]
                                                    .commentaryFormats!
                                                    .bold!
                                                    .formatId!
                                                    .length;
                                            i++) {
                                              text = text?.replaceAllMapped(
                                                  "${controller.matchesCommentaryData[index].commentaryFormats!.bold?.formatId![i]}",
                                                      (match) =>
                                                  "<bold>${controller.matchesCommentaryData[index].commentaryFormats!.bold?.formatValue![i]} </bold>");

                                              text = text?.replaceAllMapped(
                                                  "\\n", (match) => "\n");
                                            }
                                          }
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                left: 15.w,
                                                right: 15.w,
                                                top: 10.h,
                                                bottom: 10.h),
                                            child: Column(
                                              children: [
                                                controller
                                                    .matchesCommentaryData[
                                                index]
                                                    .overSeparator ==
                                                    null
                                                    ? Container()
                                                    : Padding(
                                                  padding: EdgeInsets.all(8.sp),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                              width: 90.w,
                                                              child: Text(
                                                                "OVER  ${int.parse(arr[0]) + 1}",
                                                                style: GoogleFonts.poppins(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              )),
                                                          Flexible(
                                                            child: Text(
                                                              "${controller.matchesCommentaryData[index].overSeparator?.oSummary} (${controller.matchesCommentaryData[index].overSeparator?.runs} RUNS)",style: GoogleFonts.poppins(),
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
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
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                  "${controller.matchesCommentaryData[index].overSeparator?.batTeamName}",style: GoogleFonts.poppins()),
                                                              Text(
                                                                  "${controller.matchesCommentaryData[index].overSeparator?.score}/${controller.matchesCommentaryData[index].overSeparator?.wickets}",style: GoogleFonts.poppins())
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                  "${controller.matchesCommentaryData[index].overSeparator?.batStrikerNames![0]}",style: GoogleFonts.poppins()),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                  "${controller.matchesCommentaryData[index].overSeparator?.batNonStrikerNames![0]}",style: GoogleFonts.poppins()),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                  "${controller.matchesCommentaryData[index].overSeparator?.bowlNames![0]}",style: GoogleFonts.poppins())
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                            children: [
                                                              Text(
                                                                "${controller.matchesCommentaryData[index].overSeparator?.batStrikerRuns}(${controller.matchesCommentaryData[index].overSeparator?.batStrikerBalls})",style: GoogleFonts.poppins(),),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                  "${controller.matchesCommentaryData[index].overSeparator?.batNonStrikerRuns}(${controller.matchesCommentaryData[index].overSeparator?.batNonStrikerBalls})",style: GoogleFonts.poppins()),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                  "${controller.matchesCommentaryData[index].overSeparator?.bowlRuns}-${controller.matchesCommentaryData[index].overSeparator?.bowlWickets}",style: GoogleFonts.poppins())
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      divider()
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        width: controller
                                                            .matchesCommentaryData[
                                                        index]
                                                            .overNumber ==
                                                            null
                                                            ? 0
                                                            : 60.w,
                                                        child: controller
                                                            .matchesCommentaryData[
                                                        index]
                                                            .overNumber ==
                                                            null
                                                            ? Container()
                                                            : Column(
                                                          children: [
                                                            Text(
                                                              "${controller.matchesCommentaryData[index].overNumber}",
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            if (controller
                                                                .matchesCommentaryData[
                                                            index]
                                                                .event
                                                                .contains(
                                                                "FOUR"))
                                                              Container(
                                                                height: 20.h,
                                                                width: 20.w,
                                                                child: Image.asset(
                                                                    "assets/image/four.png"),
                                                              ),
                                                            if (controller
                                                                .matchesCommentaryData[
                                                            index]
                                                                .event
                                                                .contains(
                                                                "SIX"))
                                                              Container(
                                                                height: 20.h,
                                                                width: 20.w,
                                                                child: Image.asset(
                                                                    "assets/image/six.png"),
                                                              ),
                                                            if (controller
                                                                .matchesCommentaryData[
                                                            index]
                                                                .event
                                                                .contains(
                                                                "WICKET"))
                                                              Container(
                                                                height: 20.h,
                                                                width: 20.w,
                                                                child:
                                                                Image.asset(
                                                                  "assets/image/wicket.png",
                                                                  color: Colors
                                                                      .red[800],
                                                                ),
                                                              )
                                                          ],
                                                        )),
                                                    controller
                                                        .matchesCommentaryData[
                                                    index]
                                                        .commentaryFormats !=
                                                        null
                                                        ? Flexible(
                                                      child: StyledText(
                                                        text: "$text",
                                                        style:
                                                        GoogleFonts.poppins(
                                                            fontSize:
                                                            15.sp),
                                                        tags: {
                                                          'bold': StyledTextTag(
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                          ),
                                                        },
                                                      ),
                                                    )
                                                        : Flexible(
                                                        child: Text(
                                                            "${controller.matchesCommentaryData[index].commText}"))
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        }else{
                                          return Obx(() => controller.noMoreData.value == true?Container():Padding(
                                            padding: EdgeInsets.symmetric(vertical: 25.h),
                                            child: Center(child: CupertinoActivityIndicator(color: Colors.red.shade900,radius: 15.sp,)),
                                          ));
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    bannerAdView()
                  ],
                );
              }
              return Center(
                  child: CupertinoActivityIndicator(
                color: Colors.red[700],
              ));
            },
          );
  }

  @override
  void dispose() {
    time?.cancel();
    scrollController?.dispose();
    controller.matchesCommentaryData.clear();
    controller.noMoreData.value = false;
    bannerLoad = false;
    nativeLoading = false;
    super.dispose();
  }

  Widget nolive() {
    return FutureBuilder(
      future: controller.commentarytwoapi(widget.Id),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          Center(
              child: Text(
            "No Data!",
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600),
          ));
        } else if (snapshot.hasData) {
          CommentaryTwoModel data = snapshot.data;

          var dt = DateTime.fromMillisecondsSinceEpoch(
              int.parse("${data.matchHeader?.matchStartTimestamp ?? 0}"));

          var d12 = widget.upcoming == true
              ? DateFormat('hh:mm a').format(dt)
              : DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
          return controller.ststuscode.value == 403
              ? Center(
                  child: Text(
                    "Match Not Started!",
                    style: GoogleFonts.poppins(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 20.h),
                      child: Column(
                        children: [
                          Text(
                            "Match Start Time",
                            style: GoogleFonts.poppins(
                                fontSize: 16.sp, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "$d12",
                            style: GoogleFonts.poppins(
                              fontSize: 22.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 5,
                    ),
                    data.matchHeader?.status == ""?Container():Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data.matchHeader?.status ?? "",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
                        child: ListView.builder(
                            itemCount: data.commentaryList?.length,
                            itemBuilder: (context, index) {
                              var text = data.commentaryList![index].commText;

                              if (data.commentaryList![index].commentaryFormats!
                                      .bold ==
                                  null) {
                                text = data.commentaryList![index].commText;
                              } else {
                                for (var i = 0;
                                    i <
                                        data
                                            .commentaryList![index]
                                            .commentaryFormats!
                                            .bold!
                                            .formatId!
                                            .length;
                                    i++) {
                                  text = text?.replaceAllMapped(
                                      "${data.commentaryList![index].commentaryFormats!.bold?.formatId![i]}",
                                      (match) =>
                                          "<bold>${data.commentaryList![index].commentaryFormats!.bold?.formatValue![i]} </bold>");

                                  text = text?.replaceAllMapped(
                                      "\\n", (match) => "\n");
                                }
                              }

                              return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 13.w, vertical: 8.h),
                                  child: data.commentaryList![index]
                                              .commentaryFormats !=
                                          null
                                      ? StyledText(
                                          text: "$text",
                                          style: GoogleFonts.poppins(
                                              fontSize: 15.sp),
                                          tags: {
                                            'bold': StyledTextTag(
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          },
                                        )
                                      : Text(
                                          "${data.commentaryList?[index].commText}"));
                            }),
                      ),
                    ),
                    bannerAdView(),
                  ],
                );
        }
        return Center(
            child: CupertinoActivityIndicator(
          color: Colors.red[700],
        ));
      },
    );
  }

  ScrollController? scrollController = ScrollController();
  int scrollindex = 1;

  String scrollId = "";
  String scrollTimeStamp = "";

  void _getData() async {

    if (scrollindex > 2) {
      print(widget.Id);
      print(scrollId);
      print(scrollTimeStamp);
      if(firstscrollTimeStamp != scrollTimeStamp){
        controller.getCommentaryScrollData(widget.Id, scrollId, scrollTimeStamp);
      }
      debugPrint(
          "this is scroll take ---------------$scrollId ---------$scrollTimeStamp --------------------$scrollindex");
    } else {
      controller.getCommentaryScrollData(widget.Id, inningId, timeStamp);
      print("123456789==================================================");
      debugPrint(
          "this is innning take ---------------$inningId ---------$timeStamp --------------------$scrollindex");
    }
  }
}

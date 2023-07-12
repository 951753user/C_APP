
import 'package:cricbuzzapp/view/match_details/match_details_controller.dart';
import 'package:cricbuzzapp/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/player_details_model.dart';

class PlayerDetailsScreen extends StatefulWidget {
  final String playerId;
  final String playerName;

  const PlayerDetailsScreen(
      {Key? key, required this.playerId, required this.playerName})
      : super(key: key);

  @override
  State<PlayerDetailsScreen> createState() => _PlayerDetailsScreenState();
}

class _PlayerDetailsScreenState extends State<PlayerDetailsScreen> {
  MatchDetailsController controller = Get.put(MatchDetailsController());

  @override
  void initState() {
    print("${widget.playerId}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playerName,style: GoogleFonts.poppins()),
      ),
      body: FutureBuilder(
        future: controller.getPlayerDetailsData(widget.playerId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
          } else if (snapshot.hasData) {
            PlayerDetailsModel data = snapshot.data;
            return Center(
              child: SingleChildScrollView(
                // physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 11.h,
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                controller.playerImage("${data.faceImageId}"),
                              ),
                              radius: 55.sp,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "${data.name?? "Player"}",
                              style: GoogleFonts.poppins(fontSize: 18.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              "${data.intlTeam??"--"}",
                              style: GoogleFonts.poppins(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "PERSONAL INFORMATION",
                          style: GoogleFonts.poppins(fontSize: 17.sp),
                        ),
                      ),
                    ),
                    divider(),
                    details("Born", "${data.doB ??"--"}"),
                    divider(),
                    details("Birth Place", "${data.birthPlace??"--"}"),
                    divider(),
                    details("Nickname", "${data.nickName??"--"}"),
                    divider(),
                    details("Role", "${data.role??"--"}"),
                    divider(),
                    Visibility(
                      visible: data.bat == null ? false : true,
                      child: details("Batting Style", "${data.bat??"--"}"),
                    ),
                    divider(),
                    Visibility(
                      visible: data.bowl == null ? false : true,
                      child: details("Bowling Style", "${data.bowl??"--"}"),
                    ),
                    divider(),
                    // SizedBox(height: 10.h,),
                    Container(
                      width: double.infinity,
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "ICC RANKINGS",
                          style: GoogleFonts.poppins(fontSize: 17.sp),
                        ),
                      ),
                    ),
                    divider(),
                    DataTable(columns: const [
                      DataColumn(
                        label: Text(
                          "",
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "TEST",
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "ODI",
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "T20I",
                        ),
                      ),
                    ], rows: [
                      data.rankings!.bat != null
                          ? DataRow(
                              cells: [
                                const DataCell(Text("Bat")),
                                DataCell(data.rankings!.bat![0].testBestRank !=
                                        null
                                    ? Text(
                                        "Best: ${data.rankings!.bat![0].testBestRank}")
                                    : const Text("--")),
                                DataCell(data.rankings!.bat![0].odiBestRank !=
                                        null
                                    ? Text(
                                        "Best: ${data.rankings!.bat![0].odiBestRank}")
                                    : const Text("--")),
                                DataCell(data.rankings!.bat![0].t20BestRank !=
                                        null
                                    ? Text(
                                        "Best: ${data.rankings!.bat![0].t20BestRank}")
                                    : const Text("--")),
                              ],
                            )
                          : const DataRow(
                              cells: [
                                DataCell(Text("Bat")),
                                DataCell(Text("--")),
                                DataCell(Text("--")),
                                DataCell(Text("--")),
                              ],
                            ),
                      data.rankings!.bowl != null
                          ? DataRow(
                              cells: [
                                const DataCell(Text("Bowl")),
                                DataCell(data.rankings!.bowl![0].testBestRank !=
                                        null
                                    ? Text(
                                        "Best: ${data.rankings!.bowl![0].testBestRank}")
                                    : const Text("--")),
                                DataCell(data.rankings!.bowl![0].odiBestRank !=
                                        null
                                    ? Text(
                                        "Best: ${data.rankings!.bowl![0].odiBestRank}")
                                    : const Text("--")),
                                DataCell(data.rankings!.bowl![0].t20BestRank !=
                                        null
                                    ? Text(
                                        "Best: ${data.rankings!.bowl![0].t20BestRank}")
                                    : const Text("--")),
                              ],
                            )
                          : const DataRow(
                              cells: [
                                DataCell(Text("Bowl")),
                                DataCell(Text("--")),
                                DataCell(Text("--")),
                                DataCell(Text("--")),
                              ],
                            ),
                      data.rankings?.all != null
                          ? DataRow(
                              cells: [
                                const DataCell(Text("All")),
                                DataCell(data.rankings!.all![0].testBestRank !=
                                        null
                                    ? Text(
                                        "Best: ${data.rankings!.all![0].testBestRank}")
                                    : const Text("--")),
                                DataCell(data.rankings!.all![0].odiBestRank !=
                                        null
                                    ? Text(
                                        "Best: ${data.rankings!.all![0].odiBestRank}")
                                    : const Text("--")),
                                DataCell(data.rankings!.all![0].t20BestRank !=
                                        null
                                    ? Text(
                                        "Best: ${data.rankings!.all![0].t20BestRank}")
                                    : const Text("--")),
                              ],
                            )
                          : const DataRow(
                              cells: [
                                DataCell(Text("All")),
                                DataCell(Text("--}")),
                                DataCell(Text("--")),
                                DataCell(Text("--")),
                              ],
                            )
                    ]),
                    Container(
                      width: double.infinity,
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "TEAMS",
                          style: GoogleFonts.poppins(fontSize: 17.sp),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: Text(
                        "${data.teams}",
                        style: GoogleFonts.poppins(color: Colors.grey.shade600),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }

  Widget details(String title, String details) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 110.w,
            child: Text(
              title,
              style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 16.sp),
            ),
          ),
          SizedBox(
            width: 220.w,
            child: Text(
              details,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:  GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }
}

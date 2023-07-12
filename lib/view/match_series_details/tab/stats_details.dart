import 'package:cricbuzzapp/model/stats_details_model.dart';
import 'package:cricbuzzapp/view/player_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../match_series_details_controller.dart';

class StatsDetailsScreen extends StatefulWidget {
  final String seriesId;
  final String type;
  final String title;

  const StatsDetailsScreen(
      {Key? key,
      required this.seriesId,
      required this.type,
      required this.title})
      : super(key: key);

  @override
  State<StatsDetailsScreen> createState() => _StatsDetailsScreenState();
}

class _StatsDetailsScreenState extends State<StatsDetailsScreen> {
  MatchSeriesDetailsController controller =
      Get.put(MatchSeriesDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: GoogleFonts.poppins()),
      ),
      body: FutureBuilder(
        future:
            controller.getSeriesStatsDetailsData(widget.seriesId, widget.type),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
          } else if (snapshot.hasData) {
            StatsDetailsModel data = snapshot.data;
            return SingleChildScrollView(
              child: data.odiStatsList == null?data.t20StatsList == null?Container():widget.type == "bestBowlingInnings"?DataTable(
                headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.red.shade50),
                // columnSpacing: 35,
                columns: List.generate(
                  data.t20StatsList!.headers!.length,
                      (index) => DataColumn(
                    label: Text("${data.t20StatsList?.headers![index]}",style: GoogleFonts.poppins(color: Colors.black),),
                  ),
                ),
                rows: List.generate(
                  data.t20StatsList!.values!.length,
                      (index) {
                    return DataRow(
                      onLongPress: (){
                        Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                      },
                      cells: [
                        DataCell(InkWell(onTap: (){
                          Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                        },child: Text("${data.t20StatsList?.values![index].values![1]}"))),
                        DataCell(InkWell(onTap: (){
                          Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                        },child: Text("${data.t20StatsList?.values![index].values![2]}"))),
                        DataCell(InkWell(onTap: (){
                          Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                        },child: Text("${data.t20StatsList?.values![index].values![2]}"))),
                      ],
                    );
                  },
                ),
              ):DataTable(
                headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.red.shade50),
                columnSpacing: 35,
                columns: List.generate(
                  data.t20StatsList!.headers!.length,
                      (index) => DataColumn(
                    label: Text("${data.t20StatsList?.headers![index]}",style: GoogleFonts.poppins(color: Colors.black),),
                  ),
                ),
                rows: List.generate(
                  data.t20StatsList!.values!.length,
                      (index) {
                    return DataRow(

                      onLongPress: (){
                        Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                      },
                      cells: [
                        DataCell(InkWell(onTap: (){
                          Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                        },child: Text("${data.t20StatsList?.values![index].values![1]}"))),
                        DataCell(InkWell(onTap: (){
                          Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                        },child: Text("${data.t20StatsList?.values![index].values![2]}"))),
                        DataCell(InkWell(onTap: (){
                          Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                        },child: Text("${data.t20StatsList?.values![index].values![3]}"))),
                        DataCell(InkWell(onTap: (){
                          Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                        },child: Text("${data.t20StatsList?.values![index].values![4]}"))),
                        DataCell(InkWell(onTap: (){
                          Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                        },child: Text("${data.t20StatsList?.values![index].values![5]}"))),
                      ],
                    );
                  },
                ),
              ):data.odiStatsList == null?Container():widget.type == "bestBowlingInnings"?DataTable(
                headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.red.shade50),
                // columnSpacing: 35,
                columns: List.generate(
                  data.odiStatsList!.headers!.length,
                      (index) => DataColumn(
                    label: Text("${data.odiStatsList?.headers![index]}",style: GoogleFonts.poppins(color: Colors.black),),
                  ),
                ),
                rows: List.generate(
                  data.odiStatsList!.values!.length,
                      (index) {
                    return DataRow(
                      onLongPress: (){
                        Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                      },
                      cells: [
                        DataCell(InkWell(onTap: (){Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));},child: Text("${data.odiStatsList?.values![index].values![1]}"))),
                        DataCell(InkWell(onTap: (){Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));},child: Text("${data.odiStatsList?.values![index].values![2]}"))),
                        DataCell(InkWell(onTap: (){Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));},child: Text("${data.odiStatsList?.values![index].values![3]}"))),
                      ],
                    );
                  },
                ),
              ):DataTable(
                headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.red.shade50),
                columnSpacing: 35,
                columns: List.generate(
                  data.odiStatsList!.headers!.length,
                      (index) => DataColumn(
                    label: Text("${data.odiStatsList?.headers![index]}",style: GoogleFonts.poppins(color: Colors.black),),
                  ),
                ),
                rows: List.generate(
                  data.odiStatsList!.values!.length,
                      (index) {
                    return DataRow(
                      onLongPress: (){
                        Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));
                      },
                      cells: [
                        DataCell(InkWell(onTap: (){Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));},child: Text("${data.odiStatsList?.values![index].values![1]}"))),
                        DataCell(InkWell(onTap: (){Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));},child: Text("${data.odiStatsList?.values![index].values![2]}"))),
                        DataCell(InkWell(onTap: (){Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));},child: Text("${data.odiStatsList?.values![index].values![3]}"))),
                        DataCell(InkWell(onTap: (){Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));},child: Text("${data.odiStatsList?.values![index].values![4]}"))),
                        DataCell(InkWell(onTap: (){Get.to(()=>PlayerDetailsScreen(playerId: "${data.t20StatsList?.values![index].values![0]}",playerName: "${data.t20StatsList?.values![index].values![1]}",));},child: Text("${data.odiStatsList?.values![index].values![5]}"))),
                      ],
                    );
                  },
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
}

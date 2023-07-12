import 'dart:async';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/point_table_model.dart';
import 'package:cricbuzzapp/utils/banner_ad.dart';
import 'package:cricbuzzapp/utils/nativetwo.dart';
import 'package:cricbuzzapp/view/match_series_details/match_series_details_controller.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PointTableScreen extends StatefulWidget {
  final String seriesId;

  const PointTableScreen({Key? key, required this.seriesId}) : super(key: key);

  @override
  State<PointTableScreen> createState() => _PointTableScreenState();
}

class _PointTableScreenState extends State<PointTableScreen> {
  MatchSeriesDetailsController controller =
      Get.put(MatchSeriesDetailsController());

  Timer? time;

  bool setTime = false;

  @override
  void initState() {
    // controller.checker.value = compareReminderList;

    nativecall();

    Future.delayed(Duration(milliseconds: screenDelayTimer),() {
      setState(() {
        setTime = true;
      });
    });

    time = Timer.periodic(const Duration(seconds: 5), (timer) {
      controller.getPointTableData(widget.seriesId);
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
          child: FutureBuilder(
            future: controller.getPointTableData(widget.seriesId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
              } else if (snapshot.hasData) {

                PointTableModel data = snapshot.data;
                return SingleChildScrollView(
                  child:
                  DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.red.shade50),
                    columnSpacing: 10.sp,
                    columns: List.generate(
                      data.title!.length,
                      (index) => DataColumn(
                        label: Text(
                          data.title![index],
                          style:  GoogleFonts.poppins(color: Colors.black),
                        ),
                      ),
                    ),
                    rows: List.generate(
                      data.group!.teams!.length,
                      (index) {
                        return DataRow(
                          cells: [
                            DataCell(SizedBox(width: 135.w,child: Text("${data.group?.teams![index].name}"))),
                            DataCell(Text("${data.group?.teams![index].p}")),
                            DataCell(Text("${data.group?.teams![index].w}")),
                            DataCell(Text("${data.group?.teams![index].l}")),
                            DataCell(Text("${data.group?.teams![index].nr}")),
                            DataCell(Text("${data.group?.teams![index].t}")),
                            DataCell(Text("${data.group?.teams![index].points}")),
                            DataCell(Text("${data.group?.teams![index].nrr}")),
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
        ),
        bannerAdView(),
        // BannerAD()

      ],
    );
  }
}

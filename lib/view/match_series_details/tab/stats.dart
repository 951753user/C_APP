import 'dart:async';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/stats_model.dart';
import 'package:cricbuzzapp/utils/banner_ad.dart';
import 'package:cricbuzzapp/utils/nativetwo.dart';
import 'package:cricbuzzapp/view/match_series_details/match_series_details_controller.dart';
import 'package:cricbuzzapp/view/match_series_details/tab/stats_details.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StatesScreen extends StatefulWidget {
  final String seriesId;

  const StatesScreen({Key? key, required this.seriesId}) : super(key: key);

  @override
  State<StatesScreen> createState() => _StatesScreenState();
}

class _StatesScreenState extends State<StatesScreen> {
  MatchSeriesDetailsController controller =
      Get.put(MatchSeriesDetailsController());
  Timer? time;

  bool setTime = false;

  @override
  void initState() {
    nativecall();

    Future.delayed(Duration(milliseconds: screenDelayTimer), () {
      setState(() {
        setTime = true;
      });
    });

    time = Timer.periodic(const Duration(seconds: 5), (timer) {
      controller.getSeriesStatsData(widget.seriesId);
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
            future: controller.getSeriesStatsData(widget.seriesId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "No Data!",
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ));
              } else if (snapshot.hasData) {
                StatsModel data = snapshot.data;
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.types?.length,
                  itemBuilder: (context, index) {
                    return data.types![index].value == null
                        ? Container(
                            height: 45.h,
                            color: Colors.black12,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.w),
                              child: Text(
                                "${data.types![index].header?.toUpperCase()}",
                                style: GoogleFonts.poppins(fontSize: 18.sp),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Get.to(() => StatsDetailsScreen(
                                    seriesId: widget.seriesId,
                                    type: "${data.types![index].value}",
                                    title:
                                        '${data.types![index].header?.toUpperCase()}',
                                  ));
                            },
                            child: Container(
                              height: 45.h,
                              // color: Colors.black12,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: Row(
                                  children: [
                                    Text(
                                      "${data.types![index].header}",
                                      style:
                                          GoogleFonts.poppins(fontSize: 18.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  },
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
        bannerAdView(),
        // BannerAD()
        //
      ],
    );
  }
}

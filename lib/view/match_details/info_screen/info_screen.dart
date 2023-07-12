import 'dart:async';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/matchdetailmodel.dart';
import 'package:cricbuzzapp/view/match_details/match_details_controller.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:cricbuzzapp/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoScreen extends StatefulWidget {
  Function() ontap;
  final String Id;
  final bool? upcoming;

  InfoScreen({Key? key, required this.ontap, required this.Id, this.upcoming})
      : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  MatchDetailsController matchDetailsController =
      Get.put(MatchDetailsController());

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
    // controller.checker.value = compareReminderList;

    time = Timer.periodic(const Duration(seconds: 5), (timer) {
      matchDetailsController.matchdetailapi(widget.Id);
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
                  future: matchDetailsController.matchdetailapi(widget.Id),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      MatchDetailModel data = snapshot.data;
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: widget.ontap,
                              child: Card(
                                child: SizedBox(
                                  height: 55.h,
                                  // color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 15.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                         Text(
                                          "SQUADS",
                                          style:
                                              GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 18.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 45.h,
                              color: Colors.black12,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: Text(
                                  "INFO",
                                  style: GoogleFonts.poppins(fontSize: 18.sp),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  details('Match',
                                      '${data.matchInfo!.matchDescription ?? "--"}'),
                                  divider(),
                                  details('Series',
                                      '${data.matchInfo!.series?.name ?? "--"}'),
                                  divider(),
                                  details('Format', '${data.matchInfo!.matchFormat ?? "--"}'),
                                  divider(),
                                  details('Type', '${data.matchInfo!.matchType ?? "--"}'),
                                  divider(),
                                  details('Umpire', '${data.matchInfo!.umpire1?.name ?? "--"}'),
                                  divider(),
                                  details('3rd Umpire', '${data.matchInfo!.umpire3?.name?? "--"}'),
                                  divider(),
                                  details('Referee', '${data.matchInfo!.referee?.name ?? "--"}'),
                                  divider(),
                                  details('Year', '${data.matchInfo!.year??"--"}'),
                                  divider(),
                                ],
                              ),
                            ),
                            Container(
                              height: 45.h,
                              color: Colors.black12,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: Text(
                                  "Venue Guide",
                                  style: GoogleFonts.poppins(fontSize: 18.sp),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              // color: Colors.white,
                              child: Column(
                                children: [
                                  details('Name', '${data.matchInfo!.venue!.name ?? "--"}'),
                                  divider(),
                                  details('City', '${data.matchInfo!.venue!.city ?? "--"}'),
                                  divider(),
                                  details(
                                      'Country', '${data.matchInfo!.venue!.country ?? "--"}'),
                                  divider(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("No Data!",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 25)));
                    }

                    return Align(
                      alignment: Alignment.center,
                      child: CupertinoActivityIndicator(
                        color: Colors.red[700],
                      ),
                    );
                  },
                ),
        ),
        // BannerAD()
        bannerAdView(),
      ]
    );
  }

  Widget details(String title, String details) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              title,
              style:  GoogleFonts.poppins(
                color: Colors.grey,
              ),
            ),
          ),
          Flexible(
            child: Text(
              details,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }
}

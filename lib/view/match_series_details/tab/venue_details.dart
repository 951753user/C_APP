import 'dart:convert';


import 'package:cricbuzzapp/model/venue_details_matches_model.dart';
import 'package:cricbuzzapp/model/venue_details_model.dart';
import 'package:cricbuzzapp/model/venue_stats_model.dart';
import 'package:cricbuzzapp/view/match_details/match_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../main.dart';
import '../../../model/upcomingmatches_model.dart' as md;
import '../../../widgets/divider.dart';
import '../../home_screen/home_controller.dart';
import '../match_series_details_controller.dart';

class VenueDetailsScreen extends StatefulWidget {
  final String venueId;
  final String title;

  const VenueDetailsScreen(
      {Key? key, required this.venueId, required this.title})
      : super(key: key);

  @override
  State<VenueDetailsScreen> createState() => _VenueDetailsScreenState();
}

class _VenueDetailsScreenState extends State<VenueDetailsScreen> {
  MatchSeriesDetailsController controller =
      Get.put(MatchSeriesDetailsController());

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    print(widget.venueId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title,style: GoogleFonts.poppins()),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Text("INFO"),
                ),
                Tab(
                  child: Text("MATCHES"),
                ),
                Tab(
                  child: Text("STATS"),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              infoScreen(),
              matchesScreen(),
              statsScreen(),
            ],
          )),
    );
  }

  Widget details(String title, String details) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 115.w,
            child: Text(
              title,
              style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 16.sp),
            ),
          ),
          SizedBox(
              width: 215.w,
              child: Text(
                details,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style:  GoogleFonts.poppins(),

              ),),
        ],
      ),
    );
  }

  Widget infoScreen() {
    return FutureBuilder(
      future: controller.getVenueDetailsData(widget.venueId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
        } else if (snapshot.hasData) {
          VenueDetailsModel data = snapshot.data;
          return Column(
            children: [
              Container(
                color: Colors.grey.shade200,
                child: Image.asset(
                  "assets/image/stadium.png",
                  height: 180.h,
                  color: Colors.grey.shade600,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "FACTS",
                    style: GoogleFonts.poppins(fontSize: 17.sp),
                  ),
                ),
              ),
              details('Opened', "0"),
              divider(),
              details('Capacity',
                  data.capacity != null ? "${data.capacity}" : "--"),
              divider(),
              details(
                  'Known As', data.knownAs != null ? "${data.knownAs}" : "--"),
              divider(),
              details('Ends', data.ends != null ? "${data.ends}" : "--"),
              divider(),
              details(
                  'Location',
                  data.city != null || data.country != null
                      ? "${data.city}, ${data.country}"
                      : "--"),
              divider(),
              details('Time zone',
                  data.timezone != null ? "${data.timezone}" : "--"),
              divider(),
              details('Floodlights',
                  data.floodlights != null ? "${data.floodlights}" : "--"),
              divider(),
              SizedBox(
                height: 20.h,
              )
            ],
          );
        }
        return const Center(
          child: CupertinoActivityIndicator(
            color: Colors.red,
          ),
        );
      },
    );
  }

  Widget matchesScreen() {
    return FutureBuilder(
      future: controller.getVenueMatchesDetailsData(widget.venueId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            "No Matches",
            style: GoogleFonts.poppins(fontSize: 35.sp),
          );
        } else if (snapshot.hasData) {
          VenueDetailsMatchesModel data = snapshot.data;
          return ListView.builder(
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: data.matchDetails?.length,
            itemBuilder: (context, mt) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.red.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "${data.matchDetails![mt].matchDetailsMap?.key}",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.matchDetails![mt].matchDetailsMap?.match?.length,
                      itemBuilder: (context, i) {
                        return upcomingMatchesData(mt, data, i);
                      },
                    ),
                  ),
                ],
              );
            },
          );
        }
        return Center(
          child: Text(
            "No Matches",
            style: GoogleFonts.poppins(fontSize: 35.sp),
          ),
        );
      },
    );
  }

  Widget statsScreen() {
    return FutureBuilder(
      future: controller.getVenueStatsDetailsData(widget.venueId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
        } else if (snapshot.hasData) {
          VenuestatsModel data = snapshot.data;
          return ListView.builder(
            itemCount: data.venueStats?.length,
            itemBuilder: (context, index) {
              return details("${data.venueStats![index].key}", "${data.venueStats![index].value}");
            },
          );
        }
        return const Center(
          child: CupertinoActivityIndicator(
            color: Colors.red,
          ),
        );
      },
    );
  }

  Widget upcomingMatchesData(int matchtype, VenueDetailsMatchesModel data, int i) {
    var dt = DateTime.fromMillisecondsSinceEpoch(int.parse(
        "${data.matchDetails![matchtype].matchDetailsMap?.match![i].matchInfo?.startDate}"));

// 12 Hour format:
    var d12 = DateFormat('dd/MM/yyyy, hh:mm a').format(dt);
    return InkWell(
      onTap: () {
        // Get.toNamed(AppPages.matchDetails);
        Get.to(MatchDetailsScreen(
          Id: '${data.matchDetails![matchtype].matchDetailsMap?.match![i].matchInfo?.matchId}',
          upcoming: true,
        ));
      },
      child: Card(
        elevation: 2,
        child: Container(
          height: 156.h,
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
                        Text(
                          "${data.matchDetails![matchtype].matchDetailsMap?.key}",
                          style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              color: Get.find<HomeController>()
                                          .themeChanger
                                          .value ==
                                      false
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          // "${data.matchDetails![matchtype].matchDetailsMap?.match![i].matchInfo?.startDate}",
                          "$d12",
                          style: GoogleFonts.poppins(
                              color: Get.find<HomeController>()
                                          .themeChanger
                                          .value ==
                                      false
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade600,
                              fontSize: 13.sp),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        compareReminderList.add(data.matchDetails![matchtype].matchDetailsMap?.match![i].matchInfo?.startDate);
                        datafind = compareReminderList;

                        await storage.write(
                            key: "remind_compare",
                            value: jsonEncode(compareReminderList));
                        setState(() {});
                      },
                      child: SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: Icon(
                          datafind != null
                              ? datafind.contains(
                                      '${data.matchDetails![matchtype].matchDetailsMap?.match![i].matchInfo?.startDate}')
                                  ? Icons.notifications_active_rounded
                                  : Icons.notifications_none
                              : compareReminderList.contains(
                                      '${data.matchDetails![matchtype].matchDetailsMap?.match![i].matchInfo?.startDate}')
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
                              "${data.matchDetails![matchtype].matchDetailsMap?.match![i].matchInfo?.team1?.imageId}"),
                          height: 40.h,
                          width: 40.w,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          "${data.matchDetails![matchtype].matchDetailsMap?.match![i].matchInfo?.team1?.teamSName}",
                          style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              ),
                            overflow: TextOverflow.ellipsis
                        ),
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
                          "${data.matchDetails![matchtype].matchDetailsMap?.match![i].matchInfo?.team2?.teamSName}",
                          style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              ),
                            overflow: TextOverflow.ellipsis
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Image.network(
                          controller.getImage(
                              "${data.matchDetails![matchtype].matchDetailsMap?.match![i].matchInfo?.team2?.imageId}"),
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

            ],
          ),
        ),
      ),
    );
  }
}

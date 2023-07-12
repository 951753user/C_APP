import 'dart:async';
import 'dart:convert';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/helper/adManager.dart';
import 'package:cricbuzzapp/helper/color.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/homemodel.dart';
import 'package:cricbuzzapp/utils/permission.dart';
import 'package:cricbuzzapp/view/home_screen/home_controller.dart';
import 'package:cricbuzzapp/view/match_details/match_details.dart';
import 'package:cricbuzzapp/view/match_details/match_details_controller.dart';
import 'package:cricbuzzapp/view/match_series_details/match_series_details_screen.dart';
import 'package:cricbuzzapp/view/match_series_details/tab/news_details.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:cricbuzzapp/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

AdManager adManager = AdManager();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  MatchDetailsController matchDetailsController =
      Get.put(MatchDetailsController());


  final storage = const FlutterSecureStorage();

  bool setTime = false;

  Timer? time;
  late final PageController _pageController;
  int selectedPage = 0;

  String? startMonthName;
  String? endMonthName;

  @override
  void initState() {

    Timer(const Duration(seconds: 3),(){
      setState(() {

      });
    });
   if(controller.homeAdsCount.value >= 1){
     nativecall();
   }

    // controller.checker.value = compareReminderList;
    // selectedPage = 0;

    Future.delayed(const Duration(milliseconds: 1000),() {
      setState(() {
        setTime = true;
        controller.homeAdsCount.value++;
      });
    });
    permissions();
    _pageController = PageController(initialPage: selectedPage);
    time = Timer.periodic(const Duration(seconds: 7), (timer) {
      controller.homeapi();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {

    if(controller.homeAdsCount.value >= 1){
      bannercall(context);
    }

    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            // backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(10.sp),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
              ),
              padding: EdgeInsets.all(15.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Are You sure You Want to Exit?",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 18.sp),
                  ),
                  SizedBox(height: 10.h,),
                  // const NatiAdScreen(),
                  SizedBox(height: 10.h,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          style:
                              TextButton.styleFrom(backgroundColor: primaryColor),
                          child: Text(
                            "No",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 12.w,),
                        TextButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          style:
                              TextButton.styleFrom(backgroundColor: primaryColor),
                          child: Text(
                            "Yes",
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Crick 11 Live",
            style: GoogleFonts.poppins(),
          ),
        ),
        body: RefreshIndicator(
          color: Colors.red,
          onRefresh: () async {
            setState(() {
              controller.homeapi();
            });
          },
          child:
          setTime == false?Center(
            child: CupertinoActivityIndicator(
              color: Colors.red.shade900,
            ),
          ): Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ScrollWrapper(
                  promptAlignment: Alignment.topCenter,
                  promptAnimationCurve: Curves.elasticInOut,
                  promptDuration: const Duration(milliseconds: 400),
                  enabledAtOffset: 800,
                  alwaysVisibleAtOffset: true,
                  scrollOffsetUntilVisible: 500,
                  promptReplacementBuilder: (context, function) => InkWell(
                      onTap: () {
                        function();
                        setState(() {});
                        },
                      child: Container(
                        height: 40.h,
                        width: 120.w,
                        margin: EdgeInsets.all(10.sp),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(20.sp)),
                        child: Text(
                          'Scroll to top',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 15.sp),
                        ),
                      )),
                  builder: (context, properties) => FutureBuilder(
                    future: controller.homeapi(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        HomeModel data = snapshot.data;
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 15.w,
                                  right: 15.w,
                                  top: 15.h,
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "MATCHES",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                height: 266.h,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 15.w),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: PageView.builder(
                                          pageSnapping: true,
                                          controller: _pageController,
                                          itemCount: data.matches?.length,
                                          scrollDirection: Axis.horizontal,
                                          onPageChanged: (page) {
                                            setState(() {
                                              selectedPage = page;
                                            });
                                          },
                                          // physics:
                                          //     const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var dt = DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    int.parse(
                                                        "${data.matches![index].match!.matchInfo!.startDate}"));

                                            var d12 = DateFormat(
                                                    'hh:mm a')
                                                .format(dt);
                                            String splitdata =
                                                "${data.matches![index].match!.matchScore?.team1Score?.inngs1!.overs}";

                                            var arr = splitdata.split('.');





                                              String splitdata2 =
                                                  "${data.matches![index].match!.matchScore?.team2Score?.inngs1?.overs}";

                                            var array = splitdata2.split('.');

                                            var ds = DateTime.fromMillisecondsSinceEpoch(int.parse("${data.matches![index].match!.matchInfo!.startDate}"));
                                            var dfsd = DateFormat('dd').format(ds);

                                            final d= DateTime.now().day;

                                            if(int.parse(dfsd) == d){
                                              dfsd = "Today";
                                            } else if(int.parse(dfsd) == d+1){
                                              dfsd = "Tomorrow";
                                            }


                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(left: 15.w),
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (ctx) {
                                                        initAdplay();
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 3),
                                                            () {
                                                          if (interstitialAd != null) {
                                                            interstitialAd?.show();

                                                            interstitialAd = null;
                                                          }
                                                          Get.back();

                                                          Timer(
                                                              const Duration(
                                                                  milliseconds:
                                                                      300), () {
                                                            Get.to(
                                                              MatchDetailsScreen(
                                                                index: 1,
                                                                Id: "${data.matches![index].match!.matchInfo!.matchId}",
                                                                state:
                                                                    "${data.matches![index].match!.matchInfo!.state}",
                                                                t1: "${data.matches![index].match!.matchInfo!.team1!.teamSName}",
                                                                t2: "${data.matches![index].match!.matchInfo!.team2!.teamSName}",
                                                              ),
                                                            );
                                                          });
                                                        });
                                                        return SizedBox(
                                                          height: 25.h,
                                                          width: 126,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              CupertinoActivityIndicator(
                                                                  color: Colors
                                                                      .red[900],
                                                                  radius: 20),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                child: Card(
                                                  elevation: 2.5,
                                                  child: SizedBox(
                                                    height: 200.h,
                                                    width: 300.w,
// color: Colors.white,
                                                    child: Stack(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.sp),
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
                                                                      Text(
                                                                        "${data.matches![index].match!.matchInfo!.seriesName}",
                                                                        style: GoogleFonts.poppins(
                                                                            fontSize:
                                                                                11.sp,
                                                                            color: Colors.grey.shade500),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5.h,
                                                                      ),
                                                                      Text(
                                                                        "${data.matches![index].match!.matchInfo!.matchDesc}",
                                                                        style: GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.grey.shade600,
                                                                            fontSize: 13.sp),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  data.matches![index].match?.matchInfo?.state == "Upcoming" ||
                                                                          data.matches![index].match?.matchInfo?.state ==
                                                                              "Preview" ||
                                                                          data.matches![index].match?.matchInfo?.state ==
                                                                              "Toss"
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            var remid =
                                                                                DateTime.fromMillisecondsSinceEpoch(int.parse("${data.matches![index].match!.matchInfo!.startDate}"));

                                                                            var ptime =
                                                                                DateFormat('yyyy-MM-dd HH:mm:ss.000000').format(remid);

                                                                            compareReminderList.add({
                                                                              ptime: "${data.matches![index].match!.matchInfo!.team1!.teamSName} vs ${data.matches![index].match!.matchInfo!.team2!.teamSName} at ${data.matches![index].match!.matchInfo?.venueInfo?.ground}"
                                                                            });

                                                                            await storage.write(key: "remind_compare", value: jsonEncode(compareReminderList)).whenComplete(() {
                                                                              Fluttertoast.showToast(msg: "${data.matches![index].match!.matchInfo!.team1!.teamSName} vs ${data.matches![index].match!.matchInfo!.team2!.teamSName}\n Notification Scheduled", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red[800], textColor: Colors.white, fontSize: 16.0);
                                                                            });
                                                                            setState(() {
                                                                              datafind = compareReminderList;
                                                                            });
                                                                          },
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                30.h,
                                                                            width:
                                                                                30.w,
                                                                            child:
                                                                                Icon(
                                                                              datafind != null
                                                                                  ? datafind.contains("${data.matches![index].match!.matchInfo!.team1!.teamSName} vs ${data.matches![index].match!.matchInfo!.team2!.teamSName} at ${data.matches![index].match!.matchInfo?.venueInfo?.ground}")
                                                                                      ? Icons.notifications_active_rounded
                                                                                      : Icons.notifications_none
                                                                                  : compareReminderList.contains("${data.matches![index].match!.matchInfo!.team1!.teamSName} vs ${data.matches![index].match!.matchInfo!.team2!.teamSName} at ${data.matches![index].match!.matchInfo?.venueInfo?.ground}")
                                                                                      ? Icons.notifications_active_rounded
                                                                                      : Icons.notifications_none,
                                                                              color: Colors.grey.shade400,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(),
                                                                ],
                                                              ),
                                                            ),
                                                            divider(),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.w),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Image
                                                                              .network(
                                                                            controller.playerPhoto(
                                                                              "${data.matches![index].match!.matchInfo!.team1!.imageId}",
                                                                            ),
                                                                            height:
                                                                                40.h,
                                                                            width:
                                                                                40.w,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15.w,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                120.w,
                                                                            child:
                                                                                Text(
                                                                              "${data.matches![index].match!.matchInfo!.team1!.teamSName}",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 2,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10.w),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Image
                                                                              .network(
                                                                            controller.playerPhoto(
                                                                              "${data.matches![index].match!.matchInfo!.team2!.imageId}",
                                                                            ),
                                                                            height:
                                                                                40.h,
                                                                            width:
                                                                                40.w,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15.w,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                120.w,
                                                                            child:
                                                                                Text(
                                                                              "${data.matches![index].match!.matchInfo!.team2!.teamSName}",
                                                                              style: GoogleFonts.poppins(
                                                                                fontSize: 12.sp,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width: 35.w,
                                                                ),
                                                                data
                                                                            .matches![index]
                                                                            .match!
                                                                            .matchScore
                                                                            ?.team1Score
                                                                            ?.inngs1
                                                                            ?.runs ==
                                                                        null
                                                                    ? Container()
                                                                    : Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                "${data.matches![index].match!.matchScore?.team1Score?.inngs1?.runs}/${data.matches![index].match?.matchScore?.team1Score?.inngs1?.wickets ?? 0}",
                                                                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              arr[1] == "6"
                                                                                  ? Text(
                                                                                      "(${int.parse(arr[0]) + 1})",
                                                                                      style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 13.sp),
                                                                                    )
                                                                                  : Text(
                                                                                      "(${data.matches![index].match!.matchScore?.team1Score?.inngs1?.overs})",
                                                                                      style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 13.sp),
                                                                                    )
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                33.h,
                                                                          ),
                                                                          data.matches![index].match!.matchScore?.team2Score?.inngs1?.runs == null?Container():Row(
                                                                            children: [
                                                                              Text(
                                                                                "${data.matches![index].match!.matchScore?.team2Score?.inngs1?.runs ?? 00}"
                                                                                "/${data.matches![index].match!.matchScore?.team2Score?.inngs1?.wickets ?? 0}",
                                                                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              data.matches![index].match!.matchScore?.team2Score?.inngs1?.overs == null
                                                                                  ? Text(
                                                                                      "(0.0)",
                                                                                      style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 13.sp),
                                                                                    )
                                                                                  : array[1] == "6"
                                                                                      ? Text(
                                                                                          "(${int.parse(array[0]) + 1})",
                                                                                          style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 13.sp),
                                                                                        )
                                                                                      : Text(
                                                                                          "(${data.matches![index].match!.matchScore?.team2Score?.inngs1?.overs})",
                                                                                          style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 13.sp),
                                                                                        )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      )
                                                              ],
                                                            ),
                                                            const Spacer(),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                          .all(
                                                                      15.sp),
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        190.w,
                                                                    child: Text(
                                                                      data.matches![index].match!.matchInfo!
                                                                              .status ??
                                                                          "$dfsd, $d12",
                                                                      style: TextStyle(
                                                                        color: data.matches![index].match!.matchInfo!
                                                                            .state == "Complete"?Colors.green:Colors.deepOrange,
                                                                          fontSize: 13
                                                                              .sp,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .visible,
                                                                      maxLines:
                                                                          2,
                                                                    ),
                                                                  ),
                                                                  const Spacer(),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade200,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          barrierDismissible:
                                                                              false,
                                                                          builder:
                                                                              (ctx) {
                                                                            initAdplay();
                                                                            Future.delayed(const Duration(seconds: 3),
                                                                                () {
                                                                              interstitialAd?.show();

                                                                              interstitialAd = null;
                                                                              Get.back();

                                                                              Timer(const Duration(milliseconds: 300), () {
                                                                                Get.to(MatchSeriesDetailsScreen(seriesId: "${data.matches![index].match!.matchInfo!.seriesId}", seriesName: "${data.matches![index].match!.matchInfo!.seriesName}"));
                                                                              });
                                                                            });
                                                                            return SizedBox(
                                                                              height: 25.h,
                                                                              width: 126,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children:  [
                                                                                  CupertinoActivityIndicator(color: Colors.red[700], radius: 20),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Schedule",
                                                                        style: GoogleFonts.poppins(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: PageViewDotIndicator(
                                          currentItem: selectedPage,
                                          unselectedSize: const Size(8, 8),
                                          size: const Size(10, 10),
                                          count: data.matches!.length,
                                          unselectedColor: Colors.black26,
                                          selectedColor: Colors.red.shade800,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          boxShape: BoxShape.circle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.h),
                                child: nativeAdView()
                                // adManager.nativeAd == null?
                                //     Container():SizedBox(
                                //   height: 80.h,
                                //   child: AdWidget(
                                //     ad: adManager.getNativeAd()..load(),
                                //   ),
                                // )
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 15,
                                  left: 15,
                                ),
                                child: Text(
                                  "TOP STORIES",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp),
                                ),
                              ),
                              Flexible(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data.homepage!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(() => NewsDetailsScreen(
                                              newsId:
                                                  "${data.homepage![index].stories?.itemId}"));
                                        },
                                        child: data.homepage![index].stories
                                                    ?.intro ==
                                                null
                                            ? SizedBox(
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: EdgeInsets.all(5.sp),
                                                  child: Text(
                                                    "${data.homepage![index].stories?.headline}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.w,
                                                              vertical: 8.h),
                                                      child: Text(
                                                        "${data.homepage![index].stories?.context}",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 15.sp,
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    ),
                                                    Image.network(
                                                      controller
                                                          .playerPhoto(
                                                              "${data.homepage![index].stories?.imageId}"),
                                                      height: 250.h,
                                                      width: double.infinity,
                                                      fit: BoxFit.fill,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.sp),
                                                      child: Text(
                                                        "${data.homepage![index].stories?.headline}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 20.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.w),
                                                      child: Text(
                                                        "${data.homepage![index].stories?.intro}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 15.sp,
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        Center(
                            child: Text(
                          "No Data!",
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.w600),
                        ));
                      }
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.red[800],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // adManager.bannerAd == null?Container():SizedBox(
              //   height: adManager.bannerAd?.size.height.toDouble(),
              //   width: adManager.bannerAd?.size.width.toDouble(),
              //   child: AdWidget(ad: adManager.getBannerad()..load()),
              // ),
              bannerAdView(),

              // BannerAD()
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    time?.cancel();
    // banner?.dispose();
    bannerLoad = false;
    nativeLoading = false;
    adManager.disposeAds();
    // nativeAd?.dispose();
    super.dispose();
  }
}

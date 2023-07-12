import 'dart:async';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/view/bottom_navigation/navigation_controller.dart';
import 'package:cricbuzzapp/view/more_screen/player/serach_player_screen.dart';
import 'package:cricbuzzapp/view/more_screen/schedule/schedule_screen.dart';
import 'package:cricbuzzapp/view/more_screen/series/more_series_screen.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:cricbuzzapp/widgets/divider.dart';
import 'package:flutter/cupertino.dart' as ios;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  bool setTime = false;

  @override
  void initState() {
    Timer(Duration(seconds: 3),(){
      setState(() {

      });
    });

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Get.find<NavigationController>().selectedIndex.value = 0;
        return false;
      },
      child: Scaffold(
        // backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 2,
          title:  Text("Settings",style: GoogleFonts.poppins()),
        ),
        body: setTime == false?Center(
          child: ios.CupertinoActivityIndicator(
            color: Colors.red.shade900,
          ),
        ):Column(
          children: [
            moreColumnBar("Series", const FaIcon(FontAwesomeIcons.trophy), () {
              Get.to(()=> const MoreSeriesScreen());
            }),
            divider(),
            moreColumnBar("Player", const Icon(Icons.person), () {
              Get.to(()=> const SearchPlayerScreen());
            }),
            divider(),
            moreColumnBar("Schedule", const FaIcon(FontAwesomeIcons.calendar), () {
              Get.to(()=> const ScheduleScreen());
            }),
            divider(),
            moreColumnBar("Privacy Policy", const Icon(Icons.group), () {
              launchURL();
            }),
            divider(),
            moreColumnBar('Rate The App', const Icon(Icons.star_outline), () {
              LaunchReview.launch(
                androidAppId: "com.nk.crick11live",
              );
            }),
            divider(),
            Spacer(),
            // BannerAD(),
            bannerAdView(),
          ],
        ),
      ),
    );
  }

  launchURL() async {
    const url = 'https://sites.google.com/view/crick11live/home';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget moreColumnBar(String name, Widget leading, Function() ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 55.h,
        // color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Row(
            children: [
              Container(
                height: 55.h,
                width: 30.h,
                alignment: Alignment.center,
                child: leading,
              ),
              SizedBox(
                width: 18.w,
              ),
              Text(
                name,
                style: GoogleFonts.poppins(fontSize: 16.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}

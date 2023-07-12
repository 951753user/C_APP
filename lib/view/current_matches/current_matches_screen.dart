import 'package:cricbuzzapp/view/current_matches/live_matches_screen/live_matches_screen.dart';
import 'package:cricbuzzapp/view/current_matches/recent_matches_screen/recent_matches_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bottom_navigation/navigation_controller.dart';
import 'upcoming_matche_screen/upcoming_matches_screen.dart';

class CurrentMatchesScreen extends StatefulWidget {
  const CurrentMatchesScreen({Key? key}) : super(key: key);

  @override
  State<CurrentMatchesScreen> createState() => _CurrentMatchesScreenState();
}

class _CurrentMatchesScreenState extends State<CurrentMatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Get.find<NavigationController>().selectedIndex.value = 0;
        return false;
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title:  Text("Current Matches",style: GoogleFonts.poppins()),
            bottom:  TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Text("LIVE",style: GoogleFonts.poppins()),
                ),
                Tab(
                  child: Text("UPCOMING",style: GoogleFonts.poppins()),
                ),
                Tab(
                  child: Text("RECENT",style: GoogleFonts.poppins()),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              LiveMatchesScreen(),
              UpcomingMatchesScreen(),
              RecentMatchesScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

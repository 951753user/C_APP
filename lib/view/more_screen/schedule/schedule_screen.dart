import 'package:cricbuzzapp/view/more_screen/schedule/tab/schedule_domestic_screen.dart';
import 'package:cricbuzzapp/view/more_screen/schedule/tab/schedule_international_screen.dart';
import 'package:cricbuzzapp/view/more_screen/schedule/tab/schedule_league_screen.dart';
import 'package:cricbuzzapp/view/more_screen/schedule/tab/schedule_women_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Schedules",style: GoogleFonts.poppins()),
          bottom:  TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: [
              Tab(child: Text("INTERNATIONAL",style: GoogleFonts.poppins()),),
              Tab(child: Text("T20 LEAGUES",style: GoogleFonts.poppins()),),
              Tab(child: Text("DOMESTIC",style: GoogleFonts.poppins()),),
              Tab(child: Text("WOMEN",style: GoogleFonts.poppins()),),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ScheduleInternationalScreen(),
            ScheduleLeagueScreen(),
            ScheduleDomesticScreen(),
            ScheduleWomenScreen(),
          ],
        ),
      ),
    );
  }
}

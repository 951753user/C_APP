import 'package:cricbuzzapp/view/more_screen/series/tab/domestic_series_screen.dart';
import 'package:cricbuzzapp/view/more_screen/series/tab/internation_series_screen.dart';
import 'package:cricbuzzapp/view/more_screen/series/tab/league_series_screen.dart';
import 'package:cricbuzzapp/view/more_screen/series/tab/women_series_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreSeriesScreen extends StatefulWidget {
  const MoreSeriesScreen({Key? key}) : super(key: key);

  @override
  State<MoreSeriesScreen> createState() => _MoreSeriesScreenState();
}

class _MoreSeriesScreenState extends State<MoreSeriesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title:  Text("Series",style: GoogleFonts.poppins()),
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
            InternationalSeriesScreen(),
            LeagueSeriesScreen(),
            DomesticSeriesScreen(),
            WomenSeriesScreen(),
          ],
        ),
      ),
    );
  }
}

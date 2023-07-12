import 'package:cricbuzzapp/view/match_series_details/match_series_details_controller.dart';
import 'package:cricbuzzapp/view/match_series_details/tab/matches.dart';
import 'package:cricbuzzapp/view/match_series_details/tab/news.dart';
import 'package:cricbuzzapp/view/match_series_details/tab/pointtable.dart';
import 'package:cricbuzzapp/view/match_series_details/tab/squads.dart';
import 'package:cricbuzzapp/view/match_series_details/tab/stats.dart';
import 'package:cricbuzzapp/view/match_series_details/tab/venue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchSeriesDetailsScreen extends StatefulWidget {
  final String seriesId;
  final String seriesName;
  const MatchSeriesDetailsScreen({Key? key, required this.seriesId, required this.seriesName}) : super(key: key);

  @override
  State<MatchSeriesDetailsScreen> createState() => _MatchSeriesDetailsScreenState();
}

class _MatchSeriesDetailsScreenState extends State<MatchSeriesDetailsScreen> {

  MatchSeriesDetailsController controller = Get.put(MatchSeriesDetailsController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.seriesName,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins()),
          bottom:  TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: [
              Tab(child: Text("MATCHES",style: GoogleFonts.poppins()),),
              Tab(child: Text("NEWS",style: GoogleFonts.poppins()),),
              Tab(child: Text("SQUADS",style: GoogleFonts.poppins()),),
              Tab(child: Text("STATS",style: GoogleFonts.poppins()),),
              Tab(child: Text("VENUES",style: GoogleFonts.poppins()),),
              Tab(child: Text("POINTS TABLE",style: GoogleFonts.poppins()),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MatchesScreen(seriesId: widget.seriesId),
            NewsScreen(seriesId: widget.seriesId),
            SquadsScreen(seriesId: widget.seriesId),
            StatesScreen(seriesId: widget.seriesId),
            VenueScreen(seriesId: widget.seriesId),
            PointTableScreen(seriesId: widget.seriesId,),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    controller.moreNews.clear();
    controller.newsLastId.value = "";
    controller.scrollNewsLastId.value = "";
    controller.scrollNewsFirstId.value = "";
    super.dispose();
  }
}

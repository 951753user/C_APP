import 'package:cricbuzzapp/utils/banner_ad.dart';
import 'package:cricbuzzapp/view/match_details/info_screen/info_screen.dart';
import 'package:cricbuzzapp/view/match_details/live_screen/live_screen.dart';
import 'package:cricbuzzapp/view/match_details/match_details_controller.dart';
import 'package:cricbuzzapp/view/match_details/scoreboard/scoreboard_screen.dart';
import 'package:cricbuzzapp/view/match_details/squads/squads_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchDetailsScreen extends StatefulWidget {
  final String Id;
  final int? index;
  final bool? upcoming;
  final String? state;
  final String? t1;
  final String? t2;

  const MatchDetailsScreen({
    Key? key,
    this.index,
    required this.Id,
    this.upcoming,
    this.state,
    this.t1,
    this.t2,
  }) : super(key: key);

  @override
  State<MatchDetailsScreen> createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen>
    with SingleTickerProviderStateMixin {
  MatchDetailsController controller = Get.put(MatchDetailsController());

  late final _tabController = TabController(
    length: 4,
    vsync: this,
  );

  void _toggleTab() {
    // controller.selectIndex.value = _tabController.index;
    _tabController.animateTo(3);
  }

  @override
  void initState() {
    _tabController.animateTo(widget.index ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        // backgroundColor: Colors.blueGrey.shade50,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: Text("${widget.t1} v ${widget.t2}",
              overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins()),
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text("INFO", style: GoogleFonts.poppins()),
              ),
              Tab(
                child: Text("LIVE", style: GoogleFonts.poppins()),
              ),
              Tab(
                child: Text("SCOREBOARD", style: GoogleFonts.poppins()),
              ),
              Tab(
                child: Text("SQUADS", style: GoogleFonts.poppins()),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            InfoScreen(
                ontap: _toggleTab, Id: widget.Id, upcoming: widget.upcoming),
            LiveScreen(
                Id: widget.Id, upcoming: widget.upcoming, stste: widget.state),
            ScoreBoardScreen(matchId: widget.Id, upcoming: widget.upcoming),
            SquadScreen(matchId: widget.Id, upcoming: widget.upcoming)
          ],
        ),
      ),
    );
  }
}

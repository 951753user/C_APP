
import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/squad_details_model.dart';
import '../../player_details_screen.dart';
import '../match_series_details_controller.dart';

class SquadDetailsScreen extends StatefulWidget {
  final String seriesId;
  final String squadId;
  final String title;

  const SquadDetailsScreen(
      {Key? key, required this.seriesId, required this.squadId, required this.title})
      : super(key: key);

  @override
  State<SquadDetailsScreen> createState() => _SquadDetailsScreenState();
}

class _SquadDetailsScreenState extends State<SquadDetailsScreen> {
  MatchSeriesDetailsController controller =
      Get.put(MatchSeriesDetailsController());

  bool setTime = false;

  @override
  void initState() {

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: GoogleFonts.poppins()),
      ),
      body: setTime == false?Center(
        child: CupertinoActivityIndicator(
          color: Colors.red.shade900,
        ),
      ):Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: FutureBuilder(
              future: controller.getSeriesSquadDetailsData(
                  widget.seriesId, widget.squadId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return  Center(child: Text("No Data!",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w600),));
                } else if (snapshot.hasData) {
                  SquadDetailsModel data = snapshot.data;
                  return ListView.builder(
                    itemCount: data.player?.length,
                    itemBuilder: (context, index) {
                      return data.player![index].imageId == null?Container(
                        height: 45.h,
                        color: Colors.black12,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: Text("${data.player![index].name}",style: GoogleFonts.poppins(fontSize: 18.sp),),
                        ),
                      ):InkWell(
                        onTap: (){
                          Get.to(()=> PlayerDetailsScreen(playerId: "${data.player![index].id}", playerName: "${data.player![index].name}"));
                        },
                        child: Container(
                          height: 50.h,
                          // color: Colors.black12,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.w),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                  NetworkImage(
                                      controller.getImage(
                                          "${data.player![index].imageId}")),
                                  radius: 20.sp,
                                ),
                                // Image.network(
                                //   controller.getImage("${data.player![index].imageId}"),height: 35.h,width: 35.w,
                                // ),
                                SizedBox(width: 10.w,),
                                Text("${data.player![index].name}",style: GoogleFonts.poppins(fontSize: 18.sp),),
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
                    color: Colors.red[800],
                  ),
                );
              },
            ),
          ),
          bannerAdView(),
        ],
      ),
    );
  }
}

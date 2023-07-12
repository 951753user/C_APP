import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/venuemodel.dart';
import 'package:cricbuzzapp/view/match_series_details/match_series_details_controller.dart';
import 'package:cricbuzzapp/view/match_series_details/tab/venue_details.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:cricbuzzapp/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VenueScreen extends StatefulWidget {
  final String seriesId;

  const VenueScreen({Key? key, required this.seriesId}) : super(key: key);

  @override
  State<VenueScreen> createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  MatchSeriesDetailsController controller =
      Get.put(MatchSeriesDetailsController());

  bool setTime = false;

  @override
  void initState() {

    nativecall();

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
            future: controller.venuedata(widget.seriesId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "No Data!",
                  style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w600),
                ));
              } else if (snapshot.hasData) {
                VenueModel data = snapshot.data;
                return ListView.separated(
                  itemCount: data.seriesVenue!.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => VenueDetailsScreen(
                            venueId: "${data.seriesVenue![index].id}",
                            title: "${data.seriesVenue![index].ground}"));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/image/stadium.png",
                                  height: 80.h,
                                  width: 80.w,
                                  fit: BoxFit.fill,
                                  color: Colors.grey.shade600,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.sp),
                                  child: SizedBox(
                                    height: 80.h,
                                    width: 244.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "${data.seriesVenue?[index].ground}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "${data.seriesVenue?[index].city} , ${data.seriesVenue?[index].country}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14.sp,
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    if (index % 5 == 4) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        // child: NatiAdScreen(),
                      );
                    }
                    return divider();
                  },
                );
              }
              return Center(
                child: CupertinoActivityIndicator(
                  color: Colors.red[700],
                ),
              );
            },
          ),
        ),
        bannerAdView(),
        // BannerAD()
      ],
    );
  }
}

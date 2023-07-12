// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/main.dart';
import 'package:cricbuzzapp/model/newsmodel.dart';
import 'package:cricbuzzapp/utils/banner_ad.dart';
import 'package:cricbuzzapp/utils/nativetwo.dart';
import 'package:cricbuzzapp/view/bottom_navigation/navigation_controller.dart';
import 'package:cricbuzzapp/view/match_series_details/tab/news_details.dart';
import 'package:cricbuzzapp/view/news%20_screen/news_controller.dart';
import 'package:cricbuzzapp/widgets/adWidgets.dart';
import 'package:cricbuzzapp/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsController controller = Get.put(NewsController());



  @override
  void initState() {

    nativecall();
    Timer(Duration(seconds: 3),(){
      setState(() {

      });
    });
    Future.delayed(Duration(milliseconds: screenDelayTimer), () {
        controller.setTime.value = true;
    });
    scrollController?.addListener(_scrollListener);
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
  void _scrollListener() {
    if (scrollController!.offset >=
            scrollController!.position.maxScrollExtent &&
        !scrollController!.position.outOfRange) {
      scrollindex++;
      _getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<NavigationController>().selectedIndex.value = 0;
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("News", style: GoogleFonts.poppins()),
        ),
        body: Obx(() => controller.setTime.value == false
            ? Center(
          child: CupertinoActivityIndicator(
            color: Colors.red.shade900,
          ),
        )
            : Scrollbar(
          thickness: 5,
          child: ScrollWrapper(
            promptAlignment: Alignment.topCenter,
            promptAnimationCurve: Curves.elasticInOut,
            promptDuration: const Duration(milliseconds: 400),
            enabledAtOffset: 800,
            alwaysVisibleAtOffset: true,
            scrollOffsetUntilVisible: 500,
            promptReplacementBuilder: (context, function) => InkWell(
              onTap: () => function(),
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
              ),
            ),
            builder:
                (BuildContext context, ScrollViewProperties properties) =>
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // NativAdScreen(),
                    nativeAdView(),
                    Flexible(
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: FutureBuilder(
                                  future: controller.newsapi(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasData) {
                                      NewsModel data = snapshot.data;
                                      return RefreshIndicator(
                                        color: Colors.red,
                                        displacement: 60,
                                        onRefresh: () async {
                                          controller.newsapi();
                                        },
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: data.storyList!.length,
                                          itemBuilder: (context, index) {
                                            controller.newsLastId.value = data.storyList!.last.story!.id.toString();
                                            return InkWell(
                                              onTap: () {
                                                Get.to(() => NewsDetailsScreen(
                                                  newsId:
                                                  "${data.storyList![index].story?.id}",
                                                ));
                                              },
                                              child: SizedBox(
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets.all(10.sp),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Image.network(
                                                            controller
                                                                .getImage(
                                                                "${data.storyList?[index].story?.imageId}"),
                                                            height: 80.h,
                                                            width: 80.w,
                                                            fit: BoxFit.fill,
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.all(
                                                                8.sp),
                                                            child: SizedBox(
                                                              height: 90.h,
                                                              width: 244.w,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                                children: [
                                                                  Flexible(
                                                                    child: Text(
                                                                      "${data.storyList?[index].story?.hline}",
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      maxLines:
                                                                      2,
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize: 16
                                                                              .sp,
                                                                          fontWeight:
                                                                          FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: Text(
                                                                      "${data.storyList?[index].story?.context}",
                                                                      style: GoogleFonts.poppins(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color:
                                                                          Colors.grey[700]),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                        "${data.storyList?[index].story?.intro}",
                                                        style: GoogleFonts
                                                            .poppins(),
                                                        maxLines: 4,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            if (index % 5 == 4) {
                                              return NativAdScreen();
                                            }
                                            return divider();
                                          },
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      Center(
                                          child: Text(
                                            "No Data!",
                                            style: GoogleFonts.poppins(
                                                fontSize: 25, fontWeight: FontWeight.w600),
                                          ));
                                    }
                                    return Center(
                                      child: Container()
                                    );
                                  },
                                ),
                              ),
                              Obx(
                                    ()=> Flexible(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemCount:
                                    controller.moreNews.length + 1,
                                    itemBuilder: (context, index) {
                                      if(index < controller.moreNews.length){
                                        controller
                                            .scrollNewsLastId.value =
                                        "${controller.moreNews.last.story?.id}";
                                        controller
                                            .scrollNewsFirstId.value =
                                        "${controller.moreNews[0].story?.id}";

                                        return InkWell(
                                          onTap: () {
                                            Get.to(() => NewsDetailsScreen(
                                              newsId:
                                              "${controller.moreNews[index].story?.id}",
                                            ));
                                          },
                                          child: SizedBox(
                                            child: Padding(
                                              padding:
                                              EdgeInsets.all(10.sp),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.network(
                                                        controller
                                                            .getImage(
                                                            "${controller.moreNews[index].story?.imageId}"),
                                                        height: 80.h,
                                                        width: 80.w,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.all(
                                                            8.sp),
                                                        child: SizedBox(
                                                          height: 90.h,
                                                          width: 244.w,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  "${controller.moreNews[index].story?.hline}",
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                                  maxLines:
                                                                  2,
                                                                  style: GoogleFonts.poppins(
                                                                      fontSize: 16
                                                                          .sp,
                                                                      fontWeight:
                                                                      FontWeight.w600),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Text(
                                                                  "${controller.moreNews[index].story?.context}",
                                                                  style: GoogleFonts.poppins(
                                                                      fontSize: 14
                                                                          .sp,
                                                                      color:
                                                                      Colors.grey[700]),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    "${controller.moreNews[index].story?.intro}",
                                                    style: GoogleFonts
                                                        .poppins(),
                                                    maxLines: 4,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }else{
                                        return Obx(() => controller.noMoreData.value == true?Container():Padding(
                                          padding: EdgeInsets.symmetric(vertical: 25.h),
                                          child: Center(child: CupertinoActivityIndicator(color: Colors.red.shade900,radius: 15.sp,)),
                                        ));
                                      }
                                    },
                                    separatorBuilder: (context, index) {
                                      if (index % 5 == 4) {
                                        return NativAdScreen();
                                      }
                                      return divider();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // bannerAdView(),
                    BannerAD(),
                  ],
                ),
          ),
        ),)
      ),
    );
  }

  ScrollController? scrollController = ScrollController();
  int scrollindex = 1;

  void _getData() async {
    if (scrollindex > 2) {
      if (controller.scrollNewsFirstId.value !=
          controller.scrollNewsLastId.value) {
        controller.getMoreNewsApi(controller.scrollNewsLastId.value);
      }
      debugPrint(
          "this is scroll take ---------------${controller.scrollNewsLastId.value} -------------$scrollindex");
    } else {
      controller.getMoreNewsApi(controller.newsLastId.value);
      // print("123456789==================================================");
      debugPrint(
          "this is scroll take ---------------${controller.newsLastId.value} -------------$scrollindex");
    }
  }
}

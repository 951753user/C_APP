import 'package:cricbuzzapp/controller/adController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Widget nativeAdView(){
//   return adManager.nativeAd == null?
//   Container():Container(
//     height: 80.h,
//     child: AdWidget(
//       ad: adManager.getNativeAd()..load(),
//     ),
//   );
// }
//
// Widget bannerAdView(){
//   return adManager.bannerAd == null?Container():Container(
//     height: adManager.bannerAd?.size.height.toDouble(),
//     width: adManager.bannerAd?.size.width.toDouble(),
//     child: AdWidget(ad: adManager.getBannerad()..load()),
//   );
// }


Widget nativeAdView(){
  return nativeLoading == false
      ? Container()
      : SizedBox(
      height: 80.h,
      // color: Colors.white,
      child: AdWidget(ad: nativeAd!));
}

Widget bannerAdView(){
  return bannerLoad == false?Container():SizedBox(
    width: banner?.size.width.toDouble(),
    height: banner?.size.height.toDouble(),
    child: AdWidget(
      ad: banner!,
    ),
  );
}
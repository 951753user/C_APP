// import 'package:cricbuzzapp/view/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class NatiAdScreen extends StatefulWidget {
//   NatiAdScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NatiAdScreen> createState() => _NatiAdScreenState();
// }
//
// class _NatiAdScreenState extends State<NatiAdScreen> {
//   NativeAd? nativeAd;
//   bool isloading = false;
//
//   // ApiController apiController = Get.put(ApiController());
//
//   int attempt = 0;
//
//   void nativecall() {
//     // var resonce = await apiController.adsApi();
//     nativeAd = NativeAd(
//       //"ca-app-pub-3940256099942544/2247696110"
//       adUnitId: nativeAdId,
//       factoryId: "listTilesmall",
//       listener: NativeAdListener(
//         onAdLoaded: (ad) {
//           // setState(() {
//           //   nativeAd = ad as NativeAd;
//           // });
//           isloading = true;
//           attempt++;
//           debugPrint(
//               "========================================================================================================NATIV AD LOAD   , Attempt  $attempt");
//           // isloading = true;
//         },
//         onAdImpression: (ad){
//           isloading = true;
//         },
//         onAdFailedToLoad: (ad, error) {
//           debugPrint("$error");
//           debugPrint(
//               "--------------------------------------------------------------------------------------------------------NATIV AD NOT LOAD");
//           nativeAd?.dispose();
//         },
//       ),
//       request: AdRequest(),
//     );
//     nativeAd?.load();
//   }
//
//   @override
//   void initState() {
//     nativecall();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isloading
//         ? Container()
//         : SizedBox(
//         height: 80.h,
//         // color: Colors.white,
//         child: AdWidget(ad: nativeAd!..load()));
//   }
// }

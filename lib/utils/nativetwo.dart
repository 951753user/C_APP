import 'package:cricbuzzapp/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativAdScreen extends StatefulWidget {
  NativAdScreen({Key? key}) : super(key: key);

  @override
  State<NativAdScreen> createState() => _NativAdScreenState();
}

class _NativAdScreenState extends State<NativAdScreen> {
  late NativeAd nativeAd;
  bool isloading = false;

  // ApiController apiController = Get.put(ApiController());

  int attempt = 0;

  void nativecall() async {
    // var resonce = await apiController.adsApi();
    nativeAd = NativeAd(
      //"ca-app-pub-3940256099942544/2247696110"
      adUnitId: "/22903425359/com.nk.crick11live/Avstudio_Native",
      factoryId: "listTilesmall",
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            attempt++;
            nativeAd = ad as NativeAd;
          });

          debugPrint(
              "========================================================================================================NATIV AD TWO LOAD   , Attempt  $attempt");
          isloading = true;
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint("$error");
          debugPrint(
              "--------------------------------------------------------------------------------------------------------NATIV AD TWO NOT LOAD");

          nativeAd.dispose();
        },
      ),
      request: AdRequest(),
    );
    nativeAd.load();
  }

  @override
  void initState() {
    nativecall();
    attempt++;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isloading == true
        ? SizedBox(
            height: 80.h,
            // color: Colors.white,
            child: AdWidget(ad: nativeAd))
        : Container();
  }
}

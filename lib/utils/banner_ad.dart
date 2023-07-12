// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:cricbuzzapp/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'anchored_adaptive_banner_adSize.dart';

class BannerAD extends StatefulWidget {

  BannerAD({Key? key,}) : super(key: key);

  @override
  _BannerADState createState() => _BannerADState();
}

class _BannerADState extends State<BannerAD> {
  BannerAd? banner;

  bool adStatus = true;
  bool status = false;

  AnchoredAdaptiveBannerAdSize? size;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bannercall();
  }

  int attempt = 0;

  Future<void> bannercall() async {
    size = await anchoredAdaptiveBannerAdSize(context);
    // var resonce = await apiController.adsApi();

    banner = BannerAd(
      // "ca-app-pub-3940256099942544/6300978111"
      adUnitId: "/22903425359/com.nk.crick11live/Avstudio_Banner",
      size: size!,
      listener: BannerAdListener(onAdLoaded: (ad) {
        attempt++;

        setState(() {
          banner = ad as BannerAd;
        });

        debugPrint("============================BANNER LOAD  , Attempt :- $attempt");
      }, onAdFailedToLoad: (ad, error) {
        debugPrint("----------------------------BANNER NOT LOAD");
        ad.dispose();
      }),
      request: AdRequest(),
    );

    banner?.load();
  }

  @override
  Widget build(BuildContext context) {
      return banner == null?Container():SizedBox(
        width: banner?.size.width.toDouble(),
        height: banner?.size.height.toDouble(),
        child: AdWidget(
          ad: banner!,
        ),
      );
  }
}

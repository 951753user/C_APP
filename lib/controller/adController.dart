// ignore_for_file: file_names

import 'package:cricbuzzapp/utils/anchored_adaptive_banner_adSize.dart';
import 'package:cricbuzzapp/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

InterstitialAd? interstitialAd;

int interstitialAttempt = 0;

void initAdplay() {
  // var responce = await adsApi();
  InterstitialAd.load(
    // ca-app-pub-3940256099942544/1033173712
    adUnitId: "/22903425359/com.nk.crick11live/Avstudio_interstatial",
    request:  AdRequest(),
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        interstitialAd = ad;

        interstitialAttempt++;
        debugPrint(
            "===================================================================================Interstitial   Attempt  , $interstitialAttempt");
      },
      onAdFailedToLoad: (error) {
        debugPrint(
            "===================================================================================Interstitial fail  Attempt");
      },
    ),
  );
}


int attempt = 0;

BannerAd? banner;

bool adStatus = true;
bool status = false;

AnchoredAdaptiveBannerAdSize? size;

bool bannerLoad = false;

void bannercall(BuildContext context) async {
  size = await anchoredAdaptiveBannerAdSize(context);
  // var resonce = await apiController.adsApi();

  banner = BannerAd(
    // "ca-app-pub-3940256099942544/6300978111"
    adUnitId: "/22903425359/com.nk.crick11live/Avstudio_Banner",
    size: size!,
    listener: BannerAdListener(onAdLoaded: (ad) {
      attempt++;

        banner = ad as BannerAd;
        bannerLoad = true;

      debugPrint("============================BANNER LOAD  , Attempt :- $attempt");
    }, onAdFailedToLoad: (ad, error) {
      debugPrint("----------------------------BANNER NOT LOAD");
      bannerLoad = false;
      ad.dispose();
    }),
    request: AdRequest(),
  );
  banner?.load();
}


NativeAd? nativeAd;
bool nativeLoading = false;

// ApiController apiController = Get.put(ApiController());

int nativeAttempt = 0;

void nativecall() async {
  // var resonce = await apiController.adsApi();
  nativeAd = NativeAd(
    //"ca-app-pub-3940256099942544/2247696110"
    adUnitId: "/22903425359/com.nk.crick11live/Avstudio_Native",
    factoryId: "listTilesmall",
    listener: NativeAdListener(
      onAdLoaded: (ad) {
          // nativeAd = ad as NativeAd;
        nativeAttempt++;
        debugPrint(
            "========================================================================================================NATIV AD LOAD   , Attempt  $nativeAttempt");
          nativeLoading = true;
      },
      onAdFailedToLoad: (ad, error) {
        debugPrint("$error");
        nativeLoading = false;
        debugPrint(
            "--------------------------------------------------------------------------------------------------------NATIV AD NOT LOAD");
        nativeAd?.dispose();
      },
    ),
    request:  AdRequest(),
  );
  nativeAd?.load();
}

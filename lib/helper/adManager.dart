import 'package:cricbuzzapp/utils/anchored_adaptive_banner_adSize.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  NativeAd? nativeAd;

  AnchoredAdaptiveBannerAdSize? size;

  int bannerAttempt = 0;
  int nativeAttempt = 0;

  void loadBannerAd() async{
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAttempt++;
          debugPrint("----------------------------------------------------------banner Loaded -----$bannerAttempt");
        },
        onAdImpression: (ad) {
          debugPrint("----------------------------------------------------------banner impression Loaded -----$bannerAttempt");
        },
        onAdFailedToLoad: (ad,error){
          bannerAd?.dispose();
          debugPrint("----------------------------------------------------------banner failed to Loaded");
        }
      ),
      request: const AdRequest(),
    );
    bannerAd?.load();
  }

  void loadNativeAd() {
    // var resonce = await apiController.adsApi();
    nativeAd = NativeAd(
      //"ca-app-pub-3940256099942544/2247696110"
      adUnitId: "ca-app-pub-3940256099942544/2247696110",
      factoryId: "listTilesmall",
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          nativeAttempt++;
          debugPrint("----------------------------------------------------------native Loaded --------$nativeAttempt");
        },
          onAdFailedToLoad: (ad,error){
          nativeAd?.dispose();
            debugPrint("----------------------------------------------------------native failed to Loaded");
          },
        onAdImpression: (ad) {
          debugPrint("----------------------------------------------------------native impression Loaded --------$nativeAttempt");
        },
      ),
      request: const AdRequest(),
    );
    nativeAd?.load();
  }

  BannerAd getBannerad(){
    return bannerAd!;
  }

  NativeAd getNativeAd(){
    return nativeAd!;
  }

  void addAds(bool banner,bool native){
    if(banner){
      loadBannerAd();
    }

    if(native){
      loadNativeAd();
    }
  }

  void disposeAds(){
    bannerAd?.dispose();
    // nativeAd?.dispose();
  }
}
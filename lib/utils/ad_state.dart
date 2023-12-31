import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;
  AdState(this.initialization);

  // String? get bannerAdUnitId => Platform.isAndroid
  //     ? 'ca-app-pub-3940256099942544/6300978111' // Test AdUnitId.
  // // ? null // Use this stop ads and you can modify this behaviour in didChangeDependencies() of BannerAD().
  //     : 'ca-app-pub-3940256099942544/2934735716';

  // static bool adStatus = true;
  // static bool status = false;

  AdManagerBannerAdListener get adListener => _adListener;

  final AdManagerBannerAdListener _adListener = AdManagerBannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) {
      debugPrint('Ad loaded.');
      // adStatus = true;
    },
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      debugPrint('Ad failed to load: $error');
      // adStatus = false;
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => debugPrint('Ad impression.'),
    onAppEvent: (ad, name, data) =>
        debugPrint('App event : ${ad.adUnitId}, $name, $data.'),
  );
}
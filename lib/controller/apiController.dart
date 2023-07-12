import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


// class ApiController extends GetxController {

  InterstitialAd? interstitialAd;

  int attempt = 0;




class AdsModel{
  String? banner,inter,native;

  AdsModel({this.banner, this.inter, this.native});
}

  void initAdplay()  {
    // var responce = await adsApi();
    InterstitialAd.load(
      // ca-app-pub-3940256099942544/1033173712
      adUnitId: "",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(

        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;

          attempt++;
          print("===================================================================================INterstitial   Attempt  , $attempt");

        },
        onAdFailedToLoad: (error) {
            print("===================================================================================INterstitial fail  Attempt");


        },
      ),
    );


  }


// }



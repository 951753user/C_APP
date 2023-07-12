import 'dart:async';

import 'package:cricbuzzapp/controller/adController.dart';
import 'package:cricbuzzapp/controller/adsApiController.dart';
import 'package:cricbuzzapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


String bannerAdId = "";
String nativeAdId = "";
String interstitialAdId = "";


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFadeAnimation = false;
  AdsApiController adController = Get.put(AdsApiController());


  @override
  void initState() {
    getAdKey();

    nativecall();
    initplatform();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        isFadeAnimation = true;
      });
    });
    Timer(const Duration(seconds: 4), () {
      Get.offNamed(AppPages.nav);
    });
    super.initState();
  }




  getAdKey()async{
    var data = await adController.getAdsApi();

    bannerAdId = data.bannerIdOne;
    nativeAdId = data.nativeIdOne;
    interstitialAdId = data.interstitialIdOne;

  }

  Future<void> initplatform() async {
    if (!mounted) return;

    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      debugPrint('NOTIFICATION OPENED HANDLER CALLED WITH: $result');
      setState(() {});
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      debugPrint('FOREGROUND HANDLER CALLED WITH: $event');

      /// Display Notification, send null to not display
    });

    OneSignal.shared.setAppId("65145825-7dca-4827-a646-05da935ceae1");
  }

  @override
  void didChangeDependencies() {
    bannercall(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.bottomRight,
                begin: Alignment.topLeft,
                colors: [
              Color.fromARGB(255, 239, 67, 61),
              Color.fromARGB(255, 107, 2, 5)
            ])),
        child: AnimatedOpacity(
          opacity: isFadeAnimation ? 1 : 0,
          duration: const Duration(seconds: 2),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('assets/image/applogo.png'),
                  height: 160.h,
                  width: 160.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

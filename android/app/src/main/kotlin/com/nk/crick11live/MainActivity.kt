package com.nk.crick11live

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // TODO: Register the ListTileNativeAdFactory
//        GoogleMobileAdsPlugin.registerNativeAdFactory(
//            flutterEngine, "listTile",
//            ListTileNativeAdFactory(context)
//        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "listTilesmall", ListTileNativeAdSmallFactory(context))

//        GoogleMobileAdsPlugin.registerNativeAdFactory(
//            flutterEngine, "listTilevideo", populateUnifiedNativeAdView(context)
//        )

//        GoogleMobileAdsPlugin.registerNativeAdFactory(
//            flutterEngine, "listTileMedium",
//            TemplateView(context)
//        )
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        // TODO: Unregister the ListTileNativeAdFactory
//        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTilesmall")
//        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTilevideo")
    }
}

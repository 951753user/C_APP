// To parse this JSON data, do
//
//     final adsModel = adsModelFromJson(jsonString);

import 'dart:convert';

AdsModel adsModelFromJson(String str) => AdsModel.fromJson(json.decode(str));

String adsModelToJson(AdsModel data) => json.encode(data.toJson());

class AdsModel {
  AdsModel({
    this.appId,
    this.bannerIdOne,
    this.interstitialIdOne,
    this.appOpenIdOne,
    this.nativeIdOne,
    this.bannerIdTwo,
    this.interstitialIdTwo,
    this.appOpenIdTwo,
    this.nativeIdTwo,
  });

  String? appId;
  String? bannerIdOne;
  String? interstitialIdOne;
  String? appOpenIdOne;
  String? nativeIdOne;
  String? bannerIdTwo;
  String? interstitialIdTwo;
  String? appOpenIdTwo;
  String? nativeIdTwo;

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
    appId: json["AppID"],
    bannerIdOne: json["BannerID_one"],
    interstitialIdOne: json["InterstitialID_one"],
    appOpenIdOne: json["AppOpenID_one"],
    nativeIdOne: json["NativeID_one"],
    bannerIdTwo: json["BannerID_two"],
    interstitialIdTwo: json["InterstitialID_two"],
    appOpenIdTwo: json["AppOpenID_two"],
    nativeIdTwo: json["NativeID_two"],
  );

  Map<String, dynamic> toJson() => {
    "AppID": appId,
    "BannerID_one": bannerIdOne,
    "InterstitialID_one": interstitialIdOne,
    "AppOpenID_one": appOpenIdOne,
    "NativeID_one": nativeIdOne,
    "BannerID_two": bannerIdTwo,
    "InterstitialID_two": interstitialIdTwo,
    "AppOpenID_two": appOpenIdTwo,
    "NativeID_two": nativeIdTwo,
  };
}

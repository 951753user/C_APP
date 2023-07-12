// To parse this JSON data, do
//
//     final browseTeamModel = browseTeamModelFromJson(jsonString);

import 'dart:convert';

BrowseTeamModel browseTeamModelFromJson(String str) => BrowseTeamModel.fromJson(json.decode(str));

String browseTeamModelToJson(BrowseTeamModel data) => json.encode(data.toJson());

class BrowseTeamModel {
  BrowseTeamModel({
    this.list,
    this.appIndex,
  });

  List<ListElement>? list;
  AppIndex? appIndex;

  factory BrowseTeamModel.fromJson(Map<String, dynamic> json) => BrowseTeamModel(
    list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
    appIndex: json["appIndex"] == null ? null : AppIndex.fromJson(json["appIndex"]),
  );

  Map<String, dynamic> toJson() => {
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
    "appIndex": appIndex?.toJson(),
  };
}

class AppIndex {
  AppIndex({
    this.seoTitle,
    this.webUrl,
  });

  String? seoTitle;
  String? webUrl;

  factory AppIndex.fromJson(Map<String, dynamic> json) => AppIndex(
    seoTitle: json["seoTitle"],
    webUrl: json["webURL"],
  );

  Map<String, dynamic> toJson() => {
    "seoTitle": seoTitle,
    "webURL": webUrl,
  };
}

class ListElement {
  ListElement({
    this.teamName,
    this.teamId,
    this.teamSName,
    this.imageId,
    this.countryName,
  });

  String? teamName;
  int? teamId;
  String? teamSName;
  int? imageId;
  String? countryName;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    teamName: json["teamName"],
    teamId: json["teamId"],
    teamSName: json["teamSName"],
    imageId: json["imageId"],
    countryName: json["countryName"],
  );

  Map<String, dynamic> toJson() => {
    "teamName": teamName,
    "teamId": teamId,
    "teamSName": teamSName,
    "imageId": imageId,
    "countryName": countryName,
  };
}

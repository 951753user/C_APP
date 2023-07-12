// To parse this JSON data, do
//
//     final seriesSquadsModel = seriesSquadsModelFromJson(jsonString);

import 'dart:convert';

SeriesSquadsModel seriesSquadsModelFromJson(String str) => SeriesSquadsModel.fromJson(json.decode(str));

String seriesSquadsModelToJson(SeriesSquadsModel data) => json.encode(data.toJson());

class SeriesSquadsModel {
  SeriesSquadsModel({
    this.squads,
    this.appIndex,
    this.seriesName,
    this.seriesId,
  });

  List<Squad>? squads;
  AppIndex? appIndex;
  String? seriesName;
  int? seriesId;

  factory SeriesSquadsModel.fromJson(Map<String, dynamic> json) => SeriesSquadsModel(
    squads: json["squads"] == null ? [] : List<Squad>.from(json["squads"]!.map((x) => Squad.fromJson(x))),
    appIndex: json["appIndex"] == null ? null : AppIndex.fromJson(json["appIndex"]),
    seriesName: json["seriesName"],
    seriesId: json["seriesId"],
  );

  Map<String, dynamic> toJson() => {
    "squads": squads == null ? [] : List<dynamic>.from(squads!.map((x) => x.toJson())),
    "appIndex": appIndex?.toJson(),
    "seriesName": seriesName,
    "seriesId": seriesId,
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

class Squad {
  Squad({
    this.squadType,
    this.isHeader,
    this.squadId,
    this.imageId,
    this.teamId,
  });

  String? squadType;
  bool? isHeader;
  int? squadId;
  int? imageId;
  int? teamId;

  factory Squad.fromJson(Map<String, dynamic> json) => Squad(
    squadType: json["squadType"],
    isHeader: json["isHeader"],
    squadId: json["squadId"],
    imageId: json["imageId"],
    teamId: json["teamId"],
  );

  Map<String, dynamic> toJson() => {
    "squadType": squadType,
    "isHeader": isHeader,
    "squadId": squadId,
    "imageId": imageId,
    "teamId": teamId,
  };
}

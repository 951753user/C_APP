// To parse this JSON data, do
//
//     final browseInternationalSeriesModel = browseInternationalSeriesModelFromJson(jsonString);

import 'dart:convert';

BrowseInternationalSeriesModel browseInternationalSeriesModelFromJson(String str) => BrowseInternationalSeriesModel.fromJson(json.decode(str));

String browseInternationalSeriesModelToJson(BrowseInternationalSeriesModel data) => json.encode(data.toJson());

class BrowseInternationalSeriesModel {
  BrowseInternationalSeriesModel({
    this.seriesMapProto,
    this.appIndex,
  });

  List<SeriesMapProto>? seriesMapProto;
  AppIndex? appIndex;

  factory BrowseInternationalSeriesModel.fromJson(Map<String, dynamic> json) => BrowseInternationalSeriesModel(
    seriesMapProto: json["seriesMapProto"] == null ? [] : List<SeriesMapProto>.from(json["seriesMapProto"]!.map((x) => SeriesMapProto.fromJson(x))),
    appIndex: json["appIndex"] == null ? null : AppIndex.fromJson(json["appIndex"]),
  );

  Map<String, dynamic> toJson() => {
    "seriesMapProto": seriesMapProto == null ? [] : List<dynamic>.from(seriesMapProto!.map((x) => x.toJson())),
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

class SeriesMapProto {
  SeriesMapProto({
    this.date,
    this.series,
  });

  String? date;
  List<Series>? series;

  factory SeriesMapProto.fromJson(Map<String, dynamic> json) => SeriesMapProto(
    date: json["date"],
    series: json["series"] == null ? [] : List<Series>.from(json["series"]!.map((x) => Series.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "series": series == null ? [] : List<dynamic>.from(series!.map((x) => x.toJson())),
  };
}

class Series {
  Series({
    this.id,
    this.name,
    this.startDt,
    this.endDt,
  });

  int? id;
  String? name;
  String? startDt;
  String? endDt;

  factory Series.fromJson(Map<String, dynamic> json) => Series(
    id: json["id"],
    name: json["name"],
    startDt: json["startDt"],
    endDt: json["endDt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "startDt": startDt,
    "endDt": endDt,
  };
}

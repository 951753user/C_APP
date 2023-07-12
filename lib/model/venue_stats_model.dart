// To parse this JSON data, do
//
//     final venuestatsModel = venuestatsModelFromJson(jsonString);

import 'dart:convert';

VenuestatsModel venuestatsModelFromJson(String str) => VenuestatsModel.fromJson(json.decode(str));

String venuestatsModelToJson(VenuestatsModel data) => json.encode(data.toJson());

class VenuestatsModel {
  VenuestatsModel({
    this.venueStats,
  });

  List<VenueStat>? venueStats;

  factory VenuestatsModel.fromJson(Map<String, dynamic> json) => VenuestatsModel(
    venueStats: json["venueStats"] == null ? [] : List<VenueStat>.from(json["venueStats"]!.map((x) => VenueStat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "venueStats": venueStats == null ? [] : List<dynamic>.from(venueStats!.map((x) => x.toJson())),
  };
}

class VenueStat {
  VenueStat({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  factory VenueStat.fromJson(Map<String, dynamic> json) => VenueStat(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}

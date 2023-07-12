// To parse this JSON data, do
//
//     final statsDetailsModel = statsDetailsModelFromJson(jsonString);

import 'dart:convert';

StatsDetailsModel statsDetailsModelFromJson(String str) => StatsDetailsModel.fromJson(json.decode(str));

String statsDetailsModelToJson(StatsDetailsModel data) => json.encode(data.toJson());

class StatsDetailsModel {
  StatsDetailsModel({
    this.odiStatsList,
    this.t20StatsList,
  });

  StatsList? odiStatsList;
  StatsList? t20StatsList;

  factory StatsDetailsModel.fromJson(Map<String, dynamic> json) => StatsDetailsModel(
    odiStatsList: json["odiStatsList"] == null ? null : StatsList.fromJson(json["odiStatsList"]),
    t20StatsList: json["t20StatsList"] == null ? null : StatsList.fromJson(json["t20StatsList"]),
  );

  Map<String, dynamic> toJson() => {
    "odiStatsList": odiStatsList?.toJson(),
    "t20StatsList": t20StatsList?.toJson(),
  };
}

class StatsList {
  StatsList({
    this.headers,
    this.values,
  });

  List<String>? headers;
  List<Value>? values;

  factory StatsList.fromJson(Map<String, dynamic> json) => StatsList(
    headers: json["headers"] == null ? [] : List<String>.from(json["headers"]!.map((x) => x)),
    values: json["values"] == null ? [] : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "headers": headers == null ? [] : List<dynamic>.from(headers!.map((x) => x)),
    "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
  };
}

class Value {
  Value({
    this.values,
  });

  List<String>? values;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    values: json["values"] == null ? [] : List<String>.from(json["values"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
  };
}

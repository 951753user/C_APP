// To parse this JSON data, do
//
//     final statsModel = statsModelFromJson(jsonString);

import 'dart:convert';

StatsModel statsModelFromJson(String str) => StatsModel.fromJson(json.decode(str));

String statsModelToJson(StatsModel data) => json.encode(data.toJson());

class StatsModel {
  StatsModel({
    this.types,
  });

  dynamic types;

  factory StatsModel.fromJson(Map<String, dynamic> json) => StatsModel(
    types: json["types"] == null ? [] : List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "types": types == null ? [] : List<dynamic>.from(types.map((x) => x.toJson())),
  };
}

class Type {
  Type({
    this.header,
    this.value,
    this.category,
  });

  String? header;
  String? value;
  dynamic category;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    header: json["header"],
    value: json["value"],
    category: categoryValues.map[json["category"]],
  );

  Map<String, dynamic> toJson() => {
    "header": header,
    "value": value,
    "category": categoryValues.reverse[category],
  };
}

enum Category { BATTING, BOWLING }

final categoryValues = EnumValues({
  "Batting": Category.BATTING,
  "Bowling": Category.BOWLING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

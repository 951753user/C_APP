// To parse this JSON data, do
//
//     final pointTableModel = pointTableModelFromJson(jsonString);

import 'dart:convert';

PointTableModel pointTableModelFromJson(String str) => PointTableModel.fromJson(json.decode(str));

String pointTableModelToJson(PointTableModel data) => json.encode(data.toJson());

class PointTableModel {
  PointTableModel({
    this.seriesId,
    this.seriesName,
    this.minQual,
    this.order,
    this.title,
    this.header,
    this.considerGroup,
    this.group,
  });

  String? seriesId;
  String? seriesName;
  dynamic minQual;
  dynamic order;
  dynamic title;
  dynamic header;
  bool? considerGroup;
  dynamic group;

  factory PointTableModel.fromJson(Map<String, dynamic> json) => PointTableModel(
    seriesId: json["series_id"],
    seriesName: json["series_name"],
    minQual: json["min_qual"] == null ? null : MinQual.fromJson(json["min_qual"]),
    order: json["order"] == null ? [] : List<String>.from(json["order"]!.map((x) => x)),
    title: json["title"] == null ? [] : List<String>.from(json["title"]!.map((x) => x)),
    header: json["header"] == null ? [] : List<String>.from(json["header"]!.map((x) => x)),
    considerGroup: json["consider_group"],
    group: json["group"] == null ? null : Group.fromJson(json["group"]),
  );

  Map<String, dynamic> toJson() => {
    "series_id": seriesId,
    "series_name": seriesName,
    "min_qual": minQual?.toJson(),
    "order": order == null ? [] : List<dynamic>.from(order!.map((x) => x)),
    "title": title == null ? [] : List<dynamic>.from(title!.map((x) => x)),
    "header": header == null ? [] : List<dynamic>.from(header!.map((x) => x)),
    "consider_group": considerGroup,
    "group": group?.toJson(),
  };
}

class Group {
  Group({
    this.teams,
  });

  dynamic teams;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    teams: json["Teams"] == null ? [] : List<Team>.from(json["Teams"].map((x) => Team.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Teams": teams == null ? [] : List<dynamic>.from(teams!.map((x) => x.toJson())),
  };
}

class Team {
  Team({
    this.id,
    this.name,
    this.p,
    this.w,
    this.l,
    this.nr,
    this.t,
    this.points,
    this.nrr,
  });

  String? id;
  String? name;
  String? p;
  String? w;
  String? l;
  String? nr;
  String? t;
  String? points;
  String? nrr;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    name: json["name"],
    p: json["p"],
    w: json["w"],
    l: json["l"],
    nr: json["nr"],
    t: json["t"],
    points: json["points"],
    nrr: json["nrr"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "p": p,
    "w": w,
    "l": l,
    "nr": nr,
    "t": t,
    "points": points,
    "nrr": nrr,
  };
}

class MinQual {
  MinQual({
    this.teams,
  });

  String? teams;

  factory MinQual.fromJson(Map<String, dynamic> json) => MinQual(
    teams: json["Teams"],
  );

  Map<String, dynamic> toJson() => {
    "Teams": teams,
  };
}

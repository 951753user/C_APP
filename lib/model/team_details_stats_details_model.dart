// To parse this JSON data, do
//
//     final teamStatsDetailsModel = teamStatsDetailsModelFromJson(jsonString);

import 'dart:convert';

TeamStatsDetailsModel teamStatsDetailsModelFromJson(String str) => TeamStatsDetailsModel.fromJson(json.decode(str));

String teamStatsDetailsModelToJson(TeamStatsDetailsModel data) => json.encode(data.toJson());

class TeamStatsDetailsModel {
  TeamStatsDetailsModel({
    this.filter,
    this.headers,
    this.values,
    this.appIndex,
  });

  Filter? filter;
  List<String>? headers;
  List<Value>? values;
  AppIndex? appIndex;

  factory TeamStatsDetailsModel.fromJson(Map<String, dynamic> json) => TeamStatsDetailsModel(
    filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    headers: json["headers"] == null ? [] : List<String>.from(json["headers"]!.map((x) => x)),
    values: json["values"] == null ? [] : List<Value>.from(json["values"]!.map((x) => Value.fromJson(x))),
    appIndex: json["appIndex"] == null ? null : AppIndex.fromJson(json["appIndex"]),
  );

  Map<String, dynamic> toJson() => {
    "filter": filter?.toJson(),
    "headers": headers == null ? [] : List<dynamic>.from(headers!.map((x) => x)),
    "values": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
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

class Filter {
  Filter({
    this.matchtype,
    this.team,
    this.selectedMatchType,
    this.selectedYear,
    this.selectedTeam,
  });

  List<Matchtype>? matchtype;
  List<Team>? team;
  String? selectedMatchType;
  String? selectedYear;
  String? selectedTeam;

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    matchtype: json["matchtype"] == null ? [] : List<Matchtype>.from(json["matchtype"]!.map((x) => Matchtype.fromJson(x))),
    team: json["team"] == null ? [] : List<Team>.from(json["team"]!.map((x) => Team.fromJson(x))),
    selectedMatchType: json["selectedMatchType"],
    selectedYear: json["selectedYear"],
    selectedTeam: json["selectedTeam"],
  );

  Map<String, dynamic> toJson() => {
    "matchtype": matchtype == null ? [] : List<dynamic>.from(matchtype!.map((x) => x.toJson())),
    "team": team == null ? [] : List<dynamic>.from(team!.map((x) => x.toJson())),
    "selectedMatchType": selectedMatchType,
    "selectedYear": selectedYear,
    "selectedTeam": selectedTeam,
  };
}

class Matchtype {
  Matchtype({
    this.matchTypeId,
    this.matchTypeDesc,
  });

  String? matchTypeId;
  String? matchTypeDesc;

  factory Matchtype.fromJson(Map<String, dynamic> json) => Matchtype(
    matchTypeId: json["matchTypeId"],
    matchTypeDesc: json["matchTypeDesc"],
  );

  Map<String, dynamic> toJson() => {
    "matchTypeId": matchTypeId,
    "matchTypeDesc": matchTypeDesc,
  };
}

class Team {
  Team({
    this.id,
    this.teamShortName,
  });

  String? id;
  String? teamShortName;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    teamShortName: json["teamShortName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "teamShortName": teamShortName,
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

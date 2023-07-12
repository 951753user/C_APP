// To parse this JSON data, do
//
//     final scheduleMatchesModel = scheduleMatchesModelFromJson(jsonString);

import 'dart:convert';

ScheduleMatchesModel scheduleMatchesModelFromJson(String str) => ScheduleMatchesModel.fromJson(json.decode(str));

String scheduleMatchesModelToJson(ScheduleMatchesModel data) => json.encode(data.toJson());

class ScheduleMatchesModel {
  ScheduleMatchesModel({
    this.matchScheduleMap,
    this.startDt,
  });

  List<MatchScheduleMap>? matchScheduleMap;
  List<String>? startDt;

  factory ScheduleMatchesModel.fromJson(Map<String, dynamic> json) => ScheduleMatchesModel(
    matchScheduleMap: json["matchScheduleMap"] == null ? [] : List<MatchScheduleMap>.from(json["matchScheduleMap"]!.map((x) => MatchScheduleMap.fromJson(x))),
    startDt: json["startDt"] == null ? [] : List<String>.from(json["startDt"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "matchScheduleMap": matchScheduleMap == null ? [] : List<dynamic>.from(matchScheduleMap!.map((x) => x.toJson())),
    "startDt": startDt == null ? [] : List<dynamic>.from(startDt!.map((x) => x)),
  };
}

class MatchScheduleMap {
  MatchScheduleMap({
    this.scheduleAdWrapper,
  });

  ScheduleAdWrapper? scheduleAdWrapper;

  factory MatchScheduleMap.fromJson(Map<String, dynamic> json) => MatchScheduleMap(
    scheduleAdWrapper: json["scheduleAdWrapper"] == null ? null : ScheduleAdWrapper.fromJson(json["scheduleAdWrapper"]),
  );

  Map<String, dynamic> toJson() => {
    "scheduleAdWrapper": scheduleAdWrapper?.toJson(),
  };
}

class ScheduleAdWrapper {
  ScheduleAdWrapper({
    this.date,
    this.matchScheduleList,
    this.longDate,
  });

  String? date;
  List<MatchScheduleList>? matchScheduleList;
  String? longDate;

  factory ScheduleAdWrapper.fromJson(Map<String, dynamic> json) => ScheduleAdWrapper(
    date: json["date"],
    matchScheduleList: json["matchScheduleList"] == null ? [] : List<MatchScheduleList>.from(json["matchScheduleList"]!.map((x) => MatchScheduleList.fromJson(x))),
    longDate: json["longDate"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "matchScheduleList": matchScheduleList == null ? [] : List<dynamic>.from(matchScheduleList!.map((x) => x.toJson())),
    "longDate": longDate,
  };
}

class MatchScheduleList {
  MatchScheduleList({
    this.seriesName,
    this.matchInfo,
    this.seriesId,
    this.seriesHomeCountry,
    this.seriesCategory,
  });

  String? seriesName;
  List<MatchInfo>? matchInfo;
  int? seriesId;
  int? seriesHomeCountry;
  String? seriesCategory;

  factory MatchScheduleList.fromJson(Map<String, dynamic> json) => MatchScheduleList(
    seriesName: json["seriesName"],
    matchInfo: json["matchInfo"] == null ? [] : List<MatchInfo>.from(json["matchInfo"]!.map((x) => MatchInfo.fromJson(x))),
    seriesId: json["seriesId"],
    seriesHomeCountry: json["seriesHomeCountry"],
    seriesCategory: json["seriesCategory"],
  );

  Map<String, dynamic> toJson() => {
    "seriesName": seriesName,
    "matchInfo": matchInfo == null ? [] : List<dynamic>.from(matchInfo!.map((x) => x.toJson())),
    "seriesId": seriesId,
    "seriesHomeCountry": seriesHomeCountry,
    "seriesCategory": seriesCategory,
  };
}

class MatchInfo {
  MatchInfo({
    this.matchId,
    this.seriesId,
    this.matchDesc,
    this.matchFormat,
    this.startDate,
    this.endDate,
    this.team1,
    this.team2,
    this.venueInfo,
  });

  int? matchId;
  int? seriesId;
  String? matchDesc;
  String? matchFormat;
  String? startDate;
  String? endDate;
  Team? team1;
  Team? team2;
  VenueInfo? venueInfo;

  factory MatchInfo.fromJson(Map<String, dynamic> json) => MatchInfo(
    matchId: json["matchId"],
    seriesId: json["seriesId"],
    matchDesc: json["matchDesc"],
    matchFormat: json["matchFormat"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    team1: json["team1"] == null ? null : Team.fromJson(json["team1"]),
    team2: json["team2"] == null ? null : Team.fromJson(json["team2"]),
    venueInfo: json["venueInfo"] == null ? null : VenueInfo.fromJson(json["venueInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "matchId": matchId,
    "seriesId": seriesId,
    "matchDesc": matchDesc,
    "matchFormat": matchFormat,
    "startDate": startDate,
    "endDate": endDate,
    "team1": team1?.toJson(),
    "team2": team2?.toJson(),
    "venueInfo": venueInfo?.toJson(),
  };
}

class Team {
  Team({
    this.teamId,
    this.teamName,
    this.teamSName,
    this.imageId,
    this.isFullMember,
  });

  int? teamId;
  String? teamName;
  String? teamSName;
  int? imageId;
  bool? isFullMember;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    teamId: json["teamId"],
    teamName: json["teamName"],
    teamSName: json["teamSName"],
    imageId: json["imageId"],
    isFullMember: json["isFullMember"],
  );

  Map<String, dynamic> toJson() => {
    "teamId": teamId,
    "teamName": teamName,
    "teamSName": teamSName,
    "imageId": imageId,
    "isFullMember": isFullMember,
  };
}

class VenueInfo {
  VenueInfo({
    this.ground,
    this.city,
    this.country,
    this.timezone,
  });

  String? ground;
  String? city;
  String? country;
  String? timezone;

  factory VenueInfo.fromJson(Map<String, dynamic> json) => VenueInfo(
    ground: json["ground"],
    city: json["city"],
    country: json["country"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "ground": ground,
    "city": city,
    "country": country,
    "timezone": timezone,
  };
}


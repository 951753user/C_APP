// To parse this JSON data, do
//
//     final upcomingMatchesModel = upcomingMatchesModelFromJson(jsonString);

import 'dart:convert';

UpcomingMatchesModel upcomingMatchesModelFromJson(String str) => UpcomingMatchesModel.fromJson(json.decode(str));

String upcomingMatchesModelToJson(UpcomingMatchesModel data) => json.encode(data.toJson());

class UpcomingMatchesModel {
  UpcomingMatchesModel({
    this.typeMatches,
    this.filters,
    this.responseLastUpdated,
  });

  dynamic typeMatches;
  dynamic filters;
  String? responseLastUpdated;

  factory UpcomingMatchesModel.fromJson(Map<String, dynamic> json) => UpcomingMatchesModel(
    typeMatches: json["typeMatches"] == null ? [] : List<TypeMatch>.from(json["typeMatches"].map((x) => TypeMatch.fromJson(x))),
    filters: json["filters"] == null ? null : Filters.fromJson(json["filters"]),
    responseLastUpdated: json["responseLastUpdated"],
  );

  Map<String, dynamic> toJson() => {
    "typeMatches": typeMatches == null ? [] : List<dynamic>.from(typeMatches!.map((x) => x.toJson())),
    "filters": filters?.toJson(),
    "responseLastUpdated": responseLastUpdated,
  };
}

class Filters {
  Filters({
    this.matchType,
  });

  dynamic matchType;

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    matchType: json["matchType"] == null ? [] : List<String>.from(json["matchType"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "matchType": matchType == null ? [] : List<dynamic>.from(matchType!.map((x) => x)),
  };
}

class TypeMatch {
  TypeMatch({
    this.matchType,
    this.seriesMatches,
  });

  String? matchType;
  dynamic seriesMatches;

  factory TypeMatch.fromJson(Map<String, dynamic> json) => TypeMatch(
    matchType: json["matchType"],
    seriesMatches: json["seriesMatches"] == null ? [] : List<SeriesMatch>.from(json["seriesMatches"].map((x) => SeriesMatch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "matchType": matchType,
    "seriesMatches": seriesMatches == null ? [] : List<dynamic>.from(seriesMatches.map((x) => x.toJson())),
  };
}

class SeriesMatch {
  SeriesMatch({
    this.seriesAdWrapper,
  });

  dynamic seriesAdWrapper;

  factory SeriesMatch.fromJson(Map<String, dynamic> json) => SeriesMatch(
    seriesAdWrapper: json["seriesAdWrapper"] == null ? null : SeriesAdWrapper.fromJson(json["seriesAdWrapper"]),
  );

  Map<String, dynamic> toJson() => {
    "seriesAdWrapper": seriesAdWrapper?.toJson(),
  };
}

class SeriesAdWrapper {
  SeriesAdWrapper({
    this.seriesId,
    this.seriesName,
    this.matches,
  });

  dynamic seriesId;
  String? seriesName;
  dynamic matches;

  factory SeriesAdWrapper.fromJson(Map<String, dynamic> json) => SeriesAdWrapper(
    seriesId: json["seriesId"],
    seriesName: json["seriesName"],
    matches: json["matches"] == null ? [] : List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "seriesId": seriesId,
    "seriesName": seriesName,
    "matches": matches == null ? [] : List<dynamic>.from(matches!.map((x) => x.toJson())),
  };
}

class Match {
  Match({
    this.matchInfo,
  });

  dynamic matchInfo;

  factory Match.fromJson(Map<String, dynamic> json) => Match(
    matchInfo: json["matchInfo"] == null ? null : MatchInfo.fromJson(json["matchInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "matchInfo": matchInfo?.toJson(),
  };
}

class MatchInfo {
  MatchInfo({
    this.matchId,
    this.seriesId,
    this.seriesName,
    this.matchDesc,
    this.matchFormat,
    this.startDate,
    this.endDate,
    this.state,
    this.team1,
    this.team2,
    this.venueInfo,
    this.seriesStartDt,
    this.seriesEndDt,
    this.isTimeAnnounced,
    this.stateTitle,
    this.isFantasyEnabled,
  });

  dynamic matchId;
  dynamic seriesId;
  String? seriesName;
  String? matchDesc;
  dynamic matchFormat;
  String? startDate;
  String? endDate;
  String? state;
  dynamic team1;
  dynamic team2;
  dynamic venueInfo;
  String? seriesStartDt;
  String? seriesEndDt;
  dynamic isTimeAnnounced;
  dynamic stateTitle;
  dynamic isFantasyEnabled;

  factory MatchInfo.fromJson(Map<String, dynamic> json) => MatchInfo(
    matchId: json["matchId"],
    seriesId: json["seriesId"],
    seriesName: json["seriesName"],
    matchDesc: json["matchDesc"],
    matchFormat: json["matchFormat"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    state: json["state"],
    team1: json["team1"] == null ? null : Team.fromJson(json["team1"]),
    team2: json["team2"] == null ? null : Team.fromJson(json["team2"]),
    venueInfo: json["venueInfo"] == null ? null : VenueInfo.fromJson(json["venueInfo"]),
    seriesStartDt: json["seriesStartDt"],
    seriesEndDt: json["seriesEndDt"],
    isTimeAnnounced: json["isTimeAnnounced"],
    stateTitle: json["stateTitle"],
    isFantasyEnabled: json["isFantasyEnabled"],
  );

  Map<String, dynamic> toJson() => {
    "matchId": matchId,
    "seriesId": seriesId,
    "seriesName": seriesName,
    "matchDesc": matchDesc,
    "matchFormat": matchFormat,
    "startDate": startDate,
    "endDate": endDate,
    "state": state,
    "team1": team1?.toJson(),
    "team2": team2?.toJson(),
    "venueInfo": venueInfo?.toJson(),
    "seriesStartDt": seriesStartDt,
    "seriesEndDt": seriesEndDt,
    "isTimeAnnounced": isTimeAnnounced,
    "stateTitle": stateTitle,
    "isFantasyEnabled": isFantasyEnabled,
  };
}

class Team {
  Team({
    this.teamId,
    this.teamName,
    this.teamSName,
    this.imageId,
  });

  dynamic teamId;
  String? teamName;
  String? teamSName;
  dynamic imageId;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    teamId: json["teamId"],
    teamName: json["teamName"],
    teamSName: json["teamSName"],
    imageId: json["imageId"],
  );

  Map<String, dynamic> toJson() => {
    "teamId": teamId,
    "teamName": teamName,
    "teamSName": teamSName,
    "imageId": imageId,
  };
}

class VenueInfo {
  VenueInfo({
    this.id,
    this.ground,
    this.city,
    this.timezone,
    this.latitude,
    this.longitude,
  });

  dynamic id;
  String? ground;
  String? city;
  dynamic timezone;
  String? latitude;
  String? longitude;

  factory VenueInfo.fromJson(Map<String, dynamic> json) => VenueInfo(
    id: json["id"],
    ground: json["ground"],
    city: json["city"],
    timezone: json["timezone"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ground": ground,
    "city": city,
    "timezone": timezone,
    "latitude": latitude,
    "longitude": longitude,
  };
}

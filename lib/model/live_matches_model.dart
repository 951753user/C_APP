// To parse this JSON data, do
//
//     final liveMatchesModel = liveMatchesModelFromJson(jsonString);

import 'dart:convert';

LiveMatchesModel liveMatchesModelFromJson(String str) => LiveMatchesModel.fromJson(json.decode(str));

String liveMatchesModelToJson(LiveMatchesModel data) => json.encode(data.toJson());

class LiveMatchesModel {
  LiveMatchesModel({
    this.typeMatches,
    this.filters,
    this.responseLastUpdated,
  });

  List<TypeMatch>? typeMatches;
  Filters? filters;
  String? responseLastUpdated;

  factory LiveMatchesModel.fromJson(Map<String, dynamic> json) => LiveMatchesModel(
    typeMatches: json["typeMatches"] == null ? [] : List<TypeMatch>.from(json["typeMatches"]!.map((x) => TypeMatch.fromJson(x))),
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

  List<String>? matchType;

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    matchType: json["matchType"] == null ? [] : List<String>.from(json["matchType"]!.map((x) => x)),
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
  List<SeriesMatch>? seriesMatches;

  factory TypeMatch.fromJson(Map<String, dynamic> json) => TypeMatch(
    matchType: json["matchType"],
    seriesMatches: json["seriesMatches"] == null ? [] : List<SeriesMatch>.from(json["seriesMatches"]!.map((x) => SeriesMatch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {

    "matchType": matchType,
    "seriesMatches": seriesMatches == null ? [] : List<dynamic>.from(seriesMatches!.map((x) => x.toJson())),
  };
}

class SeriesMatch {
  SeriesMatch({
    this.seriesAdWrapper,
  });

  SeriesAdWrapper? seriesAdWrapper;

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

  int? seriesId;
  String? seriesName;
  List<Match>? matches;

  factory SeriesAdWrapper.fromJson(Map<String, dynamic> json) => SeriesAdWrapper(
    seriesId: json["seriesId"],
    seriesName: json["seriesName"],
    matches: json["matches"] == null ? [] : List<Match>.from(json["matches"]!.map((x) => Match.fromJson(x))),
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
    this.matchScore,
  });

  MatchInfo? matchInfo;
  MatchScore? matchScore;

  factory Match.fromJson(Map<String, dynamic> json) => Match(
    matchInfo: json["matchInfo"] == null ? null : MatchInfo.fromJson(json["matchInfo"]),
    matchScore: json["matchScore"] == null ? null : MatchScore.fromJson(json["matchScore"]),
  );

  Map<String, dynamic> toJson() => {
    "matchInfo": matchInfo?.toJson(),
    "matchScore": matchScore?.toJson(),
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
    this.status,
    this.team1,
    this.team2,
    this.venueInfo,
    this.currBatTeamId,
    this.seriesStartDt,
    this.seriesEndDt,
    this.isTimeAnnounced,
    this.stateTitle,
  });

  int? matchId;
  int? seriesId;
  String? seriesName;
  String? matchDesc;
  String? matchFormat;
  String? startDate;
  String? endDate;
  String? state;
  String? status;
  Team? team1;
  Team? team2;
  VenueInfo? venueInfo;
  int? currBatTeamId;
  String? seriesStartDt;
  String? seriesEndDt;
  bool? isTimeAnnounced;
  String? stateTitle;

  factory MatchInfo.fromJson(Map<String, dynamic> json) => MatchInfo(
    matchId: json["matchId"],
    seriesId: json["seriesId"],
    seriesName: json["seriesName"],
    matchDesc: json["matchDesc"],
    matchFormat: json["matchFormat"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    state: json["state"],
    status: json["status"],
    team1: json["team1"] == null ? null : Team.fromJson(json["team1"]),
    team2: json["team2"] == null ? null : Team.fromJson(json["team2"]),
    venueInfo: json["venueInfo"] == null ? null : VenueInfo.fromJson(json["venueInfo"]),
    currBatTeamId: json["currBatTeamId"],
    seriesStartDt: json["seriesStartDt"],
    seriesEndDt: json["seriesEndDt"],
    isTimeAnnounced: json["isTimeAnnounced"],
    stateTitle: json["stateTitle"],
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
    "status": status,
    "team1": team1?.toJson(),
    "team2": team2?.toJson(),
    "venueInfo": venueInfo?.toJson(),
    "currBatTeamId": currBatTeamId,
    "seriesStartDt": seriesStartDt,
    "seriesEndDt": seriesEndDt,
    "isTimeAnnounced": isTimeAnnounced,
    "stateTitle": stateTitle,
  };
}

class Team {
  Team({
    this.teamId,
    this.teamName,
    this.teamSName,
    this.imageId,
  });

  int? teamId;
  String? teamName;
  String? teamSName;
  int? imageId;

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

  int? id;
  String? ground;
  String? city;
  String? timezone;
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

class MatchScore {
  MatchScore({
    this.team1Score,
    this.team2Score,
  });

  TeamScore? team1Score;
  TeamScore? team2Score;

  factory MatchScore.fromJson(Map<String, dynamic> json) => MatchScore(
    team1Score: json["team1Score"] == null ? null : TeamScore.fromJson(json["team1Score"]),
    team2Score: json["team2Score"] == null ? null : TeamScore.fromJson(json["team2Score"]),
  );

  Map<String, dynamic> toJson() => {
    "team1Score": team1Score?.toJson(),
    "team2Score": team2Score?.toJson(),
  };
}

class TeamScore {
  TeamScore({
    this.inngs1,
  });

  Inngs1? inngs1;

  factory TeamScore.fromJson(Map<String, dynamic> json) => TeamScore(
    inngs1: json["inngs1"] == null ? null : Inngs1.fromJson(json["inngs1"]),
  );

  Map<String, dynamic> toJson() => {
    "inngs1": inngs1?.toJson(),
  };
}

class Inngs1 {
  Inngs1({
    this.inningsId,
    this.runs,
    this.wickets,
    this.overs,
  });

  int? inningsId;
  int? runs;
  int? wickets;
  double? overs;

  factory Inngs1.fromJson(Map<String, dynamic> json) => Inngs1(
    inningsId: json["inningsId"],
    runs: json["runs"],
    wickets: json["wickets"],
    overs: json["overs"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "inningsId": inningsId,
    "runs": runs,
    "wickets": wickets,
    "overs": overs,
  };
}

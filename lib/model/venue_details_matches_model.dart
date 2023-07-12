// To parse this JSON data, do
//
//     final venueDetailsMatchesModel = venueDetailsMatchesModelFromJson(jsonString);

import 'dart:convert';

VenueDetailsMatchesModel venueDetailsMatchesModelFromJson(String str) => VenueDetailsMatchesModel.fromJson(json.decode(str));

String venueDetailsMatchesModelToJson(VenueDetailsMatchesModel data) => json.encode(data.toJson());

class VenueDetailsMatchesModel {
  VenueDetailsMatchesModel({
    this.matchDetails,
  });

  List<MatchDetail>? matchDetails;

  factory VenueDetailsMatchesModel.fromJson(Map<String, dynamic> json) => VenueDetailsMatchesModel(
    matchDetails: json["matchDetails"] == null ? [] : List<MatchDetail>.from(json["matchDetails"]!.map((x) => MatchDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "matchDetails": matchDetails == null ? [] : List<dynamic>.from(matchDetails!.map((x) => x.toJson())),
  };
}

class MatchDetail {
  MatchDetail({
    this.matchDetailsMap,
  });

  MatchDetailsMap? matchDetailsMap;

  factory MatchDetail.fromJson(Map<String, dynamic> json) => MatchDetail(
    matchDetailsMap: json["matchDetailsMap"] == null ? null : MatchDetailsMap.fromJson(json["matchDetailsMap"]),
  );

  Map<String, dynamic> toJson() => {
    "matchDetailsMap": matchDetailsMap?.toJson(),
  };
}

class MatchDetailsMap {
  MatchDetailsMap({
    this.key,
    this.match,
    this.seriesId,
  });

  String? key;
  List<Match>? match;
  int? seriesId;

  factory MatchDetailsMap.fromJson(Map<String, dynamic> json) => MatchDetailsMap(
    key: json["key"],
    match: json["match"] == null ? [] : List<Match>.from(json["match"]!.map((x) => Match.fromJson(x))),
    seriesId: json["seriesId"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "match": match == null ? [] : List<dynamic>.from(match!.map((x) => x.toJson())),
    "seriesId": seriesId,
  };
}

class Match {
  Match({
    this.matchInfo,
  });

  MatchInfo? matchInfo;

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
  });

  int? matchId;
  int? seriesId;
  String? seriesName;
  String? matchDesc;
  String? matchFormat;
  String? startDate;
  String? endDate;
  String? state;
  Team? team1;
  Team? team2;
  VenueInfo? venueInfo;
  String? seriesStartDt;
  String? seriesEndDt;
  bool? isTimeAnnounced;

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
  });

  int? id;
  String? ground;
  String? city;
  String? timezone;

  factory VenueInfo.fromJson(Map<String, dynamic> json) => VenueInfo(
    id: json["id"],
    ground: json["ground"],
    city: json["city"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ground": ground,
    "city": city,
    "timezone": timezone,
  };
}

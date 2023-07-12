// To parse this JSON data, do
//
//     final matchDetailModel = matchDetailModelFromJson(jsonString);

import 'dart:convert';

MatchDetailModel matchDetailModelFromJson(String str) => MatchDetailModel.fromJson(json.decode(str));

String matchDetailModelToJson(MatchDetailModel data) => json.encode(data.toJson());

class MatchDetailModel {
  MatchDetailModel({
    this.matchInfo,
    this.venueInfo,
    this.broadcastInfo,
  });

  dynamic matchInfo;
  dynamic venueInfo;
  List<dynamic>? broadcastInfo;

  factory MatchDetailModel.fromJson(Map<String, dynamic> json) => MatchDetailModel(
    matchInfo: json["matchInfo"] == null ? null : MatchInfo.fromJson(json["matchInfo"]),
    venueInfo: json["venueInfo"] == null ? null : VenueInfo.fromJson(json["venueInfo"]),
    broadcastInfo: json["broadcastInfo"] == null ? [] : List<dynamic>.from(json["broadcastInfo"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "matchInfo": matchInfo.toJson(),
    "venueInfo": venueInfo.toJson(),
    "broadcastInfo": broadcastInfo == null ? [] : List<dynamic>.from(broadcastInfo!.map((x) => x)),
  };
}

class MatchInfo {
  MatchInfo({
    this.matchId,
    this.matchDescription,
    this.matchFormat,
    this.matchType,
    this.complete,
    this.domestic,
    this.matchStartTimestamp,
    this.matchCompleteTimestamp,
    this.dayNight,
    this.year,
    this.state,
    this.team1,
    this.team2,
    this.series,
    this.umpire1,
    this.umpire2,
    this.umpire3,
    this.referee,
    this.tossResults,
    this.result,
    this.venue,
    this.status,
    this.playersOfTheMatch,
    this.playersOfTheSeries,
    this.revisedTarget,
    this.matchTeamInfo,
    this.isMatchNotCovered,
    this.hysEnabled,
    this.livestreamEnabled,
    this.isFantasyEnabled,
    this.livestreamEnabledGeo,
    this.alertType,
  });

  int? matchId;
  String? matchDescription;
  String? matchFormat;
  String? matchType;
  dynamic complete;
  dynamic domestic;
  int? matchStartTimestamp;
  int? matchCompleteTimestamp;
  dynamic dayNight;
  int? year;
  String? state;
  dynamic team1;
  dynamic team2;
  dynamic series;
  dynamic umpire1;
  dynamic umpire2;
  dynamic umpire3;
  dynamic referee;
  dynamic tossResults;
  dynamic result;
  dynamic venue;
  String? status;
  List<dynamic>? playersOfTheMatch;
  List<dynamic>? playersOfTheSeries;
  dynamic revisedTarget;
  List<dynamic>? matchTeamInfo;
  dynamic isMatchNotCovered;
  int? hysEnabled;
  dynamic livestreamEnabled;
  dynamic isFantasyEnabled;
  List<dynamic>? livestreamEnabledGeo;
  String? alertType;

  factory MatchInfo.fromJson(Map<String, dynamic> json) => MatchInfo(
    matchId: json["matchId"],
    matchDescription: json["matchDescription"],
    matchFormat: json["matchFormat"],
    matchType: json["matchType"],
    complete: json["complete"],
    domestic: json["domestic"],
    matchStartTimestamp: json["matchStartTimestamp"],
    matchCompleteTimestamp: json["matchCompleteTimestamp"],
    dayNight: json["dayNight"],
    year: json["year"],
    state: json["state"],
    team1: json["team1"] == null ? null : Team.fromJson(json["team1"]),
    team2: json["team2"] == null ? null : Team.fromJson(json["team2"]),
    series: json["series"] == null ? null : Series.fromJson(json["series"]),
    umpire1: json["umpire1"] == null ? null : Referee.fromJson(json["umpire1"]),
    umpire2: json["umpire2"] == null ? null : Referee.fromJson(json["umpire2"]),
    umpire3: json["umpire3"] == null ? null : Referee.fromJson(json["umpire3"]),
    referee: json["referee"] == null ? null : Referee.fromJson(json["referee"]),
    tossResults: json["tossResults"] == null ? null : TossResults.fromJson(json["tossResults"]),
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    venue: json["venue"] == null ? null : Venue.fromJson(json["venue"]),
    status: json["status"],
    playersOfTheMatch: json["playersOfTheMatch"] == null ? [] : List<PlayersOfTheMatch>.from(json["playersOfTheMatch"]!.map((x) => PlayersOfTheMatch.fromJson(x))),
    playersOfTheSeries: json["playersOfTheSeries"] == null ? [] : List<dynamic>.from(json["playersOfTheSeries"]!.map((x) => x)),
    revisedTarget: json["revisedTarget"] == null ? null : RevisedTarget.fromJson(json["revisedTarget"]),
    matchTeamInfo: json["matchTeamInfo"] == null ? [] : List<MatchTeamInfo>.from(json["matchTeamInfo"]!.map((x) => MatchTeamInfo.fromJson(x))),
    isMatchNotCovered: json["isMatchNotCovered"],
    hysEnabled: json["HYSEnabled"],
    livestreamEnabled: json["livestreamEnabled"],
    isFantasyEnabled: json["isFantasyEnabled"],
    livestreamEnabledGeo: json["livestreamEnabledGeo"] == null ? [] : List<dynamic>.from(json["livestreamEnabledGeo"]!.map((x) => x)),
    alertType: json["alertType"],
  );

  Map<String, dynamic> toJson() => {
    "matchId": matchId,
    "matchDescription": matchDescription,
    "matchFormat": matchFormat,
    "matchType": matchType,
    "complete": complete,
    "domestic": domestic,
    "matchStartTimestamp": matchStartTimestamp,
    "matchCompleteTimestamp": matchCompleteTimestamp,
    "dayNight": dayNight,
    "year": year,
    "state": state,
    "team1": team1?.toJson(),
    "team2": team2?.toJson(),
    "series": series?.toJson(),
    "umpire1": umpire1?.toJson(),
    "umpire2": umpire2?.toJson(),
    "umpire3": umpire3?.toJson(),
    "referee": referee?.toJson(),
    "tossResults": tossResults?.toJson(),
    "result": result?.toJson(),
    "venue": venue?.toJson(),
    "status": status,
    "playersOfTheMatch": playersOfTheMatch == null ? [] : List<dynamic>.from(playersOfTheMatch!.map((x) => x.toJson())),
    "playersOfTheSeries": playersOfTheSeries == null ? [] : List<dynamic>.from(playersOfTheSeries!.map((x) => x)),
    "revisedTarget": revisedTarget?.toJson(),
    "matchTeamInfo": matchTeamInfo == null ? [] : List<dynamic>.from(matchTeamInfo!.map((x) => x.toJson())),
    "isMatchNotCovered": isMatchNotCovered,
    "HYSEnabled": hysEnabled,
    "livestreamEnabled": livestreamEnabled,
    "isFantasyEnabled": isFantasyEnabled,
    "livestreamEnabledGeo": livestreamEnabledGeo == null ? [] : List<dynamic>.from(livestreamEnabledGeo!.map((x) => x)),
    "alertType": alertType,
  };
}

class MatchTeamInfo {
  MatchTeamInfo({
    this.battingTeamId,
    this.battingTeamShortName,
    this.bowlingTeamId,
    this.bowlingTeamShortName,
  });

  int? battingTeamId;
  String? battingTeamShortName;
  int? bowlingTeamId;
  String? bowlingTeamShortName;

  factory MatchTeamInfo.fromJson(Map<String, dynamic> json) => MatchTeamInfo(
    battingTeamId: json["battingTeamId"],
    battingTeamShortName: json["battingTeamShortName"],
    bowlingTeamId: json["bowlingTeamId"],
    bowlingTeamShortName: json["bowlingTeamShortName"],
  );

  Map<String, dynamic> toJson() => {
    "battingTeamId": battingTeamId,
    "battingTeamShortName": battingTeamShortName,
    "bowlingTeamId": bowlingTeamId,
    "bowlingTeamShortName": bowlingTeamShortName,
  };
}

class PlayersOfTheMatch {
  PlayersOfTheMatch({
    this.id,
    this.name,
    this.fullName,
    this.nickName,
    this.captain,
    this.keeper,
    this.substitute,
    this.teamName,
    this.faceImageId,
  });

  int? id;
  String? name;
  String? fullName;
  String? nickName;
  dynamic captain;
  dynamic keeper;
  dynamic substitute;
  String? teamName;
  int? faceImageId;

  factory PlayersOfTheMatch.fromJson(Map<String, dynamic> json) => PlayersOfTheMatch(
    id: json["id"],
    name: json["name"],
    fullName: json["fullName"],
    nickName: json["nickName"],
    captain: json["captain"],
    keeper: json["keeper"],
    substitute: json["substitute"],
    teamName: json["teamName"],
    faceImageId: json["faceImageId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "fullName": fullName,
    "nickName": nickName,
    "captain": captain,
    "keeper": keeper,
    "substitute": substitute,
    "teamName": teamName,
    "faceImageId": faceImageId,
  };
}

class Referee {
  Referee({
    this.id,
    this.name,
    this.country,
  });

  int? id;
  String? name;
  String? country;

  factory Referee.fromJson(Map<String, dynamic> json) => Referee(
    id: json["id"],
    name: json["name"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country,
  };
}

class Result {
  Result({
    this.resultType,
    this.winningTeam,
    this.winningteamId,
    this.winningMargin,
    this.winByRuns,
    this.winByInnings,
  });

  String? resultType;
  String? winningTeam;
  int? winningteamId;
  int? winningMargin;
  dynamic winByRuns;
  dynamic winByInnings;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    resultType: json["resultType"],
    winningTeam: json["winningTeam"],
    winningteamId: json["winningteamId"],
    winningMargin: json["winningMargin"],
    winByRuns: json["winByRuns"],
    winByInnings: json["winByInnings"],
  );

  Map<String, dynamic> toJson() => {
    "resultType": resultType,
    "winningTeam": winningTeam,
    "winningteamId": winningteamId,
    "winningMargin": winningMargin,
    "winByRuns": winByRuns,
    "winByInnings": winByInnings,
  };
}

class RevisedTarget {
  RevisedTarget({
    this.reason,
  });

  String? reason;

  factory RevisedTarget.fromJson(Map<String, dynamic> json) => RevisedTarget(
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
  };
}

class Series {
  Series({
    this.id,
    this.name,
    this.seriesType,
    this.startDate,
    this.endDate,
    this.seriesFolder,
    this.odiSeriesResult,
    this.t20SeriesResult,
    this.testSeriesResult,
  });

  int? id;
  String? name;
  String? seriesType;
  int? startDate;
  int? endDate;
  String? seriesFolder;
  String? odiSeriesResult;
  String? t20SeriesResult;
  String? testSeriesResult;

  factory Series.fromJson(Map<String, dynamic> json) => Series(
    id: json["id"],
    name: json["name"],
    seriesType: json["seriesType"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    seriesFolder: json["seriesFolder"],
    odiSeriesResult: json["odiSeriesResult"],
    t20SeriesResult: json["t20SeriesResult"],
    testSeriesResult: json["testSeriesResult"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "seriesType": seriesType,
    "startDate": startDate,
    "endDate": endDate,
    "seriesFolder": seriesFolder,
    "odiSeriesResult": odiSeriesResult,
    "t20SeriesResult": t20SeriesResult,
    "testSeriesResult": testSeriesResult,
  };
}

class Team {
  Team({
    this.id,
    this.name,
    this.playerDetails,
    this.shortName,
  });

  int? id;
  String? name;
  List<dynamic>? playerDetails;
  String? shortName;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    name: json["name"],
    playerDetails: json["playerDetails"] == null ? [] : List<dynamic>.from(json["playerDetails"].map((x) => PlayerDetail.fromJson(x))),
    shortName: json["shortName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "playerDetails": playerDetails == null ? [] : List<dynamic>.from(playerDetails!.map((x) => x.toJson())),
    "shortName": shortName,
  };
}

class PlayerDetail {
  PlayerDetail({
    this.id,
    this.name,
    this.fullName,
    this.nickName,
    this.captain,
    this.role,
    this.keeper,
    this.substitute,
    this.teamId,
    this.battingStyle,
    this.bowlingStyle,
    this.faceImageId,
  });

  int? id;
  String? name;
  String? fullName;
  String? nickName;
  dynamic captain;
  dynamic role;
  dynamic keeper;
  dynamic substitute;
  int? teamId;
  dynamic battingStyle;
  String? bowlingStyle;
  int? faceImageId;

  factory PlayerDetail.fromJson(Map<String, dynamic> json) => PlayerDetail(
    id: json["id"],
    name: json["name"],
    fullName: json["fullName"],
    nickName: json["nickName"],
    captain: json["captain"],
    role: roleValues.map[json["role"]],
    keeper: json["keeper"],
    substitute: json["substitute"],
    teamId: json["teamId"],
    battingStyle: battingStyleValues.map[json["battingStyle"]],
    bowlingStyle: json["bowlingStyle"],
    faceImageId: json["faceImageId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "fullName": fullName,
    "nickName": nickName,
    "captain": captain,
    "role": roleValues.reverse[role],
    "keeper": keeper,
    "substitute": substitute,
    "teamId": teamId,
    "battingStyle": battingStyleValues.reverse[battingStyle],
    "bowlingStyle": bowlingStyle,
    "faceImageId": faceImageId,
  };
}

enum BattingStyle { RIGHT, LEFT }

final battingStyleValues = EnumValues({
  "LEFT": BattingStyle.LEFT,
  "RIGHT": BattingStyle.RIGHT
});

enum Role { WK_BATSMAN, BATTING_ALLROUNDER, BATSMAN, BOWLING_ALLROUNDER, BOWLER }

final roleValues = EnumValues({
  "Batsman": Role.BATSMAN,
  "Batting Allrounder": Role.BATTING_ALLROUNDER,
  "Bowler": Role.BOWLER,
  "Bowling Allrounder": Role.BOWLING_ALLROUNDER,
  "WK-Batsman": Role.WK_BATSMAN
});

class TossResults {
  TossResults({
    this.tossWinnerId,
    this.tossWinnerName,
    this.decision,
  });

  int? tossWinnerId;
  String? tossWinnerName;
  String? decision;

  factory TossResults.fromJson(Map<String, dynamic> json) => TossResults(
    tossWinnerId: json["tossWinnerId"],
    tossWinnerName: json["tossWinnerName"],
    decision: json["decision"],
  );

  Map<String, dynamic> toJson() => {
    "tossWinnerId": tossWinnerId,
    "tossWinnerName": tossWinnerName,
    "decision": decision,
  };
}

class Venue {
  Venue({
    this.id,
    this.name,
    this.city,
    this.country,
    this.timezone,
    this.latitude,
    this.longitude,
  });

  int? id;
  String? name;
  String? city;
  String? country;
  String? timezone;
  String? latitude;
  String? longitude;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
    id: json["id"],
    name: json["name"],
    city: json["city"],
    country: json["country"],
    timezone: json["timezone"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city": city,
    "country": country,
    "timezone": timezone,
    "latitude": latitude,
    "longitude": longitude,
  };
}

class VenueInfo {
  VenueInfo({
    this.established,
    this.capacity,
    this.knownAs,
    this.ends,
    this.city,
    this.country,
    this.timezone,
    this.homeTeam,
    this.floodlights,
    this.curator,
    this.profile,
    this.imageUrl,
    this.ground,
    this.groundLength,
    this.groundWidth,
    this.otherSports,
  });

  int? established;
  String? capacity;
  String? knownAs;
  String? ends;
  String? city;
  String? country;
  String? timezone;
  String? homeTeam;
  dynamic floodlights;
  dynamic curator;
  dynamic profile;
  String? imageUrl;
  String? ground;
  int? groundLength;
  int? groundWidth;
  dynamic otherSports;

  factory VenueInfo.fromJson(Map<String, dynamic> json) => VenueInfo(
    established: json["established"],
    capacity: json["capacity"],
    knownAs: json["knownAs"],
    ends: json["ends"],
    city: json["city"],
    country: json["country"],
    timezone: json["timezone"],
    homeTeam: json["homeTeam"],
    floodlights: json["floodlights"],
    curator: json["curator"],
    profile: json["profile"],
    imageUrl: json["imageUrl"],
    ground: json["ground"],
    groundLength: json["groundLength"],
    groundWidth: json["groundWidth"],
    otherSports: json["otherSports"],
  );

  Map<String, dynamic> toJson() => {
    "established": established,
    "capacity": capacity,
    "knownAs": knownAs,
    "ends": ends,
    "city": city,
    "country": country,
    "timezone": timezone,
    "homeTeam": homeTeam,
    "floodlights": floodlights,
    "curator": curator,
    "profile": profile,
    "imageUrl": imageUrl,
    "ground": ground,
    "groundLength": groundLength,
    "groundWidth": groundWidth,
    "otherSports": otherSports,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// To parse this JSON data, do
//
//     final commentaryTwoModel = commentaryTwoModelFromJson(jsonString);

import 'dart:convert';

CommentaryTwoModel commentaryTwoModelFromJson(String str) => CommentaryTwoModel.fromJson(json.decode(str));

String commentaryTwoModelToJson(CommentaryTwoModel data) => json.encode(data.toJson());

class CommentaryTwoModel {
  CommentaryTwoModel({
    this.commentaryList,
    this.matchHeader,
    this.commentarySnippetList,
    this.page,
    this.enableNoContent,
    this.matchVideos,
    this.responseLastUpdated,
  });

  List<CommentaryList>? commentaryList;
  MatchHeader? matchHeader;
  List<dynamic>? commentarySnippetList;
  String? page;
  bool? enableNoContent;
  List<dynamic>? matchVideos;
  int? responseLastUpdated;

  factory CommentaryTwoModel.fromJson(Map<String, dynamic> json) => CommentaryTwoModel(
    commentaryList: json["commentaryList"] == null ? [] : List<CommentaryList>.from(json["commentaryList"]!.map((x) => CommentaryList.fromJson(x))),
    matchHeader: json["matchHeader"] == null ? null : MatchHeader.fromJson(json["matchHeader"]),
    commentarySnippetList: json["commentarySnippetList"] == null ? [] : List<dynamic>.from(json["commentarySnippetList"]!.map((x) => x)),
    page: json["page"],
    enableNoContent: json["enableNoContent"],
    matchVideos: json["matchVideos"] == null ? [] : List<dynamic>.from(json["matchVideos"]!.map((x) => x)),
    responseLastUpdated: json["responseLastUpdated"],
  );

  Map<String, dynamic> toJson() => {
    "commentaryList": commentaryList == null ? [] : List<dynamic>.from(commentaryList!.map((x) => x.toJson())),
    "matchHeader": matchHeader?.toJson(),
    "commentarySnippetList": commentarySnippetList == null ? [] : List<dynamic>.from(commentarySnippetList!.map((x) => x)),
    "page": page,
    "enableNoContent": enableNoContent,
    "matchVideos": matchVideos == null ? [] : List<dynamic>.from(matchVideos!.map((x) => x)),
    "responseLastUpdated": responseLastUpdated,
  };
}

class CommentaryList {
  CommentaryList({
    this.commText,
    this.timestamp,
    this.ballNbr,
    this.event,
    this.batTeamName,
    this.commentaryFormats,
  });

  String? commText;
  int? timestamp;
  int? ballNbr;
  String? event;
  String? batTeamName;
  CommentaryFormats? commentaryFormats;

  factory CommentaryList.fromJson(Map<String, dynamic> json) => CommentaryList(
    commText: json["commText"],
    timestamp: json["timestamp"],
    ballNbr: json["ballNbr"],
    event: json["event"],
    batTeamName: json["batTeamName"],
    commentaryFormats: json["commentaryFormats"] == null ? null : CommentaryFormats.fromJson(json["commentaryFormats"]),
  );

  Map<String, dynamic> toJson() => {
    "commText": commText,
    "timestamp": timestamp,
    "ballNbr": ballNbr,
    "event": event,
    "batTeamName": batTeamName,
    "commentaryFormats": commentaryFormats?.toJson(),
  };
}

class CommentaryFormats {
  CommentaryFormats({
    this.bold,
  });

  Bold? bold;

  factory CommentaryFormats.fromJson(Map<String, dynamic> json) => CommentaryFormats(
    bold: json["bold"] == null ? null : Bold.fromJson(json["bold"]),
  );

  Map<String, dynamic> toJson() => {
    "bold": bold?.toJson(),
  };
}

class Bold {
  Bold({
    this.formatId,
    this.formatValue,
  });

  List<String>? formatId;
  List<String>? formatValue;

  factory Bold.fromJson(Map<String, dynamic> json) => Bold(
    formatId: json["formatId"] == null ? [] : List<String>.from(json["formatId"]!.map((x) => x)),
    formatValue: json["formatValue"] == null ? [] : List<String>.from(json["formatValue"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "formatId": formatId == null ? [] : List<dynamic>.from(formatId!.map((x) => x)),
    "formatValue": formatValue == null ? [] : List<dynamic>.from(formatValue!.map((x) => x)),
  };
}

class MatchHeader {
  MatchHeader({
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
    this.status,
    this.tossResults,
    this.result,
    this.revisedTarget,
    this.playersOfTheMatch,
    this.playersOfTheSeries,
    this.isMatchNotCovered,
    this.team1,
    this.team2,
    this.seriesDesc,
    this.seriesId,
    this.seriesName,
    this.alertType,
    this.livestreamEnabled,
  });

  int? matchId;
  String? matchDescription;
  String? matchFormat;
  String? matchType;
  bool? complete;
  bool? domestic;
  int? matchStartTimestamp;
  int? matchCompleteTimestamp;
  bool? dayNight;
  int? year;
  String? state;
  String? status;
  TossResults? tossResults;
  Result? result;
  RevisedTarget? revisedTarget;
  List<dynamic>? playersOfTheMatch;
  List<dynamic>? playersOfTheSeries;
  bool? isMatchNotCovered;
  Team? team1;
  Team? team2;
  String? seriesDesc;
  int? seriesId;
  String? seriesName;
  String? alertType;
  bool? livestreamEnabled;

  factory MatchHeader.fromJson(Map<String, dynamic> json) => MatchHeader(
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
    status: json["status"],
    tossResults: json["tossResults"] == null ? null : TossResults.fromJson(json["tossResults"]),
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    revisedTarget: json["revisedTarget"] == null ? null : RevisedTarget.fromJson(json["revisedTarget"]),
    playersOfTheMatch: json["playersOfTheMatch"] == null ? [] : List<dynamic>.from(json["playersOfTheMatch"]!.map((x) => x)),
    playersOfTheSeries: json["playersOfTheSeries"] == null ? [] : List<dynamic>.from(json["playersOfTheSeries"]!.map((x) => x)),
    isMatchNotCovered: json["isMatchNotCovered"],
    team1: json["team1"] == null ? null : Team.fromJson(json["team1"]),
    team2: json["team2"] == null ? null : Team.fromJson(json["team2"]),
    seriesDesc: json["seriesDesc"],
    seriesId: json["seriesId"],
    seriesName: json["seriesName"],
    alertType: json["alertType"],
    livestreamEnabled: json["livestreamEnabled"],
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
    "status": status,
    "tossResults": tossResults?.toJson(),
    "result": result?.toJson(),
    "revisedTarget": revisedTarget?.toJson(),
    "playersOfTheMatch": playersOfTheMatch == null ? [] : List<dynamic>.from(playersOfTheMatch!.map((x) => x)),
    "playersOfTheSeries": playersOfTheSeries == null ? [] : List<dynamic>.from(playersOfTheSeries!.map((x) => x)),
    "isMatchNotCovered": isMatchNotCovered,
    "team1": team1?.toJson(),
    "team2": team2?.toJson(),
    "seriesDesc": seriesDesc,
    "seriesId": seriesId,
    "seriesName": seriesName,
    "alertType": alertType,
    "livestreamEnabled": livestreamEnabled,
  };
}

class Result {
  Result({
    this.winningTeam,
    this.winByRuns,
    this.winByInnings,
  });

  String? winningTeam;
  bool? winByRuns;
  bool? winByInnings;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    winningTeam: json["winningTeam"],
    winByRuns: json["winByRuns"],
    winByInnings: json["winByInnings"],
  );

  Map<String, dynamic> toJson() => {
    "winningTeam": winningTeam,
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
    playerDetails: json["playerDetails"] == null ? [] : List<dynamic>.from(json["playerDetails"]!.map((x) => x)),
    shortName: json["shortName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "playerDetails": playerDetails == null ? [] : List<dynamic>.from(playerDetails!.map((x) => x)),
    "shortName": shortName,
  };
}

class TossResults {
  TossResults({
    this.tossWinnerName,
    this.decision,
  });

  String? tossWinnerName;
  String? decision;

  factory TossResults.fromJson(Map<String, dynamic> json) => TossResults(
    tossWinnerName: json["tossWinnerName"],
    decision: json["decision"],
  );

  Map<String, dynamic> toJson() => {
    "tossWinnerName": tossWinnerName,
    "decision": decision,
  };
}

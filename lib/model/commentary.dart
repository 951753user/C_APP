// To parse this JSON data, do
//
//     final commentaryScrollingModel = commentaryScrollingModelFromJson(jsonString);

import 'dart:convert';

CommentaryScrollingModel commentaryScrollingModelFromJson(String str) => CommentaryScrollingModel.fromJson(json.decode(str));

String commentaryScrollingModelToJson(CommentaryScrollingModel data) => json.encode(data.toJson());

class CommentaryScrollingModel {
  CommentaryScrollingModel({
    this.commentaryList,
    this.matchHeader,
    this.commentarySnippetList,
    this.page,
    this.enableNoContent,
    this.matchVideos,
  });

  List<CommentaryList>? commentaryList;
  MatchHeader? matchHeader;
  List<dynamic>? commentarySnippetList;
  String? page;
  bool? enableNoContent;
  List<dynamic>? matchVideos;

  factory CommentaryScrollingModel.fromJson(Map<String, dynamic> json) => CommentaryScrollingModel(
    commentaryList: json["commentaryList"] == null ? [] : List<CommentaryList>.from(json["commentaryList"]!.map((x) => CommentaryList.fromJson(x))),
    matchHeader: json["matchHeader"] == null ? null : MatchHeader.fromJson(json["matchHeader"]),
    commentarySnippetList: json["commentarySnippetList"] == null ? [] : List<dynamic>.from(json["commentarySnippetList"]!.map((x) => x)),
    page: json["page"],
    enableNoContent: json["enableNoContent"],
    matchVideos: json["matchVideos"] == null ? [] : List<dynamic>.from(json["matchVideos"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "commentaryList": commentaryList == null ? [] : List<dynamic>.from(commentaryList!.map((x) => x.toJson())),
    "matchHeader": matchHeader?.toJson(),
    "commentarySnippetList": commentarySnippetList == null ? [] : List<dynamic>.from(commentarySnippetList!.map((x) => x)),
    "page": page,
    "enableNoContent": enableNoContent,
    "matchVideos": matchVideos == null ? [] : List<dynamic>.from(matchVideos!.map((x) => x)),
  };
}

class CommentaryList {
  CommentaryList({
    this.commText,
    this.timestamp,
    this.ballNbr,
    this.overNumber,
    this.inningsId,
    this.event,
    this.batTeamName,
    this.commentaryFormats,
    this.overSeparator,
  });

  String? commText;
  dynamic timestamp;
  dynamic ballNbr;
  double? overNumber;
  dynamic inningsId;
  String? event;
  String? batTeamName;
  CommentaryFormats? commentaryFormats;
  OverSeparator? overSeparator;

  factory CommentaryList.fromJson(Map<String, dynamic> json) => CommentaryList(
    commText: json["commText"],
    timestamp: json["timestamp"],
    ballNbr: json["ballNbr"],
    overNumber: json["overNumber"]?.toDouble(),
    inningsId: json["inningsId"],
    event: json["event"],
    batTeamName: json["batTeamName"],
    commentaryFormats: json["commentaryFormats"] == null ? null : CommentaryFormats.fromJson(json["commentaryFormats"]),
    overSeparator: json["overSeparator"] == null ? null : OverSeparator.fromJson(json["overSeparator"]),
  );

  Map<String, dynamic> toJson() => {
    "commText": commText,
    "timestamp": timestamp,
    "ballNbr": ballNbr,
    "overNumber": overNumber,
    "inningsId": inningsId,
    "event": event,
    "batTeamName": batTeamName,
    "commentaryFormats": commentaryFormats?.toJson(),
    "overSeparator": overSeparator?.toJson(),
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

class OverSeparator {
  OverSeparator({
    this.score,
    this.wickets,
    this.inningsId,
    this.oSummary,
    this.runs,
    this.batStrikerIds,
    this.batStrikerNames,
    this.batStrikerRuns,
    this.batStrikerBalls,
    this.batNonStrikerIds,
    this.batNonStrikerNames,
    this.batNonStrikerRuns,
    this.batNonStrikerBalls,
    this.bowlIds,
    this.bowlNames,
    this.bowlOvers,
    this.bowlMaidens,
    this.bowlRuns,
    this.bowlWickets,
    this.timestamp,
    this.overNum,
    this.batTeamName,
    this.event,
  });

  dynamic score;
  dynamic wickets;
  dynamic inningsId;
  String? oSummary;
  dynamic runs;
  List<int>? batStrikerIds;
  List<String>? batStrikerNames;
  dynamic batStrikerRuns;
  dynamic batStrikerBalls;
  List<int>? batNonStrikerIds;
  List<String>? batNonStrikerNames;
  dynamic batNonStrikerRuns;
  dynamic batNonStrikerBalls;
  List<int>? bowlIds;
  List<String>? bowlNames;
  dynamic bowlOvers;
  dynamic bowlMaidens;
  dynamic bowlRuns;
  dynamic bowlWickets;
  dynamic timestamp;
  double? overNum;
  String? batTeamName;
  String? event;

  factory OverSeparator.fromJson(Map<String, dynamic> json) => OverSeparator(
    score: json["score"],
    wickets: json["wickets"],
    inningsId: json["inningsId"],
    oSummary: json["o_summary"],
    runs: json["runs"],
    batStrikerIds: json["batStrikerIds"] == null ? [] : List<int>.from(json["batStrikerIds"]!.map((x) => x)),
    batStrikerNames: json["batStrikerNames"] == null ? [] : List<String>.from(json["batStrikerNames"]!.map((x) => x)),
    batStrikerRuns: json["batStrikerRuns"],
    batStrikerBalls: json["batStrikerBalls"],
    batNonStrikerIds: json["batNonStrikerIds"] == null ? [] : List<int>.from(json["batNonStrikerIds"]!.map((x) => x)),
    batNonStrikerNames: json["batNonStrikerNames"] == null ? [] : List<String>.from(json["batNonStrikerNames"]!.map((x) => x)),
    batNonStrikerRuns: json["batNonStrikerRuns"],
    batNonStrikerBalls: json["batNonStrikerBalls"],
    bowlIds: json["bowlIds"] == null ? [] : List<int>.from(json["bowlIds"]!.map((x) => x)),
    bowlNames: json["bowlNames"] == null ? [] : List<String>.from(json["bowlNames"]!.map((x) => x)),
    bowlOvers: json["bowlOvers"],
    bowlMaidens: json["bowlMaidens"],
    bowlRuns: json["bowlRuns"],
    bowlWickets: json["bowlWickets"],
    timestamp: json["timestamp"],
    overNum: json["overNum"]?.toDouble(),
    batTeamName: json["batTeamName"],
    event: json["event"],
  );

  Map<String, dynamic> toJson() => {
    "score": score,
    "wickets": wickets,
    "inningsId": inningsId,
    "o_summary": oSummary,
    "runs": runs,
    "batStrikerIds": batStrikerIds == null ? [] : List<dynamic>.from(batStrikerIds!.map((x) => x)),
    "batStrikerNames": batStrikerNames == null ? [] : List<dynamic>.from(batStrikerNames!.map((x) => x)),
    "batStrikerRuns": batStrikerRuns,
    "batStrikerBalls": batStrikerBalls,
    "batNonStrikerIds": batNonStrikerIds == null ? [] : List<dynamic>.from(batNonStrikerIds!.map((x) => x)),
    "batNonStrikerNames": batNonStrikerNames == null ? [] : List<dynamic>.from(batNonStrikerNames!.map((x) => x)),
    "batNonStrikerRuns": batNonStrikerRuns,
    "batNonStrikerBalls": batNonStrikerBalls,
    "bowlIds": bowlIds == null ? [] : List<dynamic>.from(bowlIds!.map((x) => x)),
    "bowlNames": bowlNames == null ? [] : List<dynamic>.from(bowlNames!.map((x) => x)),
    "bowlOvers": bowlOvers,
    "bowlMaidens": bowlMaidens,
    "bowlRuns": bowlRuns,
    "bowlWickets": bowlWickets,
    "timestamp": timestamp,
    "overNum": overNum,
    "batTeamName": batTeamName,
    "event": event,
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
    this.matchTeamInfo,
    this.isMatchNotCovered,
    this.team1,
    this.team2,
    this.seriesDesc,
    this.seriesId,
    this.seriesName,
    this.alertType,
    this.livestreamEnabled,
  });

  dynamic matchId;
  String? matchDescription;
  String? matchFormat;
  String? matchType;
  bool? complete;
  bool? domestic;
  dynamic matchStartTimestamp;
  dynamic matchCompleteTimestamp;
  bool? dayNight;
  dynamic year;
  String? state;
  String? status;
  TossResults? tossResults;
  Result? result;
  RevisedTarget? revisedTarget;
  List<PlayersOfTheMatch>? playersOfTheMatch;
  List<dynamic>? playersOfTheSeries;
  List<MatchTeamInfo>? matchTeamInfo;
  bool? isMatchNotCovered;
  Team? team1;
  Team? team2;
  String? seriesDesc;
  dynamic seriesId;
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
    playersOfTheMatch: json["playersOfTheMatch"] == null ? [] : List<PlayersOfTheMatch>.from(json["playersOfTheMatch"]!.map((x) => PlayersOfTheMatch.fromJson(x))),
    playersOfTheSeries: json["playersOfTheSeries"] == null ? [] : List<dynamic>.from(json["playersOfTheSeries"]!.map((x) => x)),
    matchTeamInfo: json["matchTeamInfo"] == null ? [] : List<MatchTeamInfo>.from(json["matchTeamInfo"]!.map((x) => MatchTeamInfo.fromJson(x))),
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
    "playersOfTheMatch": playersOfTheMatch == null ? [] : List<dynamic>.from(playersOfTheMatch!.map((x) => x.toJson())),
    "playersOfTheSeries": playersOfTheSeries == null ? [] : List<dynamic>.from(playersOfTheSeries!.map((x) => x)),
    "matchTeamInfo": matchTeamInfo == null ? [] : List<dynamic>.from(matchTeamInfo!.map((x) => x.toJson())),
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

class MatchTeamInfo {
  MatchTeamInfo({
    this.battingTeamId,
    this.battingTeamShortName,
    this.bowlingTeamId,
    this.bowlingTeamShortName,
  });

  dynamic battingTeamId;
  String? battingTeamShortName;
  dynamic bowlingTeamId;
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

  dynamic id;
  String? name;
  String? fullName;
  String? nickName;
  bool? captain;
  bool? keeper;
  bool? substitute;
  String? teamName;
  dynamic faceImageId;

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
  dynamic winningteamId;
  dynamic winningMargin;
  bool? winByRuns;
  bool? winByInnings;

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

class Team {
  Team({
    this.id,
    this.name,
    this.playerDetails,
    this.shortName,
  });

  dynamic id;
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
    this.tossWinnerId,
    this.tossWinnerName,
    this.decision,
  });

  dynamic tossWinnerId;
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

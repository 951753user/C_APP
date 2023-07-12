// To parse this JSON data, do
//
//     final commentaryModel = commentaryModelFromJson(jsonString);

import 'dart:convert';

CommentaryModel commentaryModelFromJson(String str) => CommentaryModel.fromJson(json.decode(str));

String commentaryModelToJson(CommentaryModel data) => json.encode(data.toJson());

class CommentaryModel {
  CommentaryModel({
    this.commentaryList,
    this.matchHeader,
    this.miniscore,
    this.commentarySnippetList,
    this.page,
    this.enableNoContent,
    this.matchVideos,
    this.responseLastUpdated,
  });

  List<CommentaryList>? commentaryList;
  MatchHeader? matchHeader;
  Miniscore? miniscore;
  List<dynamic>? commentarySnippetList;
  String? page;
  bool? enableNoContent;
  List<dynamic>? matchVideos;
  dynamic responseLastUpdated;

  factory CommentaryModel.fromJson(Map<String, dynamic> json) => CommentaryModel(
    commentaryList: json["commentaryList"] == null ? [] : List<CommentaryList>.from(json["commentaryList"]!.map((x) => CommentaryList.fromJson(x))),
    matchHeader: json["matchHeader"] == null ? null : MatchHeader.fromJson(json["matchHeader"]),
    miniscore: json["miniscore"] == null ? null : Miniscore.fromJson(json["miniscore"]),
    commentarySnippetList: json["commentarySnippetList"] == null ? [] : List<dynamic>.from(json["commentarySnippetList"]!.map((x) => x)),
    page: json["page"],
    enableNoContent: json["enableNoContent"],
    matchVideos: json["matchVideos"] == null ? [] : List<dynamic>.from(json["matchVideos"]!.map((x) => x)),
    responseLastUpdated: json["responseLastUpdated"],
  );

  Map<String, dynamic> toJson() => {
    "commentaryList": commentaryList == null ? [] : List<dynamic>.from(commentaryList!.map((x) => x.toJson())),
    "matchHeader": matchHeader?.toJson(),
    "miniscore": miniscore?.toJson(),
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
    this.inningsId,
    this.event,
    this.batTeamName,
    this.commentaryFormats,
    this.overNumber,
    this.overSeparator,
  });

  String? commText;
  dynamic timestamp;
  dynamic ballNbr;
  dynamic inningsId;
  String? event;
  String? batTeamName;
  CommentaryFormats? commentaryFormats;
  double? overNumber;
  OverSeparator? overSeparator;

  factory CommentaryList.fromJson(Map<String, dynamic> json) => CommentaryList(
    commText: json["commText"],
    timestamp: json["timestamp"],
    ballNbr: json["ballNbr"],
    inningsId: json["inningsId"],
    event: json["event"],
    batTeamName: json["batTeamName"],
    commentaryFormats: json["commentaryFormats"] == null ? null : CommentaryFormats.fromJson(json["commentaryFormats"]),
    overNumber: json["overNumber"]?.toDouble(),
    overSeparator: json["overSeparator"] == null ? null : OverSeparator.fromJson(json["overSeparator"]),
  );

  Map<String, dynamic> toJson() => {
    "commText": commText,
    "timestamp": timestamp,
    "ballNbr": ballNbr,
    "inningsId": inningsId,
    "event": event,
    "batTeamName": batTeamName,
    "commentaryFormats": commentaryFormats?.toJson(),
    "overNumber": overNumber,
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
  double? bowlOvers;
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
    bowlOvers: json["bowlOvers"]?.toDouble(),
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
  List<PlayersOfTheMatch>? playersOfTheSeries;
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
    playersOfTheSeries: json["playersOfTheSeries"] == null ? [] : List<PlayersOfTheMatch>.from(json["playersOfTheSeries"]!.map((x) => PlayersOfTheMatch.fromJson(x))),
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

class Miniscore {
  Miniscore({
    this.inningsId,
    this.batsmanStriker,
    this.batsmanNonStriker,
    this.batTeam,
    this.bowlerStriker,
    this.bowlerNonStriker,
    this.overs,
    this.recentOvsStats,
    this.target,
    this.partnerShip,
    this.currentRunRate,
    this.requiredRunRate,
    this.lastWicket,
    this.matchScoreDetails,
    this.latestPerformance,
    this.ppData,
    this.matchUdrs,
    this.overSummaryList,
    this.status,
    this.lastWicketScore,
    this.remRunsToWin,
    this.responseLastUpdated,
    this.event,
  });

  dynamic inningsId;
  BatsmanNStriker? batsmanStriker;
  BatsmanNStriker? batsmanNonStriker;
  BatTeam? batTeam;
  BowlerStriker? bowlerStriker;
  BowlerStriker? bowlerNonStriker;
  double? overs;
  String? recentOvsStats;
  dynamic target;
  PartnerShip? partnerShip;
  double? currentRunRate;
  dynamic requiredRunRate;
  String? lastWicket;
  MatchScoreDetails? matchScoreDetails;
  List<LatestPerformance>? latestPerformance;
  PpData? ppData;
  MatchUdrs? matchUdrs;
  List<dynamic>? overSummaryList;
  String? status;
  dynamic lastWicketScore;
  dynamic remRunsToWin;
  dynamic responseLastUpdated;
  String? event;

  factory Miniscore.fromJson(Map<String, dynamic> json) => Miniscore(
    inningsId: json["inningsId"],
    batsmanStriker: json["batsmanStriker"] == null ? null : BatsmanNStriker.fromJson(json["batsmanStriker"]),
    batsmanNonStriker: json["batsmanNonStriker"] == null ? null : BatsmanNStriker.fromJson(json["batsmanNonStriker"]),
    batTeam: json["batTeam"] == null ? null : BatTeam.fromJson(json["batTeam"]),
    bowlerStriker: json["bowlerStriker"] == null ? null : BowlerStriker.fromJson(json["bowlerStriker"]),
    bowlerNonStriker: json["bowlerNonStriker"] == null ? null : BowlerStriker.fromJson(json["bowlerNonStriker"]),
    overs: json["overs"]?.toDouble(),
    recentOvsStats: json["recentOvsStats"],
    target: json["target"],
    partnerShip: json["partnerShip"] == null ? null : PartnerShip.fromJson(json["partnerShip"]),
    currentRunRate: json["currentRunRate"]?.toDouble(),
    requiredRunRate: json["requiredRunRate"],
    lastWicket: json["lastWicket"],
    matchScoreDetails: json["matchScoreDetails"] == null ? null : MatchScoreDetails.fromJson(json["matchScoreDetails"]),
    latestPerformance: json["latestPerformance"] == null ? [] : List<LatestPerformance>.from(json["latestPerformance"]!.map((x) => LatestPerformance.fromJson(x))),
    ppData: json["ppData"] == null ? null : PpData.fromJson(json["ppData"]),
    matchUdrs: json["matchUdrs"] == null ? null : MatchUdrs.fromJson(json["matchUdrs"]),
    overSummaryList: json["overSummaryList"] == null ? [] : List<dynamic>.from(json["overSummaryList"]!.map((x) => x)),
    status: json["status"],
    lastWicketScore: json["lastWicketScore"],
    remRunsToWin: json["remRunsToWin"],
    responseLastUpdated: json["responseLastUpdated"],
    event: json["event"],
  );

  Map<String, dynamic> toJson() => {
    "inningsId": inningsId,
    "batsmanStriker": batsmanStriker?.toJson(),
    "batsmanNonStriker": batsmanNonStriker?.toJson(),
    "batTeam": batTeam?.toJson(),
    "bowlerStriker": bowlerStriker?.toJson(),
    "bowlerNonStriker": bowlerNonStriker?.toJson(),
    "overs": overs,
    "recentOvsStats": recentOvsStats,
    "target": target,
    "partnerShip": partnerShip?.toJson(),
    "currentRunRate": currentRunRate,
    "requiredRunRate": requiredRunRate,
    "lastWicket": lastWicket,
    "matchScoreDetails": matchScoreDetails?.toJson(),
    "latestPerformance": latestPerformance == null ? [] : List<dynamic>.from(latestPerformance!.map((x) => x.toJson())),
    "ppData": ppData?.toJson(),
    "matchUdrs": matchUdrs?.toJson(),
    "overSummaryList": overSummaryList == null ? [] : List<dynamic>.from(overSummaryList!.map((x) => x)),
    "status": status,
    "lastWicketScore": lastWicketScore,
    "remRunsToWin": remRunsToWin,
    "responseLastUpdated": responseLastUpdated,
    "event": event,
  };
}

class BatTeam {
  BatTeam({
    this.teamId,
    this.teamScore,
    this.teamWkts,
  });

  dynamic teamId;
  dynamic teamScore;
  dynamic teamWkts;

  factory BatTeam.fromJson(Map<String, dynamic> json) => BatTeam(
    teamId: json["teamId"],
    teamScore: json["teamScore"],
    teamWkts: json["teamWkts"],
  );

  Map<String, dynamic> toJson() => {
    "teamId": teamId,
    "teamScore": teamScore,
    "teamWkts": teamWkts,
  };
}

class BatsmanNStriker {
  BatsmanNStriker({
    this.batBalls,
    this.batDots,
    this.batFours,
    this.batId,
    this.batName,
    this.batMins,
    this.batRuns,
    this.batSixes,
    this.batStrikeRate,
  });

  dynamic batBalls;
  dynamic batDots;
  dynamic batFours;
  dynamic batId;
  String? batName;
  dynamic batMins;
  dynamic batRuns;
  dynamic batSixes;
  double? batStrikeRate;

  factory BatsmanNStriker.fromJson(Map<String, dynamic> json) => BatsmanNStriker(
    batBalls: json["batBalls"],
    batDots: json["batDots"],
    batFours: json["batFours"],
    batId: json["batId"],
    batName: json["batName"],
    batMins: json["batMins"],
    batRuns: json["batRuns"],
    batSixes: json["batSixes"],
    batStrikeRate: json["batStrikeRate"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "batBalls": batBalls,
    "batDots": batDots,
    "batFours": batFours,
    "batId": batId,
    "batName": batName,
    "batMins": batMins,
    "batRuns": batRuns,
    "batSixes": batSixes,
    "batStrikeRate": batStrikeRate,
  };
}

class BowlerStriker {
  BowlerStriker({
    this.bowlId,
    this.bowlName,
    this.bowlMaidens,
    this.bowlNoballs,
    this.bowlOvs,
    this.bowlRuns,
    this.bowlWides,
    this.bowlWkts,
    this.bowlEcon,
  });

  dynamic bowlId;
  String? bowlName;
  dynamic bowlMaidens;
  dynamic bowlNoballs;
  double? bowlOvs;
  dynamic bowlRuns;
  dynamic bowlWides;
  dynamic bowlWkts;
  double? bowlEcon;

  factory BowlerStriker.fromJson(Map<String, dynamic> json) => BowlerStriker(
    bowlId: json["bowlId"],
    bowlName: json["bowlName"],
    bowlMaidens: json["bowlMaidens"],
    bowlNoballs: json["bowlNoballs"],
    bowlOvs: json["bowlOvs"]?.toDouble(),
    bowlRuns: json["bowlRuns"],
    bowlWides: json["bowlWides"],
    bowlWkts: json["bowlWkts"],
    bowlEcon: json["bowlEcon"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "bowlId": bowlId,
    "bowlName": bowlName,
    "bowlMaidens": bowlMaidens,
    "bowlNoballs": bowlNoballs,
    "bowlOvs": bowlOvs,
    "bowlRuns": bowlRuns,
    "bowlWides": bowlWides,
    "bowlWkts": bowlWkts,
    "bowlEcon": bowlEcon,
  };
}

class LatestPerformance {
  LatestPerformance({
    this.runs,
    this.wkts,
    this.label,
  });

  dynamic runs;
  dynamic wkts;
  String? label;

  factory LatestPerformance.fromJson(Map<String, dynamic> json) => LatestPerformance(
    runs: json["runs"],
    wkts: json["wkts"],
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "runs": runs,
    "wkts": wkts,
    "label": label,
  };
}

class MatchScoreDetails {
  MatchScoreDetails({
    this.matchId,
    this.inningsScoreList,
    this.tossResults,
    this.matchTeamInfo,
    this.isMatchNotCovered,
    this.matchFormat,
    this.state,
    this.customStatus,
    this.highlightedTeamId,
  });

  dynamic matchId;
  List<InningsScoreList>? inningsScoreList;
  TossResults? tossResults;
  List<MatchTeamInfo>? matchTeamInfo;
  bool? isMatchNotCovered;
  String? matchFormat;
  String? state;
  String? customStatus;
  dynamic highlightedTeamId;

  factory MatchScoreDetails.fromJson(Map<String, dynamic> json) => MatchScoreDetails(
    matchId: json["matchId"],
    inningsScoreList: json["inningsScoreList"] == null ? [] : List<InningsScoreList>.from(json["inningsScoreList"]!.map((x) => InningsScoreList.fromJson(x))),
    tossResults: json["tossResults"] == null ? null : TossResults.fromJson(json["tossResults"]),
    matchTeamInfo: json["matchTeamInfo"] == null ? [] : List<MatchTeamInfo>.from(json["matchTeamInfo"]!.map((x) => MatchTeamInfo.fromJson(x))),
    isMatchNotCovered: json["isMatchNotCovered"],
    matchFormat: json["matchFormat"],
    state: json["state"],
    customStatus: json["customStatus"],
    highlightedTeamId: json["highlightedTeamId"],
  );

  Map<String, dynamic> toJson() => {
    "matchId": matchId,
    "inningsScoreList": inningsScoreList == null ? [] : List<dynamic>.from(inningsScoreList!.map((x) => x.toJson())),
    "tossResults": tossResults?.toJson(),
    "matchTeamInfo": matchTeamInfo == null ? [] : List<dynamic>.from(matchTeamInfo!.map((x) => x.toJson())),
    "isMatchNotCovered": isMatchNotCovered,
    "matchFormat": matchFormat,
    "state": state,
    "customStatus": customStatus,
    "highlightedTeamId": highlightedTeamId,
  };
}

class InningsScoreList {
  InningsScoreList({
    this.inningsId,
    this.batTeamId,
    this.batTeamName,
    this.score,
    this.wickets,
    this.overs,
    this.isDeclared,
    this.isFollowOn,
    this.ballNbr,
  });

  dynamic inningsId;
  dynamic batTeamId;
  String? batTeamName;
  dynamic score;
  dynamic wickets;
  double? overs;
  bool? isDeclared;
  bool? isFollowOn;
  dynamic ballNbr;

  factory InningsScoreList.fromJson(Map<String, dynamic> json) => InningsScoreList(
    inningsId: json["inningsId"],
    batTeamId: json["batTeamId"],
    batTeamName: json["batTeamName"],
    score: json["score"],
    wickets: json["wickets"],
    overs: json["overs"]?.toDouble(),
    isDeclared: json["isDeclared"],
    isFollowOn: json["isFollowOn"],
    ballNbr: json["ballNbr"],
  );

  Map<String, dynamic> toJson() => {
    "inningsId": inningsId,
    "batTeamId": batTeamId,
    "batTeamName": batTeamName,
    "score": score,
    "wickets": wickets,
    "overs": overs,
    "isDeclared": isDeclared,
    "isFollowOn": isFollowOn,
    "ballNbr": ballNbr,
  };
}

class MatchUdrs {
  MatchUdrs({
    this.matchId,
    this.inningsId,
    this.timestamp,
    this.team1Id,
    this.team1Remaining,
    this.team1Successful,
    this.team1Unsuccessful,
    this.team2Id,
    this.team2Remaining,
    this.team2Successful,
    this.team2Unsuccessful,
  });

  dynamic matchId;
  dynamic inningsId;
  DateTime? timestamp;
  dynamic team1Id;
  dynamic team1Remaining;
  dynamic team1Successful;
  dynamic team1Unsuccessful;
  dynamic team2Id;
  dynamic team2Remaining;
  dynamic team2Successful;
  dynamic team2Unsuccessful;

  factory MatchUdrs.fromJson(Map<String, dynamic> json) => MatchUdrs(
    matchId: json["matchId"],
    inningsId: json["inningsId"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    team1Id: json["team1Id"],
    team1Remaining: json["team1Remaining"],
    team1Successful: json["team1Successful"],
    team1Unsuccessful: json["team1Unsuccessful"],
    team2Id: json["team2Id"],
    team2Remaining: json["team2Remaining"],
    team2Successful: json["team2Successful"],
    team2Unsuccessful: json["team2Unsuccessful"],
  );

  Map<String, dynamic> toJson() => {
    "matchId": matchId,
    "inningsId": inningsId,
    "timestamp": timestamp?.toIso8601String(),
    "team1Id": team1Id,
    "team1Remaining": team1Remaining,
    "team1Successful": team1Successful,
    "team1Unsuccessful": team1Unsuccessful,
    "team2Id": team2Id,
    "team2Remaining": team2Remaining,
    "team2Successful": team2Successful,
    "team2Unsuccessful": team2Unsuccessful,
  };
}

class PartnerShip {
  PartnerShip({
    this.balls,
    this.runs,
  });

  dynamic balls;
  dynamic runs;

  factory PartnerShip.fromJson(Map<String, dynamic> json) => PartnerShip(
    balls: json["balls"],
    runs: json["runs"],
  );

  Map<String, dynamic> toJson() => {
    "balls": balls,
    "runs": runs,
  };
}

class PpData {
  PpData({
    this.pp1,
  });

  Pp1? pp1;

  factory PpData.fromJson(Map<String, dynamic> json) => PpData(
    pp1: json["pp_1"] == null ? null : Pp1.fromJson(json["pp_1"]),
  );

  Map<String, dynamic> toJson() => {
    "pp_1": pp1?.toJson(),
  };
}

class Pp1 {
  Pp1({
    this.ppId,
    this.ppOversFrom,
    this.ppOversTo,
    this.ppType,
    this.runsScored,
  });

  dynamic ppId;
  double? ppOversFrom;
  dynamic ppOversTo;
  String? ppType;
  dynamic runsScored;

  factory Pp1.fromJson(Map<String, dynamic> json) => Pp1(
    ppId: json["ppId"],
    ppOversFrom: json["ppOversFrom"]?.toDouble(),
    ppOversTo: json["ppOversTo"],
    ppType: json["ppType"],
    runsScored: json["runsScored"],
  );

  Map<String, dynamic> toJson() => {
    "ppId": ppId,
    "ppOversFrom": ppOversFrom,
    "ppOversTo": ppOversTo,
    "ppType": ppType,
    "runsScored": runsScored,
  };
}

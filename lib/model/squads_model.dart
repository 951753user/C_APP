// To parse this JSON data, do
//
//     final squadsModel = squadsModelFromJson(jsonString);

import 'dart:convert';

SquadsModel squadsModelFromJson(String str) => SquadsModel.fromJson(json.decode(str));

String squadsModelToJson(SquadsModel data) => json.encode(data.toJson());

class SquadsModel {
  SquadsModel({
    this.team1,
    this.team2,
  });

  Team1Class? team1;
  Team1Class? team2;

  factory SquadsModel.fromJson(Map<String, dynamic> json) => SquadsModel(
    team1: json["team1"] == null ? null : Team1Class.fromJson(json["team1"]),
    team2: json["team2"] == null ? null : Team1Class.fromJson(json["team2"]),
  );

  Map<String, dynamic> toJson() => {
    "team1": team1?.toJson(),
    "team2": team2?.toJson(),
  };
}

class Team1Class {
  Team1Class({
    this.team,
    this.players,
  });

  TeamClass? team;
  Players? players;

  factory Team1Class.fromJson(Map<String, dynamic> json) => Team1Class(
    team: json["team"] == null ? null : TeamClass.fromJson(json["team"]),
    players: json["players"] == null ? null : Players.fromJson(json["players"]),
  );

  Map<String, dynamic> toJson() => {
    "team": team?.toJson(),
    "players": players?.toJson(),
  };
}

class Players {
  Players({
    this.playingXi,
    this.bench,
    this.squad,
  });

  List<Bench>? playingXi;
  List<Bench>? bench;
  List<Bench>? squad;

  factory Players.fromJson(Map<String, dynamic> json) => Players(
    playingXi: json["playing XI"] == null ? [] : List<Bench>.from(json["playing XI"]!.map((x) => Bench.fromJson(x))),
    bench: json["bench"] == null ? [] : List<Bench>.from(json["bench"]!.map((x) => Bench.fromJson(x))),
    squad: json["Squad"] == null ? [] : List<Bench>.from(json["Squad"]!.map((x) => Bench.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "playing XI": playingXi == null ? [] : List<dynamic>.from(playingXi!.map((x) => x.toJson())),
    "bench": bench == null ? [] : List<dynamic>.from(bench!.map((x) => x.toJson())),
    "Squad": squad == null ? [] : List<dynamic>.from(squad!.map((x) => x.toJson())),
  };
}

class Bench {
  Bench({
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
  bool? captain;
  String? role;
  bool? keeper;
  bool? substitute;
  int? teamId;
  BattingStyle? battingStyle;
  String? bowlingStyle;
  int? faceImageId;

  factory Bench.fromJson(Map<String, dynamic> json) => Bench(
    id: json["id"],
    name: json["name"],
    fullName: json["fullName"],
    nickName: json["nickName"],
    captain: json["captain"],
    role: json["role"],
    keeper: json["keeper"],
    substitute: json["substitute"],
    teamId: json["teamId"],
    battingStyle: battingStyleValues.map[json["battingStyle"]]!,
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

enum BattingStyle { LEFT, RIGHT }

final battingStyleValues = EnumValues({
  "LEFT": BattingStyle.LEFT,
  "RIGHT": BattingStyle.RIGHT
});

enum Role { BOWLER, WK_BATSMAN, BATTING_ALLROUNDER, BATSMAN, BOWLING_ALLROUNDER }

final roleValues = EnumValues({
  "Batsman": Role.BATSMAN,
  "Batting Allrounder": Role.BATTING_ALLROUNDER,
  "Bowler": Role.BOWLER,
  "Bowling Allrounder": Role.BOWLING_ALLROUNDER,
  "WK-Batsman": Role.WK_BATSMAN
});

class TeamClass {
  TeamClass({
    this.teamId,
    this.teamName,
    this.teamSName,
    this.imageId,
  });

  int? teamId;
  String? teamName;
  String? teamSName;
  int? imageId;

  factory TeamClass.fromJson(Map<String, dynamic> json) => TeamClass(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

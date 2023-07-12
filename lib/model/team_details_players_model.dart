// To parse this JSON data, do
//
//     final teamDetailsPlayersModel = teamDetailsPlayersModelFromJson(jsonString);

import 'dart:convert';

TeamDetailsPlayersModel teamDetailsPlayersModelFromJson(String str) => TeamDetailsPlayersModel.fromJson(json.decode(str));

String teamDetailsPlayersModelToJson(TeamDetailsPlayersModel data) => json.encode(data.toJson());

class TeamDetailsPlayersModel {
  TeamDetailsPlayersModel({
    this.player,
  });

  List<Player>? player;

  factory TeamDetailsPlayersModel.fromJson(Map<String, dynamic> json) => TeamDetailsPlayersModel(
    player: json["player"] == null ? [] : List<Player>.from(json["player"]!.map((x) => Player.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "player": player == null ? [] : List<dynamic>.from(player!.map((x) => x.toJson())),
  };
}

class Player {
  Player({
    this.name,
    this.imageId,
    this.id,
    this.battingStyle,
    this.bowlingStyle,
  });

  String? name;
  int? imageId;
  String? id;
  String? battingStyle;
  String? bowlingStyle;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    name: json["name"],
    imageId: json["imageId"],
    id: json["id"],
    battingStyle: json["battingStyle"],
    bowlingStyle: json["bowlingStyle"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "imageId": imageId,
    "id": id,
    "battingStyle": battingStyle,
    "bowlingStyle": bowlingStyle,
  };
}


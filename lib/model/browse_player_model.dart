// To parse this JSON data, do
//
//     final searchPlayerModel = searchPlayerModelFromJson(jsonString);

import 'dart:convert';

SearchPlayerModel searchPlayerModelFromJson(String str) => SearchPlayerModel.fromJson(json.decode(str));

String searchPlayerModelToJson(SearchPlayerModel data) => json.encode(data.toJson());

class SearchPlayerModel {
  SearchPlayerModel({
    this.player,
    this.category,
  });

  List<Player>? player;
  String? category;

  factory SearchPlayerModel.fromJson(Map<String, dynamic> json) => SearchPlayerModel(
    player: json["player"] == null ? [] : List<Player>.from(json["player"]!.map((x) => Player.fromJson(x))),
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "player": player == null ? [] : List<dynamic>.from(player!.map((x) => x.toJson())),
    "category": category,
  };
}

class Player {
  Player({
    this.id,
    this.name,
    this.teamName,
    this.faceImageId,
  });

  String? id;
  String? name;
  String? teamName;
  String? faceImageId;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json["id"],
    name: json["name"],
    teamName: json["teamName"],
    faceImageId: json["faceImageId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "teamName": teamName,
    "faceImageId": faceImageId,
  };
}

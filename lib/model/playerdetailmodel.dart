// To parse this JSON data, do
//
//     final playerDetailModel = playerDetailModelFromJson(jsonString);

import 'dart:convert';

PlayerDetailModel playerDetailModelFromJson(String str) => PlayerDetailModel.fromJson(json.decode(str));

String playerDetailModelToJson(PlayerDetailModel data) => json.encode(data.toJson());

class PlayerDetailModel {
  PlayerDetailModel({
    this.id,
    this.bat,
    this.bowl,
    this.name,
    this.nickName,
    this.role,
    this.birthPlace,
    this.intlTeam,
    this.teams,
    this.doB,
    this.image,
    this.bio,
    this.rankings,
    this.doBFormat,
    this.faceImageId,
  });

  String? id;
  String? bat;
  String? bowl;
  String? name;
  String? nickName;
  String? role;
  String? birthPlace;
  String? intlTeam;
  String? teams;
  String? doB;
  String? image;
  String? bio;
  Rankings? rankings;
  String? doBFormat;
  String? faceImageId;

  factory PlayerDetailModel.fromJson(Map<String, dynamic> json) => PlayerDetailModel(
    id: json["id"],
    bat: json["bat"],
    bowl: json["bowl"],
    name: json["name"],
    nickName: json["nickName"],
    role: json["role"],
    birthPlace: json["birthPlace"],
    intlTeam: json["intlTeam"],
    teams: json["teams"],
    doB: json["DoB"],
    image: json["image"],
    bio: json["bio"],
    rankings: json["rankings"] == null ? null : Rankings.fromJson(json["rankings"]),
    doBFormat: json["DoBFormat"],
    faceImageId: json["faceImageId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bat": bat,
    "bowl": bowl,
    "name": name,
    "nickName": nickName,
    "role": role,
    "birthPlace": birthPlace,
    "intlTeam": intlTeam,
    "teams": teams,
    "DoB": doB,
    "image": image,
    "bio": bio,
    "rankings": rankings?.toJson(),
    "DoBFormat": doBFormat,
    "faceImageId": faceImageId,
  };
}

class Rankings {
  Rankings({
    this.bat,
    this.bowl,
    this.all,
  });

  List<Bat>? bat;
  List<Bat>? bowl;
  List<All>? all;

  factory Rankings.fromJson(Map<String, dynamic> json) => Rankings(
    bat: json["bat"] == null ? [] : List<Bat>.from(json["bat"]!.map((x) => Bat.fromJson(x))),
    bowl: json["bowl"] == null ? [] : List<Bat>.from(json["bowl"]!.map((x) => Bat.fromJson(x))),
    all: json["all"] == null ? [] : List<All>.from(json["all"]!.map((x) => All.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bat": bat == null ? [] : List<dynamic>.from(bat!.map((x) => x.toJson())),
    "bowl": bowl == null ? [] : List<dynamic>.from(bowl!.map((x) => x.toJson())),
    "all": all == null ? [] : List<dynamic>.from(all!.map((x) => x.toJson())),
  };
}

class All {
  All();

  factory All.fromJson(Map<String, dynamic> json) => All(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Bat {
  Bat({
    this.testBestRank,
    this.odiBestRank,
    this.t20BestRank,
  });

  String? testBestRank;
  String? odiBestRank;
  String? t20BestRank;

  factory Bat.fromJson(Map<String, dynamic> json) => Bat(
    testBestRank: json["testBestRank"],
    odiBestRank: json["odiBestRank"],
    t20BestRank: json["t20BestRank"],
  );

  Map<String, dynamic> toJson() => {
    "testBestRank": testBestRank,
    "odiBestRank": odiBestRank,
    "t20BestRank": t20BestRank,
  };
}

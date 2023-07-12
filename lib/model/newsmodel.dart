// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    this.storyList,
    this.lastUpdatedTime,
  });

  List<StoryList>? storyList;
  String? lastUpdatedTime;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    storyList: json["storyList"] == null ? [] : List<StoryList>.from(json["storyList"]!.map((x) => StoryList.fromJson(x))),
    lastUpdatedTime: json["lastUpdatedTime"],
  );

  Map<String, dynamic> toJson() => {
    "storyList": storyList == null ? [] : List<dynamic>.from(storyList!.map((x) => x.toJson())),
    "lastUpdatedTime": lastUpdatedTime,
  };
}

class StoryList {
  StoryList({
    this.story,
  });

  Story? story;

  factory StoryList.fromJson(Map<String, dynamic> json) => StoryList(
    story: json["story"] == null ? null : Story.fromJson(json["story"]),
  );

  Map<String, dynamic> toJson() => {
    "story": story?.toJson(),
  };
}

class Story {
  Story({
    this.id,
    this.hline,
    this.intro,
    this.pubTime,
    this.source,
    this.storyType,
    this.imageId,
    this.seoHeadline,
    this.context,
    this.coverImage,
    this.planId,
  });

  int? id;
  String? hline;
  String? intro;
  String? pubTime;
  Source? source;
  String? storyType;
  int? imageId;
  String? seoHeadline;
  String? context;
  CoverImage? coverImage;
  int? planId;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    hline: json["hline"],
    intro: json["intro"],
    pubTime: json["pubTime"],
    source: sourceValues.map[json["source"]]!,
    storyType: json["storyType"],
    imageId: json["imageId"],
    seoHeadline: json["seoHeadline"],
    context: json["context"],
    coverImage: json["coverImage"] == null ? null : CoverImage.fromJson(json["coverImage"]),
    planId: json["planId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hline": hline,
    "intro": intro,
    "pubTime": pubTime,
    "source": sourceValues.reverse[source],
    "storyType": storyType,
    "imageId": imageId,
    "seoHeadline": seoHeadline,
    "context": context,
    "coverImage": coverImage?.toJson(),
    "planId": planId,
  };
}

class CoverImage {
  CoverImage({
    this.id,
    this.caption,
    this.source,
  });

  String? id;
  String? caption;
  String? source;

  factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
    id: json["id"],
    caption: json["caption"],
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "caption": caption,
    "source": source,
  };
}

enum Source { CRICBUZZ }

final sourceValues = EnumValues({
  "Cricbuzz": Source.CRICBUZZ
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

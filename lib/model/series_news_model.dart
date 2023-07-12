// To parse this JSON data, do
//
//     final seriesNewsModel = seriesNewsModelFromJson(jsonString);

import 'dart:convert';

SeriesNewsModel seriesNewsModelFromJson(String str) => SeriesNewsModel.fromJson(json.decode(str));

String seriesNewsModelToJson(SeriesNewsModel data) => json.encode(data.toJson());

class SeriesNewsModel {
  SeriesNewsModel({
    this.storyList,
  });

  List<StoryList>? storyList;

  factory SeriesNewsModel.fromJson(Map<String, dynamic> json) => SeriesNewsModel(
    storyList: json["storyList"] == null ? [] : List<StoryList>.from(json["storyList"]!.map((x) => StoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "storyList": storyList == null ? [] : List<dynamic>.from(storyList!.map((x) => x.toJson())),
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
  });

  int? id;
  String? hline;
  String? intro;
  String? pubTime;
  String? source;
  String? storyType;
  int? imageId;
  String? seoHeadline;
  String? context;
  CoverImage? coverImage;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    hline: json["hline"],
    intro: json["intro"],
    pubTime: json["pubTime"],
    source: json["source"],
    storyType: json["storyType"],
    imageId: json["imageId"],
    seoHeadline: json["seoHeadline"],
    context: json["context"],
    coverImage: json["coverImage"] == null ? null : CoverImage.fromJson(json["coverImage"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hline": hline,
    "intro": intro,
    "pubTime": pubTime,
    "source": source,
    "storyType": storyType,
    "imageId": imageId,
    "seoHeadline": seoHeadline,
    "context": context,
    "coverImage": coverImage?.toJson(),
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

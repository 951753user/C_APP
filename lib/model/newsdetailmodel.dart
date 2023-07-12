// To parse this JSON data, do
//
//     final newsDetailModel = newsDetailModelFromJson(jsonString);

import 'dart:convert';

NewsDetailModel newsDetailModelFromJson(String str) => NewsDetailModel.fromJson(json.decode(str));

String newsDetailModelToJson(NewsDetailModel data) => json.encode(data.toJson());

class NewsDetailModel {
  NewsDetailModel({
    this.storyList,
    this.lastUpdatedTime,
    this.previousId,
  });

  List<StoryList>? storyList;
  String? lastUpdatedTime;
  String? previousId;

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) => NewsDetailModel(
    storyList: json["storyList"] == null ? [] : List<StoryList>.from(json["storyList"]!.map((x) => StoryList.fromJson(x))),
    lastUpdatedTime: json["lastUpdatedTime"],
    previousId: json["previousId"],
  );

  Map<String, dynamic> toJson() => {
    "storyList": storyList == null ? [] : List<dynamic>.from(storyList!.map((x) => x.toJson())),
    "lastUpdatedTime": lastUpdatedTime,
    "previousId": previousId,
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
  StorySource? source;
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
    source: storySourceValues.map[json["source"]]!,
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
    "source": storySourceValues.reverse[source],
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
  CoverImageSource? source;

  factory CoverImage.fromJson(Map<String, dynamic> json) => CoverImage(
    id: json["id"],
    caption: json["caption"],
    source: coverImageSourceValues.map[json["source"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "caption": caption,
    "source": coverImageSourceValues.reverse[source],
  };
}

enum CoverImageSource { GETTY, BCCI, AFP }

final coverImageSourceValues = EnumValues({
  "AFP": CoverImageSource.AFP,
  "BCCI": CoverImageSource.BCCI,
  "Getty": CoverImageSource.GETTY
});

enum StorySource { CRICBUZZ }

final storySourceValues = EnumValues({
  "Cricbuzz": StorySource.CRICBUZZ
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

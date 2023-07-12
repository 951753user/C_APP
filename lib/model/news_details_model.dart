// To parse this JSON data, do
//
//     final newsDetailsModel = newsDetailsModelFromJson(jsonString);

import 'dart:convert';

NewsDetailsModel newsDetailsModelFromJson(String str) => NewsDetailsModel.fromJson(json.decode(str));

String newsDetailsModelToJson(NewsDetailsModel data) => json.encode(data.toJson());

class NewsDetailsModel {
  NewsDetailsModel({
    this.id,
    this.context,
    this.headline,
    this.publishTime,
    this.coverImage,
    this.content,
    this.format,
    this.authors,
    this.tags,
    this.storyType,
    this.lastUpdatedTime,
    this.intro,
    this.source,
  });

  int? id;
  String? context;
  String? headline;
  String? publishTime;
  CoverImage? coverImage;
  List<ContentElement>? content;
  List<Format>? format;
  List<Author>? authors;
  List<Tag>? tags;
  String? storyType;
  String? lastUpdatedTime;
  String? intro;
  String? source;

  factory NewsDetailsModel.fromJson(Map<String, dynamic> json) => NewsDetailsModel(
    id: json["id"],
    context: json["context"],
    headline: json["headline"],
    publishTime: json["publishTime"],
    coverImage: json["coverImage"] == null ? null : CoverImage.fromJson(json["coverImage"]),
    content: json["content"] == null ? [] : List<ContentElement>.from(json["content"]!.map((x) => ContentElement.fromJson(x))),
    format: json["format"] == null ? [] : List<Format>.from(json["format"]!.map((x) => Format.fromJson(x))),
    authors: json["authors"] == null ? [] : List<Author>.from(json["authors"]!.map((x) => Author.fromJson(x))),
    tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
    storyType: json["storyType"],
    lastUpdatedTime: json["lastUpdatedTime"],
    intro: json["intro"],
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "context": context,
    "headline": headline,
    "publishTime": publishTime,
    "coverImage": coverImage?.toJson(),
    "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
    "format": format == null ? [] : List<dynamic>.from(format!.map((x) => x.toJson())),
    "authors": authors == null ? [] : List<dynamic>.from(authors!.map((x) => x.toJson())),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
    "storyType": storyType,
    "lastUpdatedTime": lastUpdatedTime,
    "intro": intro,
    "source": source,
  };
}

class Author {
  Author({
    this.id,
    this.name,
    this.imageId,
  });

  int? id;
  String? name;
  int? imageId;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["id"],
    name: json["name"],
    imageId: json["imageId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageId": imageId,
  };
}

class ContentElement {
  ContentElement({
    this.content,
  });

  ContentContent? content;

  factory ContentElement.fromJson(Map<String, dynamic> json) => ContentElement(
    content: json["content"] == null ? null : ContentContent.fromJson(json["content"]),
  );

  Map<String, dynamic> toJson() => {
    "content": content?.toJson(),
  };
}

class ContentContent {
  ContentContent({
    this.contentType,
    this.contentValue,
    this.hasFormat,
  });

  String? contentType;
  String? contentValue;
  bool? hasFormat;

  factory ContentContent.fromJson(Map<String, dynamic> json) => ContentContent(
    contentType: json["contentType"],
    contentValue: json["contentValue"],
    hasFormat: json["hasFormat"],
  );

  Map<String, dynamic> toJson() => {
    "contentType": contentType,
    "contentValue": contentValue,
    "hasFormat": hasFormat,
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

class Format {
  Format({
    this.type,
    this.value,
  });

  String? type;
  List<Value>? value;

  factory Format.fromJson(Map<String, dynamic> json) => Format(
    type: json["type"],
    value: json["value"] == null ? [] : List<Value>.from(json["value"]!.map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value == null ? [] : List<dynamic>.from(value!.map((x) => x.toJson())),
  };
}

class Value {
  Value({
    this.id,
    this.value,
  });

  String? id;
  String? value;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
  };
}

class Tag {
  Tag({
    this.itemName,
    this.itemType,
    this.itemId,
  });

  String? itemName;
  String? itemType;
  String? itemId;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    itemName: json["itemName"],
    itemType: json["itemType"],
    itemId: json["itemId"],
  );

  Map<String, dynamic> toJson() => {
    "itemName": itemName,
    "itemType": itemType,
    "itemId": itemId,
  };
}

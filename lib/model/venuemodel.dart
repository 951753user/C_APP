// To parse this JSON data, do
//
//     final venueModel = venueModelFromJson(jsonString);

import 'dart:convert';

VenueModel venueModelFromJson(String str) => VenueModel.fromJson(json.decode(str));

String venueModelToJson(VenueModel data) => json.encode(data.toJson());

class VenueModel {
  VenueModel({
    this.seriesVenue,
    this.seriesId,
    this.seriesName,
  });

  List<SeriesVenue>? seriesVenue;
  int? seriesId;
  String? seriesName;

  factory VenueModel.fromJson(Map<String, dynamic> json) => VenueModel(
    seriesVenue: json["seriesVenue"] == null ? [] : List<SeriesVenue>.from(json["seriesVenue"]!.map((x) => SeriesVenue.fromJson(x))),
    seriesId: json["seriesId"],
    seriesName: json["seriesName"],
  );

  Map<String, dynamic> toJson() => {
    "seriesVenue": seriesVenue == null ? [] : List<dynamic>.from(seriesVenue!.map((x) => x.toJson())),
    "seriesId": seriesId,
    "seriesName": seriesName,
  };
}

class SeriesVenue {
  SeriesVenue({
    this.id,
    this.ground,
    this.city,
    this.country,
    this.imageId,
  });

  int? id;
  String? ground;
  String? city;
  String? country;
  String? imageId;

  factory SeriesVenue.fromJson(Map<String, dynamic> json) => SeriesVenue(
    id: json["id"],
    ground: json["ground"],
    city: json["city"],
    country: json["country"],
    imageId: json["imageId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ground": ground,
    "city": city,
    "country": country,
    "imageId": imageId,
  };
}

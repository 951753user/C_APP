// To parse this JSON data, do
//
//     final venueDetailsModel = venueDetailsModelFromJson(jsonString);

import 'dart:convert';

VenueDetailsModel venueDetailsModelFromJson(String str) => VenueDetailsModel.fromJson(json.decode(str));

String venueDetailsModelToJson(VenueDetailsModel data) => json.encode(data.toJson());

class VenueDetailsModel {
  VenueDetailsModel({
    this.ground,
    this.city,
    this.country,
    this.timezone,
    this.established,
    this.capacity,
    this.knownAs,
    this.ends,
    this.homeTeam,
    this.floodlights,
    this.profile,
    this.imageUrl,
    this.imageId,
  });

  String? ground;
  String? city;
  String? country;
  String? timezone;
  int? established;
  String? capacity;
  String? knownAs;
  String? ends;
  String? homeTeam;
  bool? floodlights;
  String? profile;
  String? imageUrl;
  String? imageId;

  factory VenueDetailsModel.fromJson(Map<String, dynamic> json) => VenueDetailsModel(
    ground: json["ground"],
    city: json["city"],
    country: json["country"],
    timezone: json["timezone"],
    established: json["established"],
    capacity: json["capacity"],
    knownAs: json["knownAs"],
    ends: json["ends"],
    homeTeam: json["homeTeam"],
    floodlights: json["floodlights"],
    profile: json["profile"],
    imageUrl: json["imageUrl"],
    imageId: json["imageId"],
  );

  Map<String, dynamic> toJson() => {
    "ground": ground,
    "city": city,
    "country": country,
    "timezone": timezone,
    "established": established,
    "capacity": capacity,
    "knownAs": knownAs,
    "ends": ends,
    "homeTeam": homeTeam,
    "floodlights": floodlights,
    "profile": profile,
    "imageUrl": imageUrl,
    "imageId": imageId,
  };
}

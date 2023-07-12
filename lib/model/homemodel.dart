// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.homepage,
    this.matches,
    this.videoList,
    this.settingsLastUpdated,
    this.endPointsLastUpdated,
    this.adsLastUpdated,
    this.featuredVideoLists,
    this.surveyLastUpdated,
    this.responseLastUpdated,
    this.cbPlusStrip,
  });

  List<Homepage>? homepage;
  List<MatchElement>? matches;
  HomeModelVideoList? videoList;
  String? settingsLastUpdated;
  String? endPointsLastUpdated;
  String? adsLastUpdated;
  List<FeaturedVideoList>? featuredVideoLists;
  String? surveyLastUpdated;
  String? responseLastUpdated;
  CbPlusStrip? cbPlusStrip;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    homepage: json["homepage"] == null ? [] : List<Homepage>.from(json["homepage"]!.map((x) => Homepage.fromJson(x))),
    matches: json["matches"] == null ? [] : List<MatchElement>.from(json["matches"]!.map((x) => MatchElement.fromJson(x))),
    videoList: json["videoList"] == null ? null : HomeModelVideoList.fromJson(json["videoList"]),
    settingsLastUpdated: json["settingsLastUpdated"],
    endPointsLastUpdated: json["endPointsLastUpdated"],
    adsLastUpdated: json["adsLastUpdated"],
    featuredVideoLists: json["featuredVideoLists"] == null ? [] : List<FeaturedVideoList>.from(json["featuredVideoLists"]!.map((x) => FeaturedVideoList.fromJson(x))),
    surveyLastUpdated: json["surveyLastUpdated"],
    responseLastUpdated: json["responseLastUpdated"],
    cbPlusStrip: json["cbPlusStrip"] == null ? null : CbPlusStrip.fromJson(json["cbPlusStrip"]),
  );

  Map<String, dynamic> toJson() => {
    "homepage": homepage == null ? [] : List<dynamic>.from(homepage!.map((x) => x.toJson())),
    "matches": matches == null ? [] : List<dynamic>.from(matches!.map((x) => x.toJson())),
    "videoList": videoList?.toJson(),
    "settingsLastUpdated": settingsLastUpdated,
    "endPointsLastUpdated": endPointsLastUpdated,
    "adsLastUpdated": adsLastUpdated,
    "featuredVideoLists": featuredVideoLists == null ? [] : List<dynamic>.from(featuredVideoLists!.map((x) => x.toJson())),
    "surveyLastUpdated": surveyLastUpdated,
    "responseLastUpdated": responseLastUpdated,
    "cbPlusStrip": cbPlusStrip?.toJson(),
  };
}

class CbPlusStrip {
  CbPlusStrip({
    this.lightImageId,
    this.darkImageId,
    this.stripText,
    this.appIndexUrl,
  });

  int? lightImageId;
  int? darkImageId;
  String? stripText;
  String? appIndexUrl;

  factory CbPlusStrip.fromJson(Map<String, dynamic> json) => CbPlusStrip(
    lightImageId: json["lightImageId"],
    darkImageId: json["darkImageId"],
    stripText: json["stripText"],
    appIndexUrl: json["appIndexUrl"],
  );

  Map<String, dynamic> toJson() => {
    "lightImageId": lightImageId,
    "darkImageId": darkImageId,
    "stripText": stripText,
    "appIndexUrl": appIndexUrl,
  };
}

class FeaturedVideoList {
  FeaturedVideoList({
    this.videoList,
    this.appIndex,
    this.name,
  });

  List<VideoListElement>? videoList;
  AppIndex? appIndex;
  String? name;

  factory FeaturedVideoList.fromJson(Map<String, dynamic> json) => FeaturedVideoList(
    videoList: json["videoList"] == null ? [] : List<VideoListElement>.from(json["videoList"]!.map((x) => VideoListElement.fromJson(x))),
    appIndex: json["appIndex"] == null ? null : AppIndex.fromJson(json["appIndex"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "videoList": videoList == null ? [] : List<dynamic>.from(videoList!.map((x) => x.toJson())),
    "appIndex": appIndex?.toJson(),
    "name": name,
  };
}

class AppIndex {
  AppIndex({
    this.seoTitle,
    this.webUrl,
  });

  String? seoTitle;
  String? webUrl;

  factory AppIndex.fromJson(Map<String, dynamic> json) => AppIndex(
    seoTitle: json["seoTitle"],
    webUrl: json["webURL"],
  );

  Map<String, dynamic> toJson() => {
    "seoTitle": seoTitle,
    "webURL": webUrl,
  };
}

class VideoListElement {
  VideoListElement({
    this.video,
  });

  Video? video;

  factory VideoListElement.fromJson(Map<String, dynamic> json) => VideoListElement(
    video: json["video"] == null ? null : Video.fromJson(json["video"]),
  );

  Map<String, dynamic> toJson() => {
    "video": video?.toJson(),
  };
}

class Video {
  Video({
    this.id,
    this.title,
    this.timestamp,
    this.imageId,
    this.videoUrl,
    this.adTag,
    this.videoType,
    this.tags,
    this.planId,
    this.premiumVideoUrl,
  });

  String? id;
  String? title;
  String? timestamp;
  String? imageId;
  String? videoUrl;
  String? adTag;
  String? videoType;
  List<Tag>? tags;
  int? planId;
  String? premiumVideoUrl;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    title: json["title"],
    timestamp: json["timestamp"],
    imageId: json["imageId"],
    videoUrl: json["videoUrl"],
    adTag: json["adTag"],
    videoType: json["videoType"],
    tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
    planId: json["planId"],
    premiumVideoUrl: json["premiumVideoUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "timestamp": timestamp,
    "imageId": imageId,
    "videoUrl": videoUrl,
    "adTag": adTag,
    "videoType": videoType,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
    "planId": planId,
    "premiumVideoUrl": premiumVideoUrl,
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

class Homepage {
  Homepage({
    this.stories,
  });

  Stories? stories;

  factory Homepage.fromJson(Map<String, dynamic> json) => Homepage(
    stories: json["stories"] == null ? null : Stories.fromJson(json["stories"]),
  );

  Map<String, dynamic> toJson() => {
    "stories": stories?.toJson(),
  };
}

class Stories {
  Stories({
    this.headline,
    this.intro,
    this.context,
    this.itemType,
    this.itemId,
    this.appIndexUrl,
    this.imageId,
    this.cardType,
    this.publishedTime,
    this.planId,
    this.analyticsTag,
  });

  String? headline;
  String? intro;
  String? context;
  String? itemType;
  int? itemId;
  String? appIndexUrl;
  int? imageId;
  String? cardType;
  String? publishedTime;
  int? planId;
  String? analyticsTag;

  factory Stories.fromJson(Map<String, dynamic> json) => Stories(
    headline: json["headline"],
    intro: json["intro"],
    context: json["context"],
    itemType: json["itemType"],
    itemId: json["itemId"],
    appIndexUrl: json["appIndexUrl"],
    imageId: json["imageId"],
    cardType: json["cardType"],
    publishedTime: json["publishedTime"],
    planId: json["planId"],
    analyticsTag: json["analyticsTag"],
  );

  Map<String, dynamic> toJson() => {
    "headline": headline,
    "intro": intro,
    "context": context,
    "itemType": itemType,
    "itemId": itemId,
    "appIndexUrl": appIndexUrl,
    "imageId": imageId,
    "cardType": cardType,
    "publishedTime": publishedTime,
    "planId": planId,
    "analyticsTag": analyticsTag,
  };
}

class MatchElement {
  MatchElement({
    this.match,
  });

  MatchMatch? match;

  factory MatchElement.fromJson(Map<String, dynamic> json) => MatchElement(
    match: json["match"] == null ? null : MatchMatch.fromJson(json["match"]),
  );

  Map<String, dynamic> toJson() => {
    "match": match?.toJson(),
  };
}

class MatchMatch {
  MatchMatch({
    this.matchInfo,
    this.matchScore,
  });

  MatchInfo? matchInfo;
  MatchScore? matchScore;

  factory MatchMatch.fromJson(Map<String, dynamic> json) => MatchMatch(
    matchInfo: json["matchInfo"] == null ? null : MatchInfo.fromJson(json["matchInfo"]),
    matchScore: json["matchScore"] == null ? null : MatchScore.fromJson(json["matchScore"]),
  );

  Map<String, dynamic> toJson() => {
    "matchInfo": matchInfo?.toJson(),
    "matchScore": matchScore?.toJson(),
  };
}

class MatchInfo {
  MatchInfo({
    this.matchId,
    this.seriesId,
    this.seriesName,
    this.matchDesc,
    this.matchFormat,
    this.startDate,
    this.endDate,
    this.state,
    this.status,
    this.team1,
    this.team2,
    this.venueInfo,
    this.currBatTeamId,
    this.seriesStartDt,
    this.seriesEndDt,
    this.isTimeAnnounced,
    this.stateTitle,
    this.matchType,
    this.isTournament,
  });

  int? matchId;
  int? seriesId;
  String? seriesName;
  String? matchDesc;
  String? matchFormat;
  String? startDate;
  String? endDate;
  String? state;
  String? status;
  Team? team1;
  Team? team2;
  VenueInfo? venueInfo;
  int? currBatTeamId;
  String? seriesStartDt;
  String? seriesEndDt;
  bool? isTimeAnnounced;
  String? stateTitle;
  String? matchType;
  bool? isTournament;

  factory MatchInfo.fromJson(Map<String, dynamic> json) => MatchInfo(
    matchId: json["matchId"],
    seriesId: json["seriesId"],
    seriesName: json["seriesName"],
    matchDesc: json["matchDesc"],
    matchFormat: json["matchFormat"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    state: json["state"],
    status: json["status"],
    team1: json["team1"] == null ? null : Team.fromJson(json["team1"]),
    team2: json["team2"] == null ? null : Team.fromJson(json["team2"]),
    venueInfo: json["venueInfo"] == null ? null : VenueInfo.fromJson(json["venueInfo"]),
    currBatTeamId: json["currBatTeamId"],
    seriesStartDt: json["seriesStartDt"],
    seriesEndDt: json["seriesEndDt"],
    isTimeAnnounced: json["isTimeAnnounced"],
    stateTitle: json["stateTitle"],
    matchType: json["matchType"],
    isTournament: json["isTournament"],
  );

  Map<String, dynamic> toJson() => {
    "matchId": matchId,
    "seriesId": seriesId,
    "seriesName": seriesName,
    "matchDesc": matchDesc,
    "matchFormat": matchFormat,
    "startDate": startDate,
    "endDate": endDate,
    "state": state,
    "status": status,
    "team1": team1?.toJson(),
    "team2": team2?.toJson(),
    "venueInfo": venueInfo?.toJson(),
    "currBatTeamId": currBatTeamId,
    "seriesStartDt": seriesStartDt,
    "seriesEndDt": seriesEndDt,
    "isTimeAnnounced": isTimeAnnounced,
    "stateTitle": stateTitle,
    "matchType": matchType,
    "isTournament": isTournament,
  };
}

class Team {
  Team({
    this.teamId,
    this.teamName,
    this.teamSName,
    this.imageId,
  });

  int? teamId;
  String? teamName;
  String? teamSName;
  int? imageId;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
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

class VenueInfo {
  VenueInfo({
    this.id,
    this.ground,
    this.city,
    this.timezone,
  });

  int? id;
  String? ground;
  String? city;
  String? timezone;

  factory VenueInfo.fromJson(Map<String, dynamic> json) => VenueInfo(
    id: json["id"],
    ground: json["ground"],
    city: json["city"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ground": ground,
    "city": city,
    "timezone": timezone,
  };
}

class MatchScore {
  MatchScore({
    this.team1Score,
    this.team2Score,
  });

  TeamScore? team1Score;
  TeamScore? team2Score;

  factory MatchScore.fromJson(Map<String, dynamic> json) => MatchScore(
    team1Score: json["team1Score"] == null ? null : TeamScore.fromJson(json["team1Score"]),
    team2Score: json["team2Score"] == null ? null : TeamScore.fromJson(json["team2Score"]),
  );

  Map<String, dynamic> toJson() => {
    "team1Score": team1Score?.toJson(),
    "team2Score": team2Score?.toJson(),
  };
}

class TeamScore {
  TeamScore({
    this.inngs1,
  });

  Inngs1? inngs1;

  factory TeamScore.fromJson(Map<String, dynamic> json) => TeamScore(
    inngs1: json["inngs1"] == null ? null : Inngs1.fromJson(json["inngs1"]),
  );

  Map<String, dynamic> toJson() => {
    "inngs1": inngs1?.toJson(),
  };
}

class Inngs1 {
  Inngs1({
    this.inningsId,
    this.runs,
    this.wickets,
    this.overs,
  });

  int? inningsId;
  int? runs;
  int? wickets;
  double? overs;

  factory Inngs1.fromJson(Map<String, dynamic> json) => Inngs1(
    inningsId: json["inningsId"],
    runs: json["runs"],
    wickets: json["wickets"],
    overs: json["overs"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "inningsId": inningsId,
    "runs": runs,
    "wickets": wickets,
    "overs": overs,
  };
}

class HomeModelVideoList {
  HomeModelVideoList({
    this.videoList,
    this.appIndex,
  });

  List<VideoListElement>? videoList;
  AppIndex? appIndex;

  factory HomeModelVideoList.fromJson(Map<String, dynamic> json) => HomeModelVideoList(
    videoList: json["videoList"] == null ? [] : List<VideoListElement>.from(json["videoList"]!.map((x) => VideoListElement.fromJson(x))),
    appIndex: json["appIndex"] == null ? null : AppIndex.fromJson(json["appIndex"]),
  );

  Map<String, dynamic> toJson() => {
    "videoList": videoList == null ? [] : List<dynamic>.from(videoList!.map((x) => x.toJson())),
    "appIndex": appIndex?.toJson(),
  };
}



// // To parse this JSON data, do
// //
// //     final homeModel = homeModelFromJson(jsonString);
//
// import 'dart:convert';
//
// HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));
//
// String homeModelToJson(HomeModel data) => json.encode(data.toJson());
//
// class HomeModel {
//   HomeModel({
//     this.homepage,
//     this.matches,
//     this.videoList,
//     this.settingsLastUpdated,
//     this.endPointsLastUpdated,
//     this.adsLastUpdated,
//     this.featuredVideoLists,
//     this.surveyLastUpdated,
//     this.responseLastUpdated,
//     this.cbPlusStrip,
//   });
//
//   List<dynamic>? homepage;
//   List<dynamic>? matches;
//   dynamic videoList;
//   String? settingsLastUpdated;
//   String? endPointsLastUpdated;
//   String? adsLastUpdated;
//   List<dynamic>? featuredVideoLists;
//   String? surveyLastUpdated;
//   String? responseLastUpdated;
//   dynamic cbPlusStrip;
//
//   factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
//     homepage: json["homepage"] == null ? [] : List<Homepage>.from(json["homepage"].map((x) => Homepage.fromJson(x))),
//     matches: json["matches"] == null ? [] : List<MatchElement>.from(json["matches"].map((x) => MatchElement.fromJson(x))),
//     videoList: json["videoList"] == null ? null : HomeModelVideoList.fromJson(json["videoList"]),
//     settingsLastUpdated: json["settingsLastUpdated"],
//     endPointsLastUpdated: json["endPointsLastUpdated"],
//     adsLastUpdated: json["adsLastUpdated"],
//     featuredVideoLists: json["featuredVideoLists"] == null ? [] : List<FeaturedVideoList>.from(json["featuredVideoLists"].map((x) => FeaturedVideoList.fromJson(x))),
//     surveyLastUpdated: json["surveyLastUpdated"],
//     responseLastUpdated: json["responseLastUpdated"],
//     cbPlusStrip: json["cbPlusStrip"] == null ? null : CbPlusStrip.fromJson(json["cbPlusStrip"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "homepage": homepage == null ? [] : List<dynamic>.from(homepage!.map((x) => x.toJson())),
//     "matches": matches == null ? [] : List<dynamic>.from(matches!.map((x) => x.toJson())),
//     "videoList": videoList?.toJson(),
//     "settingsLastUpdated": settingsLastUpdated,
//     "endPointsLastUpdated": endPointsLastUpdated,
//     "adsLastUpdated": adsLastUpdated,
//     "featuredVideoLists": featuredVideoLists == null ? [] : List<dynamic>.from(featuredVideoLists!.map((x) => x.toJson())),
//     "surveyLastUpdated": surveyLastUpdated,
//     "responseLastUpdated": responseLastUpdated,
//     "cbPlusStrip": cbPlusStrip?.toJson(),
//   };
// }
//
// class CbPlusStrip {
//   CbPlusStrip({
//     this.lightImageId,
//     this.darkImageId,
//     this.stripText,
//     this.appIndexUrl,
//   });
//
//   int? lightImageId;
//   int? darkImageId;
//   String? stripText;
//   String? appIndexUrl;
//
//   factory CbPlusStrip.fromJson(Map<String, dynamic> json) => CbPlusStrip(
//     lightImageId: json["lightImageId"],
//     darkImageId: json["darkImageId"],
//     stripText: json["stripText"],
//     appIndexUrl: json["appIndexUrl"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "lightImageId": lightImageId,
//     "darkImageId": darkImageId,
//     "stripText": stripText,
//     "appIndexUrl": appIndexUrl,
//   };
// }
//
// class FeaturedVideoList {
//   FeaturedVideoList({
//     this.videoList,
//     this.appIndex,
//     this.name,
//   });
//
//   dynamic videoList;
//   dynamic appIndex;
//   String? name;
//
//   factory FeaturedVideoList.fromJson(Map<String, dynamic> json) => FeaturedVideoList(
//     videoList: json["videoList"] == null ? [] : List<dynamic>.from(json["videoList"].map((x) => VideoListElement.fromJson(x))),
//     appIndex: json["appIndex"] == null ? null : AppIndex.fromJson(json["appIndex"]),
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "videoList": videoList == null ? [] : List<dynamic>.from(videoList.map((x) => x.toJson())),
//     "appIndex": appIndex.toJson(),
//     "name": name,
//   };
// }
//
// class AppIndex {
//   AppIndex({
//     this.seoTitle,
//     this.webUrl,
//   });
//
//   String? seoTitle;
//   String? webUrl;
//
//   factory AppIndex.fromJson(Map<String, dynamic> json) => AppIndex(
//     seoTitle: json["seoTitle"],
//     webUrl: json["webURL"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "seoTitle": seoTitle,
//     "webURL": webUrl,
//   };
// }
//
// class VideoListElement {
//   VideoListElement({
//     this.video,
//   });
//
//   dynamic video;
//
//   factory VideoListElement.fromJson(Map<String, dynamic> json) => VideoListElement(
//     video: json["video"] == null ? null : Video.fromJson(json["video"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "video": video?.toJson(),
//   };
// }
//
// class Video {
//   Video({
//     this.id,
//     this.title,
//     this.timestamp,
//     this.imageId,
//     this.videoUrl,
//     this.adTag,
//     this.videoType,
//     this.tags,
//     this.planId,
//     this.premiumVideoUrl,
//     this.isLive,
//   });
//
//   String? id;
//   String? title;
//   String? timestamp;
//   String? imageId;
//   String? videoUrl;
//   String? adTag;
//   dynamic videoType;
//   List<dynamic>? tags;
//   int? planId;
//   String? premiumVideoUrl;
//   bool? isLive;
//
//   factory Video.fromJson(Map<String, dynamic> json) => Video(
//     id: json["id"],
//     title: json["title"],
//     timestamp: json["timestamp"],
//     imageId: json["imageId"],
//     videoUrl: json["videoUrl"],
//     adTag: json["adTag"],
//     videoType: json["videoType"],
//     tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
//     planId: json["planId"],
//     premiumVideoUrl: json["premiumVideoUrl"],
//     isLive: json["isLive"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "timestamp": timestamp,
//     "imageId": imageId,
//     "videoUrl": videoUrl,
//     "adTag": adTag,
//     "videoType": videoType,
//     "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
//     "planId": planId,
//     "premiumVideoUrl": premiumVideoUrl,
//     "isLive": isLive,
//   };
// }
//
// class Tag {
//   Tag({
//     this.itemName,
//     this.itemType,
//     this.itemId,
//   });
//
//   String? itemName;
//   dynamic itemType;
//   String? itemId;
//
//   factory Tag.fromJson(Map<String, dynamic> json) => Tag(
//     itemName: json["itemName"],
//     itemType: json["itemType"],
//     itemId: json["itemId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "itemName": itemName,
//     "itemType": itemType,
//     "itemId": itemId,
//   };
// }
//
// class Homepage {
//   Homepage({
//     this.stories,
//   });
//
//   dynamic stories;
//
//   factory Homepage.fromJson(Map<String, dynamic> json) => Homepage(
//     stories: json["stories"] == null ? null : Stories.fromJson(json["stories"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "stories": stories?.toJson(),
//   };
// }
//
// class Stories {
//   Stories({
//     this.headline,
//     this.intro,
//     this.context,
//     this.itemType,
//     this.itemId,
//     this.appIndexUrl,
//     this.imageId,
//     this.cardType,
//     this.publishedTime,
//     this.planId,
//     this.analyticsTag,
//   });
//
//   String? headline;
//   String? intro;
//   String? context;
//   dynamic itemType;
//   int? itemId;
//   String? appIndexUrl;
//   int? imageId;
//   dynamic cardType;
//   String? publishedTime;
//   int? planId;
//   String? analyticsTag;
//
//   factory Stories.fromJson(Map<String, dynamic> json) => Stories(
//     headline: json["headline"],
//     intro: json["intro"],
//     context: json["context"],
//     itemType: json["itemType"],
//     itemId: json["itemId"],
//     appIndexUrl: json["appIndexUrl"],
//     imageId: json["imageId"],
//     cardType: json["cardType"],
//     publishedTime: json["publishedTime"],
//     planId: json["planId"],
//     analyticsTag: json["analyticsTag"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "headline": headline,
//     "intro": intro,
//     "context": context,
//     "itemType": itemType,
//     "itemId": itemId,
//     "appIndexUrl": appIndexUrl,
//     "imageId": imageId,
//     "cardType": cardType,
//     "publishedTime": publishedTime,
//     "planId": planId,
//     "analyticsTag": analyticsTag,
//   };
// }
//
// class MatchElement {
//   MatchElement({
//     this.match,
//   });
//
//   MatchMatch? match;
//
//   factory MatchElement.fromJson(Map<String, dynamic> json) => MatchElement(
//     match: json["match"] == null ? null : MatchMatch.fromJson(json["match"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "match": match?.toJson(),
//   };
// }
//
// class MatchMatch {
//   MatchMatch({
//     this.matchInfo,
//     this.matchScore,
//   });
//
//   dynamic matchInfo;
//   dynamic matchScore;
//
//   factory MatchMatch.fromJson(Map<String, dynamic> json) => MatchMatch(
//     matchInfo: json["matchInfo"] == null ? null : MatchInfo.fromJson(json["matchInfo"]),
//     matchScore: json["matchScore"] == null ? null : MatchScore.fromJson(json["matchScore"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "matchInfo": matchInfo?.toJson(),
//     "matchScore": matchScore?.toJson(),
//   };
// }
//
// class MatchInfo {
//   MatchInfo({
//     this.matchId,
//     this.seriesId,
//     this.seriesName,
//     this.matchDesc,
//     this.matchFormat,
//     this.startDate,
//     this.endDate,
//     this.state,
//     this.status,
//     this.team1,
//     this.team2,
//     this.venueInfo,
//     this.currBatTeamId,
//     this.seriesStartDt,
//     this.seriesEndDt,
//     this.isTimeAnnounced,
//     this.stateTitle,
//     this.matchType,
//     this.isTournament,
//   });
//
//   int? matchId;
//   int? seriesId;
//   String? seriesName;
//   String? matchDesc;
//   String? matchFormat;
//   String? startDate;
//   String? endDate;
//   String? state;
//   String? status;
//   dynamic team1;
//   dynamic team2;
//   dynamic venueInfo;
//   int? currBatTeamId;
//   String? seriesStartDt;
//   String? seriesEndDt;
//   bool? isTimeAnnounced;
//   String? stateTitle;
//   String? matchType;
//   bool? isTournament;
//
//   factory MatchInfo.fromJson(Map<String, dynamic> json) => MatchInfo(
//     matchId: json["matchId"],
//     seriesId: json["seriesId"],
//     seriesName: json["seriesName"],
//     matchDesc: json["matchDesc"],
//     matchFormat: json["matchFormat"],
//     startDate: json["startDate"],
//     endDate: json["endDate"],
//     state: json["state"],
//     status: json["status"],
//     team1: json["team1"] == null ? null : Team.fromJson(json["team1"]),
//     team2: json["team2"] == null ? null : Team.fromJson(json["team2"]),
//     venueInfo: json["venueInfo"] == null ? null : VenueInfo.fromJson(json["venueInfo"]),
//     currBatTeamId: json["currBatTeamId"],
//     seriesStartDt: json["seriesStartDt"],
//     seriesEndDt: json["seriesEndDt"],
//     isTimeAnnounced: json["isTimeAnnounced"],
//     stateTitle: json["stateTitle"],
//     matchType: json["matchType"],
//     isTournament: json["isTournament"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "matchId": matchId,
//     "seriesId": seriesId,
//     "seriesName": seriesName,
//     "matchDesc": matchDesc,
//     "matchFormat": matchFormat,
//     "startDate": startDate,
//     "endDate": endDate,
//     "state": state,
//     "status": status,
//     "team1": team1?.toJson(),
//     "team2": team2?.toJson(),
//     "venueInfo": venueInfo?.toJson(),
//     "currBatTeamId": currBatTeamId,
//     "seriesStartDt": seriesStartDt,
//     "seriesEndDt": seriesEndDt,
//     "isTimeAnnounced": isTimeAnnounced,
//     "stateTitle": stateTitle,
//     "matchType": matchType,
//     "isTournament": isTournament,
//   };
// }
//
// class Team {
//   Team({
//     this.teamId,
//     this.teamName,
//     this.teamSName,
//     this.imageId,
//   });
//
//   int? teamId;
//   String? teamName;
//   String? teamSName;
//   int? imageId;
//
//   factory Team.fromJson(Map<String, dynamic> json) => Team(
//     teamId: json["teamId"],
//     teamName: json["teamName"],
//     teamSName: json["teamSName"],
//     imageId: json["imageId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "teamId": teamId,
//     "teamName": teamName,
//     "teamSName": teamSName,
//     "imageId": imageId,
//   };
// }
//
// class VenueInfo {
//   VenueInfo({
//     this.id,
//     this.ground,
//     this.city,
//     this.timezone,
//   });
//
//   int? id;
//   String? ground;
//   String? city;
//   String? timezone;
//
//   factory VenueInfo.fromJson(Map<String, dynamic> json) => VenueInfo(
//     id: json["id"],
//     ground: json["ground"],
//     city: json["city"],
//     timezone: json["timezone"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "ground": ground,
//     "city": city,
//     "timezone": timezone,
//   };
// }
//
// class MatchScore {
//   MatchScore({
//     this.team1Score,
//     this.team2Score,
//   });
//
//   dynamic team1Score;
//   dynamic team2Score;
//
//   factory MatchScore.fromJson(Map<String, dynamic> json) => MatchScore(
//     team1Score: json["team1Score"] == null ? null : TeamScore.fromJson(json["team1Score"]),
//     team2Score: json["team2Score"] == null ? null : TeamScore.fromJson(json["team2Score"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "team1Score": team1Score.toJson(),
//     "team2Score": team2Score.toJson(),
//   };
// }
//
// class TeamScore {
//   TeamScore({
//     this.inngs1,
//   });
//
//   dynamic inngs1;
//
//   factory TeamScore.fromJson(Map<String, dynamic> json) => TeamScore(
//     inngs1: json["inngs1"] == null ? null : Inngs1.fromJson(json["inngs1"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "inngs1": inngs1.toJson(),
//   };
// }
//
// class Inngs1 {
//   Inngs1({
//     this.inningsId,
//     this.runs,
//     this.wickets,
//     this.overs,
//   });
//
//   int? inningsId;
//   int? runs;
//   int? wickets;
//   dynamic overs;
//
//   factory Inngs1.fromJson(Map<String, dynamic> json) => Inngs1(
//     inningsId: json["inningsId"],
//     runs: json["runs"],
//     wickets: json["wickets"],
//     overs: json["overs"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "inningsId": inningsId,
//     "runs": runs,
//     "wickets": wickets,
//     "overs": overs,
//   };
// }
//
// class HomeModelVideoList {
//   HomeModelVideoList({
//     this.videoList,
//     this.appIndex,
//   });
//
//   List<dynamic>? videoList;
//   dynamic appIndex;
//
//   factory HomeModelVideoList.fromJson(Map<String, dynamic> json) => HomeModelVideoList(
//     videoList: json["videoList"] == null ? [] : List<VideoListElement>.from(json["videoList"]!.map((x) => VideoListElement.fromJson(x))),
//     appIndex: json["appIndex"] == null ? null : AppIndex.fromJson(json["appIndex"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "videoList": videoList == null ? [] : List<dynamic>.from(videoList!.map((x) => x.toJson())),
//     "appIndex": appIndex.toJson(),
//   };
// }

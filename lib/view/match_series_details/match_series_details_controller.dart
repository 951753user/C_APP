import 'dart:convert';

import 'package:cricbuzzapp/model/news_details_model.dart';
import 'package:cricbuzzapp/model/point_table_model.dart';
import 'package:cricbuzzapp/model/series_matches_model.dart';
import 'package:cricbuzzapp/model/series_news_model.dart';
import 'package:cricbuzzapp/model/series_squad_model.dart';
import 'package:cricbuzzapp/model/squad_details_model.dart';
import 'package:cricbuzzapp/model/stats_details_model.dart';
import 'package:cricbuzzapp/model/stats_model.dart';
import 'package:cricbuzzapp/model/venue_details_matches_model.dart';
import 'package:cricbuzzapp/model/venue_details_model.dart';
import 'package:cricbuzzapp/model/venue_stats_model.dart';
import 'package:cricbuzzapp/model/venuemodel.dart';
import 'package:cricbuzzapp/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class MatchSeriesDetailsController extends GetxController{


  RxString newsLastId = "".obs;
  RxString scrollNewsFirstId = "".obs;
  RxString scrollNewsLastId = "".obs;

  RxList moreNews = [].obs;
  RxBool noMoreNewsData = false.obs;


  // String findDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, "0");
  //   String twoDigitHours = twoDigits(duration.inHours.remainder(60));
  //   String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  //   String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  //   if (duration.inSeconds < 3600) {
  //     return "$twoDigitMinutes M $twoDigitSeconds S";
  //   } else if (duration.inSeconds < 86400) {
  //     return "$twoDigitHours H $twoDigitMinutes M";
  //   } else {
  //     return "${duration.inDays} D ${((duration.inSeconds ~/ 3600) - (duration.inDays * 24)).toString()} H";
  //   }
  // }
  findDuration(DateTime timer){
    int time = DateTime.now().difference(timer).inSeconds.abs();
    if(time<3600){
      return "${DateTime.now().difference(timer).inMinutes.abs()} min ago";
    }else if(time<86400){
      return "${DateTime.now().difference(timer).inHours.abs()} hrs ago";
    }else if(time>86400){
      return "${DateTime.now().difference(timer).inDays.abs()} days ago";
    }
  }

  String getImage(String playerId){
    return 'https://api2.cricbuzz.com/a/img/v1/i1/c$playerId/i.jpg?p=det&d=high';
  }

  Future<dynamic> getSeriesMatchesData(String id) async{
    var responce = await http.get(Uri.parse(baseurl + series + id),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("series matches done");

    }

    return SeriesMatchesModel.fromJson(apiResponce);
  }

  Future<dynamic> getSeriesNewsData(String id) async{
    var responce = await http.get(Uri.parse(baseurl + series + id + news),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("series news done");
    }

    return SeriesNewsModel.fromJson(apiResponce);
  }

  Future<dynamic> getSeriesMoreNewsData(String id,String newsLastId) async{
    var responce = await http.get(Uri.parse("$baseurl$series$id$news?lastId=$newsLastId"),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      SeriesNewsModel data =
      SeriesNewsModel.fromJson(apiResponce);
      for (int i = 0; i < data.storyList!.length; i++) {
        if(i != 0){
          moreNews.add(data.storyList![i]);
        }
      }
      debugPrint("series news done");
    } else{
      noMoreNewsData.value = true;
    }

    return SeriesNewsModel.fromJson(apiResponce);
  }

  Future<dynamic> getSeriesNewsDetailsData(String id) async{
    var responce = await http.get(Uri.parse(baseurl + news + details + id),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("series news details done");
    }

    return NewsDetailsModel.fromJson(apiResponce);
  }

  Future<dynamic> getSeriesSquadData(String id) async{
    var responce = await http.get(Uri.parse(baseurl + series + id + squads),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("series squad done");
    }

    return SeriesSquadsModel.fromJson(apiResponce);
  }

  Future<dynamic> getSeriesSquadDetailsData(String id,String squadId) async{
    var responce = await http.get(Uri.parse('http://15.206.70.118:8500/series/$id/squads/$squadId'),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("series squad details done");
    }

    return SquadDetailsModel.fromJson(apiResponce);
  }

  Future<dynamic> getSeriesStatsData(String id) async{
    var responce = await http.get(Uri.parse(baseurl + series + id + stats),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("series stat done");
    }

    return StatsModel.fromJson(apiResponce);
  }

  Future<dynamic> getSeriesStatsDetailsData(String id,String type) async{
    var responce = await http.get(Uri.parse(baseurl + series + id + stats + '?statType=$type'),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("series stat details done");
    }

    return StatsDetailsModel.fromJson(apiResponce);
  }


  Future<dynamic> venuedata(String id) async{
    var responce = await http.get(Uri.parse(baseurl + series + id + venues),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("venue matches done");
    }

    return VenueModel.fromJson(apiResponce);
  }

  Future<dynamic> getVenueDetailsData(String id) async{
    var responce = await http.get(Uri.parse(baseurl + venueDetails + id),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("venue matches done");
    }

    return VenueDetailsModel.fromJson(apiResponce);
  }


  Future<dynamic> getVenueMatchesDetailsData(String id) async{
    var responce = await http.get(Uri.parse(baseurl + venueDetails + id + venueMatches),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("venue matches done");
    }

    return VenueDetailsMatchesModel.fromJson(apiResponce);
  }

  Future<dynamic> getVenueStatsDetailsData(String id) async{
    var responce = await http.get(Uri.parse(baseurl + venueDetails + id + stats),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("venue matches done");
    }

    return VenuestatsModel.fromJson(apiResponce);
  }

  Future<dynamic> getPointTableData(String id) async{
    var responce = await http.get(Uri.parse(baseurl + series + id + pointtable),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if(responce.statusCode == 200)
    {
      debugPrint("venue matches done");
    }

    return PointTableModel.fromJson(apiResponce);
  }


}
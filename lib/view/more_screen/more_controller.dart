import 'dart:convert';

import 'package:cricbuzzapp/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/browse_player_model.dart';
import '../../model/browse_series_model.dart';
import '../../model/browse_team_model.dart';
import '../../model/schedule_matches_model.dart';

class MoreController extends GetxController {
  TextEditingController txtSearchPlayer = TextEditingController();
  var searchedData = [].obs;

  //international
  RxString internationalLastId = "".obs;
  RxString scrollInternationalFirstId = "".obs;
  RxString scrollInternationalLastId = "".obs;

  RxList moreScheduleInternationalData = [].obs;
  RxBool noMoreInternationalData = false.obs;

  //domestic
  RxString domesticLastId = "".obs;
  RxString scrollDomesticFirstId = "".obs;
  RxString scrollDomesticLastId = "".obs;

  RxList moreScheduleDomesticData = [].obs;
  RxBool noMoreDomesticData = false.obs;

  //league
  RxString leagueLastId = "".obs;
  RxString scrollLeagueFirstId = "".obs;
  RxString scrollLeagueLastId = "".obs;

  RxList moreScheduleLeagueData = [].obs;
  RxBool noMoreLeagueData = false.obs;

  //women
  RxString womenLastId = "".obs;
  RxString scrollWomenFirstId = "".obs;
  RxString scrollWomenLastId = "".obs;

  RxList moreScheduleWomenData = [].obs;
  RxBool noMoreWomenData = false.obs;

  String getImage(String imageId) {
    return 'https://api2.cricbuzz.com/a/img/v1/i1/c$imageId/i.jpg?p=thumb&d=high';
  }



  //********************series

  Future<dynamic> getSeriesInternationalData() async {
    var responce =
        await http.get(Uri.parse(baseurl + browseInternationalSeries),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get series international done");
    }

    return BrowseInternationalSeriesModel.fromJson(apiResponce);
  }

  Future<dynamic> getSeriesLeagueData() async {
    var responce = await http.get(Uri.parse(baseurl + browseLeagueSeries),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get series league done");
    }

    return BrowseInternationalSeriesModel.fromJson(apiResponce);
  }

  Future<dynamic> getSeriesDomesticData() async {
    var responce = await http.get(Uri.parse(baseurl + browseDomesticSeries),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get series domestic done");
    }

    return BrowseInternationalSeriesModel.fromJson(apiResponce);
  }

  Future<dynamic> getSeriesWomenData() async {
    var responce = await http.get(Uri.parse(baseurl + browseWomenSeries),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get series women done");
    }

    return BrowseInternationalSeriesModel.fromJson(apiResponce);
  }

  //*********************teams

  Future<dynamic> getTeamInternationalData() async {
    var responce = await http.get(Uri.parse(baseurl + internationalTeam),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get team inter done");
    }

    return BrowseTeamModel.fromJson(apiResponce);
  }

  Future<dynamic> getTeamLeagueData() async {
    var responce = await http.get(Uri.parse(baseurl + leagueTeam),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get team league done");
    }

    return BrowseTeamModel.fromJson(apiResponce);
  }

  Future<dynamic> getTeamDomesticData() async {
    var responce = await http.get(Uri.parse(baseurl + domesticTeam),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get team domestic done");
    }

    return BrowseTeamModel.fromJson(apiResponce);
  }

  Future<dynamic> getTeamWomenData() async {
    var responce = await http.get(Uri.parse(baseurl + womenTeam),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get team women done");
    }

    return BrowseTeamModel.fromJson(apiResponce);
  }

  //*******************search player

  Future<dynamic> getSearchPlayerData() async {
    var responce = await http.get(Uri.parse(baseurl + browsePlayer),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get search player done");
    }

    return SearchPlayerModel.fromJson(apiResponce);
  }

  Future<dynamic> getSearchedPlayerData(String name) async {
    var responce =
        await http.get(Uri.parse("$baseurl$browsePlayer?search=$name"),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      searchedData.clear();
      debugPrint("get search player done");

      SearchPlayerModel data = SearchPlayerModel.fromJson(apiResponce);
      for (int i = 0; i < data.player!.length; i++) {
        searchedData.add(data.player![i]);
      }
    }

    return SearchPlayerModel.fromJson(apiResponce);
  }


  //**********schedule

  Future<dynamic> getScheduleInternationalData() async {
    var responce =
    await http.get(Uri.parse(baseurl + scheduleInternational),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get schedule done");
    }

    return ScheduleMatchesModel.fromJson(apiResponce);
  }

  Future<dynamic> getScheduleInternationalMoreData(String lastTimeStamp) async {
    var responce =
    await http.get(Uri.parse("$baseurl$scheduleInternational?lastTimeStamp=$lastTimeStamp"),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {

      ScheduleMatchesModel data =
      ScheduleMatchesModel.fromJson(apiResponce);
      for (int i = 0; i < data.matchScheduleMap!.length; i++) {

          moreScheduleInternationalData.add(data.matchScheduleMap![i]);

      }
      debugPrint("get schedule done");
      debugPrint("no more value ------${noMoreInternationalData.value}");
    } else{
      noMoreInternationalData.value = true;
    }

    return ScheduleMatchesModel.fromJson(apiResponce);
  }

  Future<dynamic> getScheduleLeagueData() async {
    var responce =
    await http.get(Uri.parse(baseurl + scheduleLeague),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get schedule done");
    }
    return ScheduleMatchesModel.fromJson(apiResponce);
  }

  Future<dynamic> getScheduleLeagueMoreData(String lastTimeStamp) async {
    var responce =
    await http.get(Uri.parse("$baseurl$scheduleLeague?lastTimeStamp=$lastTimeStamp"),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      ScheduleMatchesModel data =
      ScheduleMatchesModel.fromJson(apiResponce);
      for (int i = 0; i < data.matchScheduleMap!.length; i++) {

          moreScheduleLeagueData.add(data.matchScheduleMap![i]);

      }
      debugPrint("get schedule done");
    } else{
      noMoreLeagueData.value = true;
    }


    return ScheduleMatchesModel.fromJson(apiResponce);
  }



  Future<dynamic> getScheduleDomesticData() async {
    var responce =
    await http.get(Uri.parse(baseurl + scheduleDomestic),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get schedule done");
    }

    return ScheduleMatchesModel.fromJson(apiResponce);
  }

  Future<dynamic> getScheduleDomesticMoreData(String lastTimeStamp) async {
    var responce =
    await http.get(Uri.parse("$baseurl$scheduleDomestic?lastTimeStamp=$lastTimeStamp"),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      ScheduleMatchesModel data =
      ScheduleMatchesModel.fromJson(apiResponce);
      for (int i = 0; i < data.matchScheduleMap!.length; i++) {

          moreScheduleDomesticData.add(data.matchScheduleMap![i]);

      }
      debugPrint("get schedule done");
    } else{
      noMoreDomesticData.value = true;
    }

    return ScheduleMatchesModel.fromJson(apiResponce);
  }

  Future<dynamic> getScheduleWomenData() async {
    var responce =
    await http.get(Uri.parse(baseurl + scheduleWomen),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      debugPrint("get schedule done");
    }

    return ScheduleMatchesModel.fromJson(apiResponce);
  }

  Future<dynamic> getScheduleWomenMoreData(String lastTimeStamp) async {
    var responce =
    await http.get(Uri.parse("$baseurl$scheduleWomen?lastTimeStamp=$lastTimeStamp"),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    debugPrint("$baseurl$scheduleWomen?lastTimeStamp=$lastTimeStamp");

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      ScheduleMatchesModel data =
      ScheduleMatchesModel.fromJson(apiResponce);
      for (int i = 0; i < data.matchScheduleMap!.length; i++) {

          moreScheduleWomenData.add(data.matchScheduleMap![i]);

      }
      debugPrint("get schedule done");
    } else{
      noMoreWomenData.value = true;
      // noMoreWomenData.refresh();
      // update();
    }

    return ScheduleMatchesModel.fromJson(apiResponce);
  }

}

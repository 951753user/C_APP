import 'dart:convert';

import 'package:cricbuzzapp/model/commentary.dart';
import 'package:cricbuzzapp/model/commentarymodel.dart';
import 'package:cricbuzzapp/model/commentarytwomodel.dart';
import 'package:cricbuzzapp/model/matchdetailmodel.dart';
import 'package:cricbuzzapp/model/matchdetailmodel.dart';
import 'package:cricbuzzapp/model/squads_model.dart';
import 'package:cricbuzzapp/services/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/player_details_model.dart';
import '../../model/scorecard_model.dart';

class MatchDetailsController extends GetxController {
  RxInt selectIndex = 0.obs;
  RxBool liveChanger = true.obs;
  dynamic matchID = "";
  RxInt ststuscode = 0.obs;

  RxList matchesCommentaryData = [].obs;

  RxBool noMoreData = false.obs;

  String findDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inSeconds < 3600) {
      return "$twoDigitMinutes M $twoDigitSeconds S";
    } else if (duration.inSeconds < 86400) {
      return "$twoDigitHours H $twoDigitMinutes M";
    } else {
      return "${duration.inDays} D ${((duration.inSeconds ~/ 3600) - (duration.inDays * 24)).toString()} H";
    }
  }

  Future<dynamic> getCommentaryData(
      String id, String inningId, String timeStamp) async {
    var responce = await http.get(
        Uri.parse(
            "$baseurl$match$id$commentary?inning=$inningId&lastTimeStamp=$timeStamp"),
        headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      print("getCommentary done");
    }

    return CommentaryScrollingModel.fromJson(apiResponce);
  }

  Future<dynamic> getCommentaryScrollData(
      String id, String inningId, String timeStamp) async {
    var responce = await http.get(
        Uri.parse(
            "$baseurl$match$id$commentary?inning=$inningId&lastTimeStamp=$timeStamp"),
        headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      // matchesCommentaryData.clear();
      debugPrint("done scroll commentry -->$baseurl$match$id$commentary?inning=$inningId&lastTimeStamp=$timeStamp");
      CommentaryScrollingModel data =
          CommentaryScrollingModel.fromJson(apiResponce);
      for (int i = 0; i < data.commentaryList!.length; i++) {
        if(i != 0){
          matchesCommentaryData.add(data.commentaryList![i]);
        }
      }
    } else{
      noMoreData.value = true;
      debugPrint("failed scroll commentry -->$baseurl$match$id$commentary?inning=$inningId&lastTimeStamp=$timeStamp");
    }

    return CommentaryScrollingModel.fromJson(apiResponce);
  }

  Future<dynamic> getPlayerDetailsData(String playerId) async {
    var responce = await http.get(
        Uri.parse(baseurl + browse + player + playerId),
        headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      print("getSquad done");
    }

    return PlayerDetailsModel.fromJson(apiResponce);
  }

  Future<dynamic> commentaryapi(String id) async {
    String apiurl = "http://15.206.70.118:8500/match/$id/commentary";
    var responce = await http.get(Uri.parse(apiurl),
        headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var result = json.decode(responce.body);
    // print("-----${responce.body}");
    if (responce.statusCode == 200) {
      // return result;
      print("==============live   doneeee");
    } else {
      print("============error...");
    }
    return CommentaryModel.fromJson(result);
  }

  Future<dynamic> commentarytwoapi(String id) async {
    String apiurl = "http://15.206.70.118:8500/match/$id/commentary";
    var responce = await http.get(Uri.parse(apiurl),
        headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var result = json.decode(responce.body);
    print("-----${responce.statusCode}");
    ststuscode.value = responce.statusCode;
    if (responce.statusCode == 200) {
      // return result;
      print("==============live   doneeee");
    } else {
      print("============commentrytwoerror");
    }
    return CommentaryTwoModel.fromJson(result);
  }

  Future<dynamic> matchdetailapi(String id) async {
    String apiurl = "http://15.206.70.118:8500/match/$id";
    var responce = await http.get(Uri.parse(apiurl),
        headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var result = json.decode(responce.body);
    if (responce.statusCode == 200) {
      // return result;
      print("==============done");
    } else {
      print("============error");
    }
    return MatchDetailModel.fromJson(result);
  }

  Future<dynamic> getSquadData(String id) async {
    var responce = await http.get(Uri.parse(baseurl + match + id + squads),
        headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      print("getSquad done");
    }

    return SquadsModel.fromJson(apiResponce);
  }

  Future<dynamic> getScorecardData(String id) async {
    var responce = await http.get(Uri.parse(baseurl + match + id + scoreboard),
        headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var apiResponce = json.decode(responce.body);

    if (responce.statusCode == 200) {
      print("getSquad done");
    }

    return ScorecardModel.fromJson(apiResponce);
  }

  String playerImage(String playerId) {
    return 'https://api2.cricbuzz.com/a/img/v1/i1/c$playerId/i.jpg?p=det&d=hd';
  }
}

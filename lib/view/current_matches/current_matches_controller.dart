import 'dart:convert';

import 'package:cricbuzzapp/model/live_matches_model.dart';
import 'package:cricbuzzapp/model/recent_matches_model.dart';
import 'package:cricbuzzapp/model/upcomingmatches_model.dart';
import 'package:cricbuzzapp/services/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CurrentMatchesController extends GetxController{
 RxInt len = 5.obs;

 RxList time = [
  "Today • 7:30 PM",
  "Today • 8:30 PM",
  "Today • 9:30 PM",
  "Today • 10:30 PM",
  "Today • 11:30 PM",
 ].obs;

 Future<dynamic> getLiveMatchesData() async{
  var responce = await http.get(Uri.parse(baseurl + liveMatches),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

  var apiResponce = json.decode(responce.body);

  if(responce.statusCode == 200)
  {
   print("getlive done");
  }

  return LiveMatchesModel.fromJson(apiResponce);
 }

 Future<dynamic> getUpcomingMatchesData() async{
  var responce = await http.get(Uri.parse(baseurl + upcomingMatches),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

  var apiResponce = json.decode(responce.body);

  if(responce.statusCode == 200)
  {
   print("getupcoming done");
  }

  return UpcomingMatchesModel.fromJson(apiResponce);
 }

 Future<dynamic> getrecentMatchesData() async{
  var responce = await http.get(Uri.parse(baseurl + recentMatches),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

  var apiResponce = json.decode(responce.body);

  if(responce.statusCode == 200)
  {
   print("getrecent done");
  }

  return RecentMatchesModel.fromJson(apiResponce);
 }

 String getImage(String playerId){
  return 'https://api2.cricbuzz.com/a/img/v1/i1/c$playerId/i.jpg?p=det&d=hd';
 }
}
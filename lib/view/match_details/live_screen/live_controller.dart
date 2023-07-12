import 'dart:convert';
import 'package:cricbuzzapp/model/paginationmodel.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class LiveController extends GetxController{


  RxBool firstload = false.obs;
  RxList alldata = [].obs;

  Future<dynamic> pagination(String iningId,String timeStamp,String Id) async {
    String apiurl = "http://15.206.70.118:8500/match/$Id/commentary?inning=$iningId&lastTimeStamp=$timeStamp";
    var responce = await http.get(Uri.parse(apiurl),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var result = json.decode(responce.body);
    if (responce.statusCode == 200) {
      // return result;
      print("==============done");
    } else {
      print("============error");
    }
  }





}
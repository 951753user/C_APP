import 'dart:convert';

import 'package:cricbuzzapp/model/homemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController{
  RxBool remind = false.obs;
  RxBool status = false.obs;

  RxBool themeChanger = true.obs;
  RxBool adchange = false.obs;

  RxInt homeAdsCount = 0.obs;


  Future<dynamic> homeapi() async {
    String apiurl = "http://15.206.70.118:8500/home";
    var responce = await http.get(Uri.parse(apiurl),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var result = json.decode(responce.body);
    if (responce.statusCode == 200) {
      // return result;
      debugPrint("==============home screen done");
    } else {
      debugPrint("============error");
    }
    return HomeModel.fromJson(result);
  }

String playerPhoto(String photo){
    return 'https://api2.cricbuzz.com/a/img/v1/i1/c$photo/i.jpg?p=det&d=high';
}

}
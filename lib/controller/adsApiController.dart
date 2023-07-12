import 'dart:convert';

import 'package:cricbuzzapp/model/adsModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdsApiController extends GetxController{
  Future<dynamic> getAdsApi() async {
    String apiurl = "https://unisoftex.com/NB/testadsads.json";
    // String apiurl = "https://unisoftex.com/NB/com.videodownloader.nb.json";
    var responce = await http.get(Uri.parse(apiurl));

    var result = json.decode(responce.body);
    if (responce.statusCode == 200) {
      print("==============done");
    } else {
      print("============error");
    }

    return AdsModel.fromJson(result);
  }
}
import 'dart:convert';

import 'package:cricbuzzapp/model/newsmodel.dart';
import 'package:cricbuzzapp/services/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class NewsController extends GetxController{

  RxString newsLastId = "".obs;
  RxString scrollNewsFirstId = "".obs;
  RxString scrollNewsLastId = "".obs;

  RxBool noMoreData = false.obs;

  RxList moreNews = [].obs;

  RxBool setTime = false.obs;

  String getImage(String photo){
    return 'https://api2.cricbuzz.com/a/img/v1/i1/c$photo/i.jpg?p=det&d=high';
  }


  Future<NewsModel> newsapi() async {
    String apiurl = "http://15.206.70.118:8500/news";
    var responce = await http.get(Uri.parse(apiurl),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var result = json.decode(responce.body);
    if (responce.statusCode == 200) {
      // return result;
      print("==============donene");
    } else {
      print("============error");
    }
    return NewsModel.fromJson(result);
  }


  Future<NewsModel> getMoreNewsApi(String id) async {
    var responce = await http.get(Uri.parse("$baseurl$news?lastId=$id"),headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});

    var result = json.decode(responce.body);
    if (responce.statusCode == 200) {
      // return result;

      NewsModel data =
      NewsModel.fromJson(result);
      for (int i = 0; i < data.storyList!.length; i++) {
          moreNews.add(data.storyList![i]);
      }
      print("==============More News Done");
    } else {
      noMoreData.value = true;
      print("============More News Failed");
    }
    return NewsModel.fromJson(result);
  }

  // Future<dynamic> getCommentaryScrollData(
  //     String id, String inningId, String timeStamp) async {
  //   var responce = await http.get(
  //       Uri.parse(
  //           "$baseurl$match$id$commentary?inning=$inningId&lastTimeStamp=$timeStamp"),
  //       headers: {'x-auth-user': '4485b0bc-d12b-11ed-afa1-0242ac120002'});
  //
  //   var apiResponce = json.decode(responce.body);
  //
  //   if (responce.statusCode == 200) {
  //     // matchesCommentaryData.clear();
  //     CommentaryScrollingModel data =
  //     CommentaryScrollingModel.fromJson(apiResponce);
  //     for (int i = 0; i < data.commentaryList!.length; i++) {
  //       if(i != 0){
  //         matchesCommentaryData.add(data.commentaryList![i]);
  //       }
  //     }
  //   }
  //
  //   return CommentaryScrollingModel.fromJson(apiResponce);
  // }

}
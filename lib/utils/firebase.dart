
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Ads extends GetxController
{

  Stream<QuerySnapshot<Map<String, dynamic>>> readdata() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection("Ads").snapshots();
  }


}
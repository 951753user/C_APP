import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController{
  final pageController = PageController();
  RxInt selectedIndex = 0.obs;
}
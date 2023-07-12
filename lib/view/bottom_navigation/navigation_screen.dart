import 'package:cricbuzzapp/view/bottom_navigation/navigation_controller.dart';
import 'package:cricbuzzapp/view/current_matches/current_matches_screen.dart';
import 'package:cricbuzzapp/view/home_screen/home_screen.dart';
import 'package:cricbuzzapp/view/more_screen/more_screen.dart';
import 'package:cricbuzzapp/view/news%20_screen/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  NavigationController controller = Get.put(NavigationController());

  var screen = [
    HomeScreen(),
    const CurrentMatchesScreen(),
    const NewsScreen(),
    const MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screen[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          unselectedIconTheme: IconThemeData(color: Colors.grey[500]),
          selectedIconTheme: IconThemeData(color: Colors.red[900]),
          unselectedLabelStyle: TextStyle(color: Colors.grey[500]),
          selectedLabelStyle: TextStyle(color: Colors.red[900]),
          fixedColor: Colors.red[900],
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            controller.selectedIndex.value = index;
          },
          currentIndex: controller.selectedIndex.value,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.sports_cricket_outlined), label: 'All Matches'),
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper_sharp), label: 'News'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: 'Setting'),
          ],
        ),
      ),
    );
  }
}

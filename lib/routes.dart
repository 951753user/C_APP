
import 'package:cricbuzzapp/view/bottom_navigation/navigation_screen.dart';
import 'package:cricbuzzapp/view/current_matches/current_matches_screen.dart';
import 'package:cricbuzzapp/view/home_screen/home_screen.dart';
import 'package:cricbuzzapp/view/match_details/match_details.dart';
import 'package:cricbuzzapp/view/more_screen/more_screen.dart';
import 'package:cricbuzzapp/view/news%20_screen/news_screen.dart';
import 'package:cricbuzzapp/view/splash_screen.dart';
import 'package:get/get.dart';

class AppPages{
  AppPages._();

  static String splash = '/';
  static String nav = '/nav';
  static String home = '/home';
  static String matches = '/matches';
  static String news = '/news';
  static String more = '/more';
  // static String matchDetails = '/matchDetails';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen(),),
    GetPage(name: nav, page: () => const NavigationScreen(),),
    GetPage(name: home, page: () => HomeScreen(),),
    GetPage(name: matches, page: () => const CurrentMatchesScreen(),),
    GetPage(name: news, page: () => const NewsScreen(),),
    GetPage(name: more, page: () => const MoreScreen(),),
    // GetPage(name: matchDetails, page: () => const MatchDetailsScreen(),),
  ];
}
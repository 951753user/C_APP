import 'package:internet_connection_checker/internet_connection_checker.dart';

checkConnection() async {
  return await InternetConnectionChecker().hasConnection;
}
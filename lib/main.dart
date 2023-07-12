import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cricbuzzapp/helper/color.dart';
import 'package:cricbuzzapp/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final box = GetStorage();

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {}
FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final service = FlutterBackgroundService();

Future<void> showNotification() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  if (Platform.isAndroid) {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('ipl'),
          visibility: NotificationVisibility.public,
          timeoutAfter: 300,
          ticker: 'ticker');
  // const NotificationDetails notificationDetails =
  //     NotificationDetails(android: androidNotificationDetails);
  // await flutterLocalNotificationsPlugin.show(0, '${message.data['callerName']}',
  //     '${message.data['message']}', notificationDetails,
  //     payload: 'payload');
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  const storage = FlutterSecureStorage();
  List l = [];
  List toRemove = [];
  var androidChannel = const AndroidNotificationDetails(
    'my_foreground',
    'MY BACKGROUND SERVICE',
    playSound: true,
    sound: RawResourceAndroidNotificationSound('ipl_sound'),
    priority: Priority.max,
    importance: Importance.max,
  );
  var platformChannel = NotificationDetails(
      android: androidChannel, iOS: const DarwinNotificationDetails());

  Timer.periodic(const Duration(seconds: 1), (timer) async {
    var comparereminderTime = await storage.read(key: "remind_compare");

    debugPrint(comparereminderTime);
    compareReminderList.refresh();
    if (comparereminderTime != null) {
      // await storage.read(key: "reminder_time").then((value) {
      // if (value != null) {
      l = jsonDecode(comparereminderTime.toString());
    } else {
      l.clear();
      // }
      // });
    }
    final dNow = DateTime.now();
    for (var element in l) {
      element as Map;
      debugPrint(element.keys.join(''));
      var duration = DateTime.now()
          .difference(DateTime.parse(element.keys.join('')))
          .abs();
      if (duration.inMinutes == 30 && duration.inSeconds % 60 == 00) {
        localNotificationsPlugin.show(0, element.values.join(""),
            "Your match will be live soon", platformChannel);
      }

      if (DateTime.parse(element.keys.join('')).isAtSameMomentAs(DateTime(
              dNow.year, dNow.month, dNow.day, dNow.hour, dNow.minute, 0)) &&
          dNow.second == 0) {
        localNotificationsPlugin.show(0, element.values.join(""),
            "Your Match Started Now", platformChannel);
      }
      if (dNow.isAfter(DateTime.parse(element.keys.join('')))) {
        toRemove.add(element);
      }
    }
    l.removeWhere((element) => toRemove.contains(element));
    await storage.write(key: "remind_compare", value: jsonEncode(l));
  });
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // await preferences.reload();
  // final log = preferences.getStringList('log') ?? <String>[];
  // log.add(DateTime.now().toIso8601String());
  // await preferences.setStringList('log', log);
  return true;
}

initializeBackgroundServices() async {
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: false,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

getTime() async {
  const storage = FlutterSecureStorage();

  storage.read(key: "remind_compare").then((value) {
    if (value != null) {
      compareReminderList.value = jsonDecode(value);
      datafind = value;
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await GetStorage.init();

  showNotification();
  localNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestPermission();
  await initializeBackgroundServices();

  // RequestConfiguration configuration = RequestConfiguration(testDeviceIds: testDeviceIds);
  // MobileAds.instance.updateRequestConfiguration(configuration);
  const storage = FlutterSecureStorage();

  getTime();

  Timer.periodic(Duration(seconds: 10), (timer) {
    print(datafind);

    print(compareReminderList);
  });

  runApp(const MyApp());
}

var datafind;
int screenDelayTimer = 2000;

var compareReminderList = [].obs;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 784),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: AppPages.routes,
          initialRoute: AppPages.splash,
          theme: Themes().lighttheme,
          darkTheme: Themes().darktheme,
          themeMode: ThemeMode.light,
        );
      },
    );
  }
}





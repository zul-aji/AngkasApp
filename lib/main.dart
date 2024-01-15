import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_funcs.dart';
import 'ui/home_screen.dart';
import 'local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request notification permissions
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  // Initialize local notif
  await LocalNotifications.init();

  // Set the Hive database location
  await Hive.initFlutter();
  arrBox = await Hive.openBox('arrivalFlightBox');
  depBox = await Hive.openBox('departureFlightBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

import 'package:angkasapp/response/schedule_flights.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'database_helper.dart';
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

  await DatabaseHelper.instance.database;
  await LocalNotifications.init();

  // Set the Hive database location
  await Hive.initFlutter();
  Hive.registerAdapter(ScheduleFlightsAdapter());
  arrBox = await Hive.openBox<ScheduleFlightsAdapter>('arrivalFlightBox');
  depBox = await Hive.openBox<ScheduleFlightsAdapter>('departureFlightBox');

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

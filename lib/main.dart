import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'database_helper.dart';
import 'response/airport_schedule.dart';
import 'ui/home_screen.dart';
import 'util_funcs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;

  await LocalNotifications.init();
  // Get the application documents directory
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  // Set the Hive database location
  await Hive.initFlutter();
  Hive.registerAdapter(AirportScheduleAdapter());
  await BoxCollection.open(
      'ReminderList', {'arrivalFlightBox', 'departureFlightBox'},
      path: appDocumentDirectory.path);
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

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hive/hive.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'response/airport_schedule.dart';

String formatDateTime(String inputDateTime) {
  if (inputDateTime == "[Unavailable]") {
    return inputDateTime;
  }

  DateTime parsedDate = DateTime.parse(inputDateTime);
  DateTime currentDate = DateTime.now();
  DateTime tomorrowDate = currentDate.add(const Duration(days: 1));

  String formattedTime = DateFormat.Hm().format(parsedDate);
  String formattedDate;

  if (parsedDate.year == currentDate.year &&
      parsedDate.month == currentDate.month &&
      parsedDate.day == currentDate.day) {
    formattedDate = 'Today';
  } else if (parsedDate.year == tomorrowDate.year &&
      parsedDate.month == tomorrowDate.month &&
      parsedDate.day == tomorrowDate.day) {
    formattedDate = 'Tomorrow';
  } else {
    formattedDate = DateFormat('dd-MMMM-yyyy').format(parsedDate);
  }

  return '$formattedTime, $formattedDate';
}

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  //on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

  //Initialiase the localnotificiation
  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) => null);
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  //to show simple notif
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel 1', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  //to show periodic notif
  static Future showPeriodicNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel 2', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
        2, title, body, RepeatInterval.everyMinute, notificationDetails);
  }

  //to show scheduled notif
  static Future showScheduledNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    tz.initializeTimeZones();
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel 3', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        3,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);
  }

  //close a specific channel notif
  static Future stopNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  //close all channel notif
  static Future stopAllNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}

// Save list to local storage using Hive
Future<void> saveFlightDetails(FlightDetails flightDetails, bool isArr) async {
  final box = await Hive.openBox<FlightDetails>(
      isArr ? 'arrivalFlightBox' : 'departureFlightBox');
  await box.add(flightDetails);
}

// Retrieve list from local storage using Hive
Future<List<FlightDetails>> getReminders(bool isArr) async {
  final box = await Hive.openBox<FlightDetails>(
      isArr ? 'arrivalFlightBox' : 'departureFlightBox');
  return box.values.toList();
}

// Delete a specific flight detail from local storage using Hive
Future<void> deleteReminder(String flightIata, bool isArr) async {
  final box = await Hive.openBox<FlightDetails>(
      isArr ? 'arrivalFlightBox' : 'departureFlightBox');

  // Find the index of the flight detail with the specified flightIata
  final index = box.values.toList().indexWhere(
      (flight) => flight.flightIata != null && flight.flightIata == flightIata);

  // If found, delete the flight detail at the specified index
  if (index != -1) {
    await box.deleteAt(index);
  }
}

// Delete all flight details from local storage using Hive
Future<void> deleteAllReminder(bool isArr) async {
  final box = await Hive.openBox<FlightDetails>(
      isArr ? 'arrivalFlightBox' : 'departureFlightBox');
  await box.clear();
}

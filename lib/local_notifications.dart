import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

String dateTimetoString(String inputDateTime) {
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

stringToDateTime(String dateString) {
  try {
    // Parse the string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);
    return dateTime;
  } catch (e) {
    // Handle parsing errors
    print('Error converting string to DateTime: $e');
    return "[Unavailable]"; // Return current time if there's an error
  }
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
            onDidReceiveLocalNotification: (id, title, body, payload) {});
    const LinuxInitializationSettings initializationSettingsLinux =
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
        AndroidNotificationDetails('Simple', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
    print('notif made');
  }

  //to show scheduled notif
  static Future showScheduledNotification({
    required String title,
    required String body,
    required String payload,
    required tz.TZDateTime flightTime,
    required int id,
  }) async {
    tz.initializeTimeZones();
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('Schedule', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id, title, body, flightTime, notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);
    print('notif made');
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

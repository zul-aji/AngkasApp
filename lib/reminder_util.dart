import 'package:angkasapp/const.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'response/flight_details.dart';
import 'response/schedule_flights.dart';

late Box arrBox;
late Box depBox;

class DateParse {
  static dateTimetoString(String inputDateTime) {
    if (inputDateTime == "[Unavailable]") {
      return inputDateTime;
    }

    DateTime parsedDate = DateTime.parse(inputDateTime);
    DateTime tomorrowDate = jakartaTime.add(const Duration(days: 1));
    DateTime yesterdayDate = jakartaTime.subtract(const Duration(days: 1));

    String formattedTime = DateFormat.Hm().format(parsedDate);
    String formattedDate;

    if (parsedDate.year == jakartaTime.year &&
        parsedDate.month == jakartaTime.month &&
        parsedDate.day == jakartaTime.day) {
      formattedDate = 'Today';
    } else if (parsedDate.year == tomorrowDate.year &&
        parsedDate.month == tomorrowDate.month &&
        parsedDate.day == tomorrowDate.day) {
      formattedDate = 'Tomorrow';
    } else if (parsedDate.year == yesterdayDate.year &&
        parsedDate.month == yesterdayDate.month &&
        parsedDate.day == yesterdayDate.day) {
      formattedDate = 'Yesterday';
    } else {
      formattedDate = DateFormat('dd-MMMM-yyyy').format(parsedDate);
    }

    return '$formattedTime, $formattedDate';
  }

  static stringToDateTime(String dateString) {
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
}

class LocalNotif {
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

  //to show scheduled notif
  static Future setScheduledNotification({
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

class HiveFuncs {
  static Future<void> saveReminder(
      String flightIata, bool isArr, FlightDetails? flightDetails) async {
    final box = isArr ? arrBox : depBox;

    final details = {'details': flightDetails?.toMap()};

    print(details.toString());
    await box.add(details);
    Fluttertoast.showToast(
      msg: isArr
          ? 'Flight is added to notification list, You will be notified near flight arrival'
          : 'Flight is added to notification list, You will be notified near flight departure',
    );
  }

// Retrieve non-expired flight details from local storage using Hive
  static List<FlightDetails> getReminders(bool isArr) {
    final box = isArr ? arrBox : depBox;

    // Get all entries in the box
    final allEntries = box.values.toList();

    // Map the details and create ScheduleFlights objects
    final flightDetailsList = allEntries
        .map((entry) => FlightDetails.fromMap(entry['details']))
        .toList();

    // Find indices of expired entries
    for (int i = 0; i < flightDetailsList.length; i++) {
      DateTime expirationArrTime = DateParse.stringToDateTime(
          flightDetailsList[i].arrTime ?? "[Unavailable]");
      DateTime expirationDepTime = DateParse.stringToDateTime(
          flightDetailsList[i].depTime ?? "[Unavailable]");
      bool isExpired = isArr
          ? expirationArrTime
              .isBefore(DateTime.now().add(const Duration(minutes: 10)))
          : expirationDepTime
              .isBefore(DateTime.now().add(const Duration(minutes: 10)));
      if (isExpired) {
        deleteReminder(
            flightDetailsList[i].flightIata ?? "[Unavailable]", isArr);
      }
    }

    // Filter out expired entries
    final nonExpiredEntries = flightDetailsList.where((entry) {
      DateTime expirationArrTime =
          DateParse.stringToDateTime(entry.arrTime ?? "[Unavailable]");
      DateTime expirationDepTime =
          DateParse.stringToDateTime(entry.depTime ?? "[Unavailable]");
      return isArr
          ? expirationArrTime
              .isAfter(DateTime.now().add(const Duration(minutes: 10)))
          : expirationDepTime
              .isAfter(DateTime.now().add(const Duration(minutes: 10)));
    }).toList();

    return nonExpiredEntries;
  }

  static bool checkCurrentFlight(String flightIata, bool isArr) {
    final box = isArr ? arrBox : depBox;

    // Get all entries in the box
    final allEntries = box.values.toList();

    // Check if flightIata is present in any of the entries
    return allEntries.any((entry) {
      final details = entry['details'];
      final scheduleFlight = ScheduleFlights.fromMap(details);

      // Assuming flightIata is a property in ScheduleFlights class
      return scheduleFlight.flightIata == flightIata;
    });
  }

// Delete a specific flight detail from local storage using Hive
  static Future<void> deleteReminder(String flightIata, bool isArr) async {
    final box = isArr ? arrBox : depBox;

    // Convert Iterable to List and find the index
    final index = box.values
        .map((entry) => ScheduleFlights.fromMap(entry['details']))
        .toList()
        .indexWhere((flight) =>
            flight.flightIata != null && flight.flightIata == flightIata);

    // If found, delete the flight detail at the specified index
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

// Delete all flight details from local storage using Hive
  static Future<void> deleteAllReminder(bool isArr) async {
    final box = await Hive.openBox<ScheduleFlights>(
        isArr ? 'arrivalFlightBox' : 'departureFlightBox');
    await box.clear();
  }
}

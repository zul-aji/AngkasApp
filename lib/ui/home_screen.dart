import 'package:angkasapp/ui/reminder_list.dart';
import 'package:angkasapp/reminder_util.dart';
import 'package:flutter/material.dart';

import 'find_flight.dart';
import 'flight_schedule.dart';
import 'map_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    listenToNotifications();
    super.initState();
  }

  void listenToNotifications() {
    print("Listening on Notifications");
    LocalNotif.onClickNotification.stream.listen((event) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FlightSchedule()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReminderList())),
              icon: const Icon(Icons.notifications))
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Border radius
                ),
              ),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MapOverlay())),
              child: const Text(
                'Airport Map',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Border radius
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FlightSchedule(),
                ),
              ),
              child: const Text(
                'Flight Schedule',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Border radius
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FindFlight(),
                ),
              ),
              child: const Text(
                'Find Flight',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

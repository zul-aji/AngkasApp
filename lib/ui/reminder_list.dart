import 'package:angkasapp/response/airport_schedule.dart';
import 'package:angkasapp/util_funcs.dart';
import 'package:flutter/material.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({super.key});

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  bool _isLoading = true;
  List<FlightDetails>? arrivalReminderList;
  List<FlightDetails>? departureReminderList;

  void getReminderList() async {
    var _arrivalReminderList = await getReminders(true);
    var _departureReminderList = await getReminders(false);
    setState(() {
      arrivalReminderList = _arrivalReminderList;
      departureReminderList = _departureReminderList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getReminderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[];
        },
        body: ListView.builder(
          itemCount: arrivalReminderList?.length ?? 0,
          itemBuilder: (context, index) {
            var result = arrivalReminderList?[index];
            String flightIata = result?.flightIata ?? "[Unavailable]";
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => boolIsArr
                      ? FlightArrDetails(flightIata: flightIata)
                      : FlightDepDetails(flightIata: flightIata),
                ),
              ),
              child: Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 6.0),
                child: ListTile(
                    title: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          child: Image.network(
                            "https://airlabs.co/img/airline/s/${result?.airlineIata}.png",
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              // This function will be called if the image fails to load
                              return const Icon(
                                Icons.error,
                                color: Colors.red,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          result?.flightIata ?? "[Flight code unavailable]",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    subtitle: boolIsArr
                        ? Text("Arriving in: ${formatDateTime(arrivalTime)}")
                        : Text(
                            "Departing in: ${formatDateTime(departureTime)}"),
                    trailing: Text(result?.status ?? '[Unavailable]')),
              ),
            );
          },
        ),
      ),
    );
  }
}

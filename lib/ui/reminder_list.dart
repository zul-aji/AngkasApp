import 'package:angkasapp/response/airport_schedule.dart';
import 'package:flutter/material.dart';

import '../custom_widgets.dart';
import '../database_helper.dart';
import '../hive_funcs.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({super.key});

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  List<FlightDetails>? arrivalReminderList;
  List<FlightDetails>? departureReminderList;
  late TabController _tabController;

  int arrivalReminderlength = 0;
  int departureReminderLength = 0;
  int selectedIndex = 0;
  bool isArr = true;

  void getReminderList() async {
    var _arrivalReminderList = await getReminders(true);
    var _departureReminderList = await getReminders(false);
    setState(() {
      arrivalReminderList = _arrivalReminderList;
      arrivalReminderlength = _arrivalReminderList.length;
      departureReminderList = _departureReminderList;
      departureReminderLength = _departureReminderList.length;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getReminderList();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
        isArr = selectedIndex == 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios_new_rounded)),
              title: const Text("Reminder List"),
              pinned: true,
              floating: true,
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.cyan,
                labelColor: Colors.cyan,
                unselectedLabelColor: const Color(0xff737373),
                controller: _tabController,
                tabs: const [
                  Tab(
                    child: Center(
                      child: Text(
                        'Arriving',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: Text(
                        'Departing',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              //Arrival
              _isLoading
                  ? const Center(
                      child: Text('Fetching Data...'),
                    )
                  : arrivalReminderlength == 0
                      ? const Center(
                          child: Text("No arrival reminder"),
                        )
                      : ScheduleListView(
                          scheduleList: arrivalReminderList,
                          scheduleLength: arrivalReminderlength,
                          isArr: isArr,
                        ),
              //Departure
              _isLoading
                  ? const Center(
                      child: Text('Fetching Data...'),
                    )
                  : departureReminderLength == 0
                      ? const Center(
                          child: Text("No departure reminder"),
                        )
                      : ScheduleListView(
                          scheduleList: departureReminderList,
                          scheduleLength: departureReminderLength,
                          isArr: isArr,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

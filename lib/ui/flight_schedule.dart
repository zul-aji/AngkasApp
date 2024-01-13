import 'package:flutter/material.dart';

import '../custom_widgets.dart';
import '../response/schedule_flights.dart';
import '../service/airlabs_request.dart';

class FlightSchedule extends StatefulWidget {
  const FlightSchedule({super.key});

  @override
  State<FlightSchedule> createState() => _FlightScheduleState();
}

class _FlightScheduleState extends State<FlightSchedule>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  List<ScheduleFlights>? arrivalList;
  List<ScheduleFlights>? departureList;
  late TabController _tabController;
  int arrivalLength = 0;
  int departureLength = 0;
  int selectedIndex = 0;
  bool isArr = true;

  TextEditingController controllerSearch = TextEditingController();

  void getListSchedule() async {
    var _scheduleList = await API.getArrDep(true);
    setState(() {
      arrivalLength = _scheduleList!.length;
      arrivalList = _scheduleList;
      _isLoading = false;
    });
    _scheduleList = await API.getArrDep(false);
    setState(() {
      departureLength = _scheduleList!.length;
      departureList = _scheduleList;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getListSchedule();
    super.initState();
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
              title: const Text("Flight Schedule"),
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
                        'Arrival',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: Text(
                        'Departure',
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
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              padding: const EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 5.0),
              height: 45.0,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                        flightList: isArr ? arrivalList : departureList,
                        boolIsArr: isArr),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      child: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ), // Replace with your desired icon
                    const SizedBox(
                        width: 8.0), // Adjust the spacing between icon and text
                    const Expanded(
                      child: Text(
                        'Search for Flight code (IATA or ICAO)',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    //Arrival
                    _isLoading
                        ? const Center(
                            child: Text('Fetching Data...'),
                          )
                        : ScheduleListView(
                            scheduleList: arrivalList,
                            scheduleLength: arrivalLength,
                            isArr: isArr,
                          ),
                    //Departure
                    _isLoading
                        ? const Center(
                            child: Text('Fetching Data...'),
                          )
                        : ScheduleListView(
                            scheduleList: departureList,
                            scheduleLength: departureLength,
                            isArr: isArr,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

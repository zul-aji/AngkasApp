import 'package:flutter/material.dart';

import '../util_funcs.dart';
import '../response/airport_schedule.dart';
import '../service/airlabs_request.dart';
import 'flight_arr_details.dart';
import 'flight_dep_details.dart';

class FlightSchedule extends StatefulWidget {
  const FlightSchedule({super.key});

  @override
  State<FlightSchedule> createState() => _FlightScheduleState();
}

class _FlightScheduleState extends State<FlightSchedule>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  List<FlightDetails>? arrivalList;
  List<FlightDetails>? departureList;
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

class ScheduleListView extends StatelessWidget {
  const ScheduleListView({
    super.key,
    required List<FlightDetails>? scheduleList,
    required int scheduleLength,
    required bool isArr,
  })  : _scheduleList = scheduleList,
        _scheduleLength = scheduleLength,
        _isArr = isArr;

  final List<FlightDetails>? _scheduleList;
  final int _scheduleLength;
  final bool _isArr;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _scheduleLength,
      itemBuilder: (context, index) {
        var currentIndex = _scheduleList?[index];
        String flightIata = currentIndex?.flightIata ?? "[Unavailable]";
        String arrivalTime = currentIndex?.arrTime ?? "[Unavailable]";
        String departureTime = currentIndex?.depTime ?? "[Unavailable]";
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _isArr
                  ? FlightArrDetails(flightIata: flightIata)
                  : FlightDepDetails(flightIata: flightIata),
            ),
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6.0),
            child: ListTile(
                title: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.network(
                        "https://airlabs.co/img/airline/s/${currentIndex?.airlineIata}.png",
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
                      currentIndex?.flightIata ?? "[Flight code unavailable]",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                subtitle: _isArr
                    ? Text("Arriving in: ${formatDateTime(arrivalTime)}")
                    : Text("Departing in: ${formatDateTime(departureTime)}"),
                trailing: Text(currentIndex?.status ?? '[Unavailable]')),
          ),
        );
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<FlightDetails>? flightList;
  bool boolIsArr;

  CustomSearchDelegate({
    required this.flightList,
    required this.boolIsArr,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<FlightDetails>? matchQuery = _filterResults();
    return _buildResultListView(matchQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<FlightDetails>? matchQuery = _filterResults();
    return _buildResultListView(matchQuery);
  }

  List<FlightDetails>? _filterResults() {
    List<FlightDetails>? matchQuery = [];
    for (var flight in flightList!) {
      if (_isMatch(flight)) {
        matchQuery.add(flight);
      }
    }
    return matchQuery;
  }

  Widget _buildResultListView(List<FlightDetails>? matchQuery) {
    return ListView.builder(
      itemCount: matchQuery?.length ?? 0,
      itemBuilder: (context, index) {
        var result = matchQuery?[index];
        String flightIata = result?.flightIata ?? "[Unavailable]";
        String arrivalTime = result?.arrTime ?? "[Unavailable]";
        String departureTime = result?.depTime ?? "[Unavailable]";
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
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6.0),
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
                    : Text("Departing in: ${formatDateTime(departureTime)}"),
                trailing: Text(result?.status ?? '[Unavailable]')),
          ),
        );
      },
    );
  }

  bool _isMatch(FlightDetails flight) {
    return (flight.flightIata != null &&
            flight.flightIata!.toLowerCase().contains(query.toLowerCase())) ||
        (flight.flightIcao != null &&
            flight.flightIcao!.toLowerCase().contains(query.toLowerCase())) ||
        (flight.flightNumber != null &&
            flight.flightNumber!.toLowerCase().contains(query.toLowerCase()));
  }
}

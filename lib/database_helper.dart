import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'response/airport_schedule.dart';
import 'util_funcs.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  static const String tableFlightDetails = 'flight_details';
  static const String columnId = 'id';
  static const String columnListType = 'list_type';
  static const String columnExpiredAt = 'expired_at';
  static const String columnAirlineIata = 'airline_iata';
  static const String columnAirlineIcao = 'airline_icao';
  static const String columnFlightIata = 'flight_iata';
  static const String columnFlightIcao = 'flight_icao';
  static const String columnFlightNumber = 'flight_number';
  static const String columnDepIata = 'dep_iata';
  static const String columnDepIcao = 'dep_icao';
  static const String columnDepTerminal = 'dep_terminal';
  static const String columnDepGate = 'dep_gate';
  static const String columnDepTime = 'dep_time';
  static const String columnDepTimeUtc = 'dep_time_utc';
  static const String columnArrIata = 'arr_iata';
  static const String columnArrIcao = 'arr_icao';
  static const String columnArrTerminal = 'arr_terminal';
  static const String columnArrGate = 'arr_gate';
  static const String columnArrBaggage = 'arr_baggage';
  static const String columnArrTime = 'arr_time';
  static const String columnArrTimeUtc = 'arr_time_utc';
  static const String columnCsAirlineIata = 'cs_airline_iata';
  static const String columnCsFlightNumber = 'cs_flight_number';
  static const String columnCsFlightIata = 'cs_flight_iata';
  static const String columnStatus = 'status';
  static const String columnDuration = 'duration';
  static const String columnDelayed = 'delayed';
  static const String columnDepDelayed = 'dep_delayed';
  static const String columnArrDelayed = 'arr_delayed';
  static const String columnAircraftIcao = 'aircraft_icao';
  static const String columnArrTimeTs = 'arr_time_ts';
  static const String columnDepTimeTs = 'dep_time_ts';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'flight_details_database.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableFlightDetails (
        $columnId INTEGER PRIMARY KEY,
        $columnListType TEXT,
        $columnExpiredAt INTEGER,
        $columnAirlineIata TEXT,
        $columnAirlineIcao TEXT,
        $columnFlightIata TEXT,
        $columnFlightIcao TEXT,
        $columnFlightNumber TEXT,
        $columnDepIata TEXT,
        $columnDepIcao TEXT,
        $columnDepTerminal TEXT,
        $columnDepGate TEXT,
        $columnDepTime TEXT,
        $columnDepTimeUtc TEXT,
        $columnArrIata TEXT,
        $columnArrIcao TEXT,
        $columnArrTerminal TEXT,
        $columnArrGate TEXT,
        $columnArrBaggage TEXT,
        $columnArrTime TEXT,
        $columnArrTimeUtc TEXT,
        $columnCsAirlineIata TEXT,
        $columnCsFlightNumber TEXT,
        $columnCsFlightIata TEXT,
        $columnStatus TEXT,
        $columnDuration INTEGER,
        $columnDelayed INTEGER,
        $columnDepDelayed INTEGER,
        $columnArrDelayed INTEGER,
        $columnAircraftIcao TEXT,
        $columnArrTimeTs INTEGER,
        $columnDepTimeTs INTEGER
      );
    ''');
  }

  Future<int> insertFlightDetails(
      String listType, FlightDetails flightDetails) async {
    Database db = await instance.database;
    DateTime dateTime = stringToDateTime(listType == 'arrNotif'
        ? flightDetails.arrTime ?? '[Unavailable]'
        : flightDetails.depTime ?? '[Unavailable]');

    print("data saved");

    return await db.insert(tableFlightDetails, {
      columnListType: listType,
      columnExpiredAt: dateTime.millisecondsSinceEpoch,
      ...flightDetails.toMap(),
    });
  }

  Future<List<FlightDetails>> getFlightDetails(String listType) async {
    Database db = await instance.database;
    final limitTime =
        DateTime.now().add(const Duration(minutes: 10)).millisecondsSinceEpoch;

    await db.delete(
      tableFlightDetails,
      where: '$columnListType = ? AND $columnExpiredAt <= ?',
      whereArgs: [listType, limitTime],
    );

    List<Map<String, dynamic>> maps = await db.query(tableFlightDetails);

    print("data passed");

    return List.generate(maps.length, (i) {
      return FlightDetails.fromMap(maps[i]);
    });
  }
}

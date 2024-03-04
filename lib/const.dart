import 'package:timezone/timezone.dart' as tz;

const String pT1L1 = 'assets/T1_L1.jpg';
const String pT1L2 = 'assets/T1_L2.jpg';
const String pT2L1 = 'assets/T2_L1.jpg';
const String pT2L1r = 'assets/T2_L1_RE.jpg';
const String pT2L2 = 'assets/T2_L2.jpg';
const String pT3LA = 'assets/T3_1_Arrival.jpg';
const String pT3LB = 'assets/T3_2_BoardingLounge.jpg';
const String pT3LC = 'assets/T3_3_CheckInArea.jpg';
const String pT3GPD = 'assets/T3_4_GedungParkir&ExhibitionHallDomestic_M.jpg';
const String pT3GPI =
    'assets/T3_5_GedungParkir&ExhibitionHallInternational.jpg';

const String baseAirlabsURL = "https://airlabs.co/api/v9";
const String apiKey = "76116d05-65b6-4468-a71c-ac1facef1ba6";

class Location {
  final String name;
  final String category;
  final String floorName;
  final String terminalName;
  final String terminalPath;
  final double xMap;
  final double yMap;
  final double xValue;
  final double yValue;

  const Location(this.name, this.category, this.floorName, this.terminalName,
      this.terminalPath, this.xValue, this.yValue, this.xMap, this.yMap);
}

const locList = [
  Location("A1-2", "Gate", "2", "1", pT1L2, 35, 141, 29, 137),
  Location("A3-4", "Gate", "2", "1", pT1L2, 23.5, 151.5, 18.5, 151),
  Location("D1", "Gate", "2", "2", pT2L2, 35, 141, 29, 137)
];

tz.Location jakLoc = tz.getLocation('Asia/Jakarta');
tz.TZDateTime jakartaTime = tz.TZDateTime.now(jakLoc);

import 'package:timezone/timezone.dart' as tz;

class MapConst {
  static const Map<String, String> tMap = {
    'T1L1': 'assets/map/T1_L1.jpg',
    'T1L2': 'assets/map/T1_L2.jpg',
    'T2L1': 'assets/map/T2_L1.jpg',
    'T2L2': 'assets/map/T2_L2.jpg',
    'T3LPD': 'assets/map/T3_GP_DA.jpg',
    'T3LPI': 'assets/map/T3_GP_IA.jpg',
    'T3L1D': 'assets/map/T3_LD_DA.jpg',
    'T3L1I': 'assets/map/T3_LD_IA.jpg',
    'T3L2D': 'assets/map/T3_L1_DA.jpg',
    'T3L2I': 'assets/map/T3_L1_IA.jpg',
    'T3L3': 'assets/map/T3_L2.jpg',
    'T1L1p': 'assets/path/T1_L1.png',
    'T1L2p': 'assets/path/T1_L2.png',
    'T2L1p': 'assets/path/T2_L1.png',
    'T2L2p': 'assets/path/T2_L2.png',
    'T3LPDp': 'assets/path/T3_GP_DA.png',
    'T3LPIp': 'assets/path/T3_GP_IA.png',
    'T3L1Dp': 'assets/path/T3_LD_DA.png',
    'T3L1Ip': 'assets/path/T3_LD_IA.png',
    'T3L2Dp': 'assets/path/T3_L1_DA.png',
    'T3L2Ip': 'assets/path/T3_L1_IA.png',
    'T3L3p': 'assets/path/T3_L2.png',
  };
}

String mapLink(String terminal, String floor) {
  String link = MapConst.tMap['T${terminal}L$floor'] ?? "-";
  return link;
}

String pathLink(String terminal, String floor) {
  String link = MapConst.tMap['T${terminal}L${floor}p'] ?? "-";
  return link;
}

const String baseAirlabsURL = "https://airlabs.co/api/v9";
const String apiKey = "76116d05-65b6-4468-a71c-ac1facef1ba6";

tz.Location jakLoc = tz.getLocation('Asia/Jakarta');
tz.TZDateTime jakartaTime = tz.TZDateTime.now(jakLoc);

class Security {
  final String terminal;
  final int xEnter;
  final int yEnter;
  final String floorEnter;
  final int xExit;
  final int yExit;
  final String floorExit;

  const Security(
    this.terminal,
    this.xEnter,
    this.yEnter,
    this.floorEnter,
    this.xExit,
    this.yExit,
    this.floorExit,
  );
}

class Elevate {
  final int xValue;
  final int yValue;
  final String inFloor;
  final String terminal;
  final int xTo;
  final int yTo;
  final String toFloor;

  const Elevate(
    this.xValue,
    this.yValue,
    this.inFloor,
    this.terminal,
    this.xTo,
    this.yTo,
    this.toFloor,
  );
}

class Location {
  final String name;
  final String category;
  final String terminal;
  final String floor;
  final int xMap;
  final int yMap;
  final int xValue;
  final int yValue;
  final bool public;
  final Security? security;

  const Location(
    this.name,
    this.category,
    this.terminal,
    this.floor,
    this.xValue,
    this.yValue,
    this.xMap,
    this.yMap,
    this.public,
    this.security,
  );
}

const conLoc = [];

const secList = [];

const eleList = [
  //Terminal 2 Floor 1
  Elevate(278, 222, "1", "2", 277, 222, "2"),
  //Terminal 2 Floor 2
  Elevate(277, 222, "2", "2", 278, 222, "1"),
];

const locList = [
  Location("Test", "Baggage Claim", "3", "3", 83, 211, 0, 0, false, null),
  // Gate Terminal 1
  Location("Gate A1/2", "Gate", "1", "2", 45, 142, 40, 140, false, null),
  Location("Gate A3/4", "Gate", "1", "2", 35, 153, 28, 153, false, null),
  Location("Gate A5/6", "Gate", "1", "2", 28, 169, 21, 170, false, null),
  Location("Gate A7/8", "Gate", "1", "2", 29, 184, 25, 189, false, null),
  Location("Gate A9/10", "Gate", "1", "2", 45, 190, 45, 196, false, null),
  Location("Gate A11/12", "Gate", "1", "2", 63, 187, 63, 194, false, null),
  Location("Gate A13/14", "Gate", "1", "2", 78, 180, 80, 186, false, null),
  Location("Gate B1", "Gate", "1", "2", 150, 214, 145, 214, false, null),
  Location("Gate B2", "Gate", "1", "2", 153, 229, 149, 233, false, null),
  Location("Gate B3", "Gate", "1", "2", 162, 243, 157, 247, false, null),
  Location("Gate B4", "Gate", "1", "2", 175, 251, 175, 257, false, null),
  Location("Gate B5", "Gate", "1", "2", 188, 243, 193, 248, false, null),
  Location("Gate B6", "Gate", "1", "2", 197, 229, 201, 233, false, null),
  Location("Gate B7", "Gate", "1", "2", 200, 214, 206, 214, false, null),
  Location("Gate C1", "Gate", "1", "2", 273, 180, 270, 187, false, null),
  Location("Gate C2", "Gate", "1", "2", 288, 187, 287, 193, false, null),
  Location("Gate C3", "Gate", "1", "2", 306, 190, 305, 196, false, null),
  Location("Gate C4", "Gate", "1", "2", 321, 184, 325, 189, false, null),
  Location("Gate C5", "Gate", "1", "2", 323, 169, 328, 169, false, null),
  Location("Gate C6", "Gate", "1", "2", 316, 153, 321, 152, false, null),
  Location("Gate C7", "Gate", "1", "2", 305, 142, 308, 140, false, null),
  // Gate Terminal 1 Arrivals
  Location("Gate A1/2 Arrivals", "Arrival Gate", "1", "1", 37, 215, 34, 219,
      false, null),
  Location("Gate A3/4 Arrivals", "Arrival Gate", "1", "1", 35, 153, 28, 153,
      false, null),
  Location("Gate A5/6 Arrivals", "Arrival Gate", "1", "1", 28, 169, 21, 170,
      false, null),
  Location("Gate A7/8 Arrivals", "Arrival Gate", "1", "1", 29, 184, 25, 189,
      false, null),
  Location("Gate A9/10 Arrivals", "Arrival Gate", "1", "1", 45, 190, 45, 196,
      false, null),
  Location("Gate A11/12 Arrivals", "Arrival Gate", "1", "1", 63, 187, 63, 194,
      false, null),
  Location("Gate A13/14 Arrivals", "Arrival Gate", "1", "1", 78, 180, 80, 186,
      false, null),
  Location("Gate B1 Arrivals", "Arrival Gate", "1", "1", 150, 214, 145, 214,
      false, null),
  Location("Gate B2 Arrivals", "Arrival Gate", "1", "1", 153, 229, 149, 233,
      false, null),
  Location("Gate B3 Arrivals", "Arrival Gate", "1", "1", 162, 243, 157, 247,
      false, null),
  Location("Gate B4 Arrivals", "Arrival Gate", "1", "1", 175, 251, 175, 257,
      false, null),
  Location("Gate B5 Arrivals", "Arrival Gate", "1", "1", 188, 243, 193, 248,
      false, null),
  Location("Gate B6 Arrivals", "Arrival Gate", "1", "1", 197, 229, 201, 233,
      false, null),
  Location("Gate B7 Arrivals", "Arrival Gate", "1", "1", 200, 214, 206, 214,
      false, null),
  Location("Gate C1 Arrivals", "Arrival Gate", "1", "1", 273, 180, 270, 187,
      false, null),
  Location("Gate C2 Arrivals", "Arrival Gate", "1", "1", 288, 187, 287, 193,
      false, null),
  Location("Gate C3 Arrivals", "Arrival Gate", "1", "1", 306, 190, 305, 196,
      false, null),
  Location("Gate C4 Arrivals", "Arrival Gate", "1", "1", 321, 184, 325, 189,
      false, null),
  Location("Gate C5 Arrivals", "Arrival Gate", "1", "1", 323, 169, 328, 169,
      false, null),
  Location("Gate C6 Arrivals", "Arrival Gate", "1", "1", 316, 153, 321, 152,
      false, null),
  Location("Gate C7 Arrivals", "Arrival Gate", "1", "1", 305, 142, 308, 140,
      false, null),
  // Gate Terminal 2
  Location("Gate D1", "Gate", "2", "2", 50, 117, 48, 109, false, null),
  Location("Gate D2", "Gate", "2", "2", 36, 131, 33, 128, false, null),
  Location("Gate D3", "Gate", "2", "2", 27, 150, 22, 149, false, null),
  Location("Gate D4", "Gate", "2", "2", 31, 169, 25, 171, false, null),
  Location("Gate D5", "Gate", "2", "2", 48, 176, 48, 182, false, null),
  Location("Gate D5", "Gate", "2", "2", 48, 176, 48, 182, false, null),
  Location("Gate D5", "Gate", "2", "2", 48, 176, 48, 182, false, null),
  Location("Gate D5", "Gate", "2", "2", 48, 176, 48, 182, false, null),
  Location("Gate D5", "Gate", "2", "2", 48, 176, 48, 182, false, null),
  Location("Gate D6", "Gate", "2", "2", 71, 174, 70, 181, false, null),
  Location("Gate D7", "Gate", "2", "2", 91, 168, 95, 174, false, null),
  Location("Gate E1", "Gate", "2", "2", 143, 196, 135, 196, false, null),
  Location("Gate E2", "Gate", "2", "2", 147, 215, 142, 219, false, null),
  Location("Gate E3", "Gate", "2", "2", 158, 234, 153, 237, false, null),
  Location("Gate E4", "Gate", "2", "2", 175, 244, 175, 251, false, null),
  Location("Gate E5", "Gate", "2", "2", 192, 234, 197, 238, false, null),
  Location("Gate E6", "Gate", "2", "2", 203, 215, 209, 219, false, null),
  Location("Gate E7", "Gate", "2", "2", 208, 196, 215, 196, false, null),
  Location("Gate F1", "Gate", "2", "2", 259, 168, 256, 173, false, null),
  Location("Gate F2", "Gate", "2", "2", 280, 174, 280, 181, false, null),
  Location("Gate F3", "Gate", "2", "2", 302, 176, 303, 181, false, null),
  Location("Gate F4", "Gate", "2", "2", 320, 169, 326, 172, false, null),
  Location("Gate F5", "Gate", "2", "2", 324, 150, 328, 149, false, null),
  Location("Gate F6", "Gate", "2", "2", 314, 131, 317, 128, false, null),
  Location("Gate F7", "Gate", "2", "2", 300, 116, 301, 110, false, null),
  // Baggage Claim
  Location("Baggage Claim Gate A", "Baggage Claim", "1", "1", 90, 187, 87, 185,
      false, null),
  Location("Baggage Claim Gate B", "Baggage Claim", "1", "1", 209, 158, 210,
      152, false, null),
  Location("Baggage Claim Gate C", "Baggage Claim", "1", "1", 307, 234, 312,
      232, false, null),
];

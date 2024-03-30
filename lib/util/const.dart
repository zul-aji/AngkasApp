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
  final String terminal;
  final int xValue;
  final int yValue;
  final String inFloor;
  final int xTo;
  final int yTo;
  final String toFloor;

  const Elevate(
    this.terminal,
    this.xValue,
    this.yValue,
    this.inFloor,
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

List<Security> secList = [
  // Terminal 1 Gate A
  const Security("1", 52, 249, "1", 101, 186, "1"),
  // Terminal 1 Gate B
  const Security("1", 141, 169, "1", 219, 168, "1"),
  // Terminal 1 Gate C
  const Security("1", 255, 185, "1", 305, 247, "1"),
  // Terminal 2 Gate D
  const Security("2", 181, 195, "2", 124, 213, "1"),
  // Terminal 2 Gate E
  const Security("2", 181, 195, "2", 151, 202, "1"),
  // Terminal 2 Gate F
  const Security("2", 281, 219, "2", 231, 211, "1"),
];

final eleList = [
  //Terminal 1 Floor 1
  const Elevate("1", 286, 206, "1", 272, 215, "2"),
  const Elevate("1", 171, 157, "1", 176, 169, "2"),
  const Elevate("1", 64, 215, "1", 84, 219, "2"),

  //Terminal 1 Floor 2
  const Elevate("1", 272, 215, "2", 286, 206, "1"),
  const Elevate("1", 176, 169, "2", 171, 157, "1"),
  const Elevate("1", 84, 219, "2", 64, 215, "1"),

  //Terminal 2 Floor 1
  const Elevate("2", 278, 222, "1", 277, 222, "2"),
  const Elevate("2", 244, 237, "1", 247, 238, "2"),
  const Elevate("2", 225, 223, "1", 225, 221, "2"),
  const Elevate("2", 200, 215, "1", 205, 213, "2"),
  const Elevate("2", 175, 213, "1", 181, 209, "2"),
  const Elevate("2", 180, 180, "1", 181, 175, "2"),
  const Elevate("2", 155, 216, "1", 155, 214, "2"),
  const Elevate("2", 131, 225, "1", 128, 227, "2"),
  const Elevate("2", 110, 245, "1", 113, 240, "2"),
  const Elevate("2", 85, 224, "1", 85, 224, "2"),

  //Terminal 2 Floor 2
  const Elevate("2", 277, 222, "2", 278, 222, "1"),
  const Elevate("2", 247, 238, "2", 244, 237, "1"),
  const Elevate("2", 225, 221, "2", 225, 223, "1"),
  const Elevate("2", 205, 213, "2", 200, 215, "1"),
  const Elevate("2", 181, 209, "2", 175, 213, "1"),
  const Elevate("2", 181, 175, "2", 180, 180, "1"),
  const Elevate("2", 155, 214, "2", 155, 216, "1"),
  const Elevate("2", 128, 227, "2", 131, 225, "1"),
  const Elevate("2", 113, 240, "2", 110, 245, "1"),
  const Elevate("2", 85, 224, "2", 85, 224, "1"),
];

const conLoc = [];

List<Location> locList = [
  Location("Test", "Baggage Claim", "1", "1", 83, 211, 0, 0, false, secList[0]),

  // Gate Terminal 1 Floor 1
  Location("Gate A1/2 Arrivals", "Arrival Gate", "1", "1", 37, 215, 34, 219,
      false, secList[0]),
  Location("Gate A3/4 Arrivals", "Arrival Gate", "1", "1", 28, 204, 23, 205,
      false, secList[0]),
  Location("Gate A5/6 Arrivals", "Arrival Gate", "1", "1", 21, 187, 17, 188,
      false, secList[0]),
  Location("Gate A7/8 Arrivals", "Arrival Gate", "1", "1", 23, 172, 19, 169,
      false, secList[0]),
  Location("Gate A9/10 Arrivals", "Arrival Gate", "1", "1", 36, 169, 37, 163,
      false, secList[0]),
  Location("Gate A11/12 Arrivals", "Arrival Gate", "1", "1", 54, 171, 55, 165,
      false, secList[0]),
  Location("Gate A13/14 Arrivals", "Arrival Gate", "1", "1", 68, 177, 70, 173,
      false, secList[0]),
  Location("Gate B1 Arrivals", "Arrival Gate", "1", "1", 155, 135, 150, 135,
      false, secList[1]),
  Location("Gate B2 Arrivals", "Arrival Gate", "1", "1", 159, 121, 155, 118,
      false, secList[1]),
  Location("Gate B3 Arrivals", "Arrival Gate", "1", "1", 167, 104, 164, 101,
      false, secList[1]),
  Location("Gate B4 Arrivals", "Arrival Gate", "1", "1", 180, 96, 180, 91,
      false, secList[1]),
  Location("Gate B5 Arrivals", "Arrival Gate", "1", "1", 192, 104, 195, 101,
      false, secList[1]),
  Location("Gate B6 Arrivals", "Arrival Gate", "1", "1", 200, 120, 204, 118,
      false, secList[1]),
  Location("Gate B7 Arrivals", "Arrival Gate", "1", "1", 203, 135, 209, 135,
      false, secList[1]),
  Location("Gate C1 Arrivals", "Arrival Gate", "1", "1", 292, 177, 290, 173,
      false, secList[2]),
  Location("Gate C2 Arrivals", "Arrival Gate", "1", "1", 306, 170, 307, 166,
      false, secList[2]),
  Location("Gate C3 Arrivals", "Arrival Gate", "1", "1", 324, 167, 324, 163,
      false, secList[2]),
  Location("Gate C4 Arrivals", "Arrival Gate", "1", "1", 337, 172, 341, 169,
      false, secList[2]),
  Location("Gate C5 Arrivals", "Arrival Gate", "1", "1", 337, 186, 344, 188,
      false, secList[2]),
  Location("Gate C6 Arrivals", "Arrival Gate", "1", "1", 331, 203, 337, 204,
      false, secList[2]),
  Location("Gate C7 Arrivals", "Arrival Gate", "1", "1", 322, 215, 326, 219,
      false, secList[2]),

  // Gate Terminal 1 Floor 2
  Location("Gate A1/2", "Gate", "1", "2", 50, 217, 48, 221, false, secList[0]),
  Location("Gate A3/4", "Gate", "1", "2", 42, 205, 37, 208, false, secList[0]),
  Location("Gate A5/6", "Gate", "1", "2", 35, 189, 30, 191, false, secList[0]),
  Location("Gate A7/8", "Gate", "1", "2", 36, 176, 33, 173, false, secList[0]),
  Location("Gate A9/10", "Gate", "1", "2", 49, 174, 51, 166, false, secList[0]),
  Location(
      "Gate A11/12", "Gate", "1", "2", 67, 175, 69, 168, false, secList[0]),
  Location(
      "Gate A13/14", "Gate", "1", "2", 81, 181, 85, 176, false, secList[0]),
  Location("Gate B1", "Gate", "1", "2", 156, 145, 151, 146, false, secList[1]),
  Location("Gate B2", "Gate", "1", "2", 160, 132, 156, 130, false, secList[1]),
  Location("Gate B3", "Gate", "1", "2", 168, 117, 164, 113, false, secList[1]),
  Location("Gate B4", "Gate", "1", "2", 180, 109, 180, 103, false, secList[1]),
  Location("Gate B5", "Gate", "1", "2", 191, 117, 196, 113, false, secList[1]),
  Location("Gate B6", "Gate", "1", "2", 199, 132, 205, 129, false, secList[1]),
  Location("Gate B7", "Gate", "1", "2", 204, 145, 209, 146, false, secList[1]),
  Location("Gate C1", "Gate", "1", "2", 278, 180, 276, 176, false, secList[2]),
  Location("Gate C2", "Gate", "1", "2", 293, 175, 293, 169, false, secList[2]),
  Location("Gate C3", "Gate", "1", "2", 311, 173, 311, 166, false, secList[2]),
  Location("Gate C4", "Gate", "1", "2", 324, 176, 328, 172, false, secList[2]),
  Location("Gate C5", "Gate", "1", "2", 325, 189, 330, 190, false, secList[2]),
  Location("Gate C6", "Gate", "1", "2", 318, 205, 323, 207, false, secList[2]),
  Location("Gate C7", "Gate", "1", "2", 310, 217, 313, 221, false, secList[2]),

  // Baggage Claim
  Location("Baggage Claim Gate A", "Baggage Claim", "1", "1", 90, 187, 87, 185,
      false, secList[0]),
  Location("Baggage Claim Gate B", "Baggage Claim", "1", "1", 209, 158, 210,
      152, false, secList[1]),
  Location("Baggage Claim Gate C", "Baggage Claim", "1", "1", 307, 234, 312,
      232, false, secList[2]),

  //Drop-Off
  Location("Drop-Off", "Arrival Gate", "1", "1", 322, 215, 326, 219, false,
      secList[2]),

  //SkyTrain
  Location("Skytrain", "Skytrain", "1", "1", 181, 214, 181, 220, true, null),
  Location("Skytrain", "Skytrain", "2", "1", 180, 235, 180, 240, true, null),
  Location("Skytrain", "Skytrain", "3", "3", 180, 238, 180, 244, true, null),

  // Gate Terminal 2 Floor 1
  Location("Gate D1 Arrivals", "Arrival Gate", "2", "1", 55, 242, 50, 250,
      false, secList[3]),
  Location("Gate D2 Arrivals", "Arrival Gate", "2", "1", 42, 228, 35, 232,
      false, secList[3]),
  Location("Gate D3 Arrivals", "Arrival Gate", "2", "1", 33, 208, 25, 212,
      false, secList[3]),
  Location("Gate D4 Arrivals", "Arrival Gate", "2", "1", 37, 191, 31, 187,
      false, secList[3]),
  Location("Gate D5 Arrivals", "Arrival Gate", "2", "1", 53, 185, 54, 175,
      false, secList[3]),
  Location("Gate D6 Arrivals", "Arrival Gate", "2", "1", 76, 187, 77, 177,
      false, secList[3]),
  Location("Gate D7 Arrivals", "Arrival Gate", "2", "1", 94, 192, 100, 184,
      false, secList[3]),
  Location("Gate E1 Arrivals", "Arrival Gate", "2", "1", 148, 164, 140, 163,
      false, secList[4]),
  Location("Gate E2 Arrivals", "Arrival Gate", "2", "1", 153, 145, 147, 142,
      false, secList[4]),
  Location("Gate E3 Arrivals", "Arrival Gate", "2", "1", 164, 128, 159, 123,
      false, secList[4]),
  Location("Gate E4 Arrivals", "Arrival Gate", "2", "1", 180, 117, 180, 109,
      false, secList[4]),
  Location("Gate E5 Arrivals", "Arrival Gate", "2", "1", 196, 128, 202, 123,
      false, secList[4]),
  Location("Gate E6 Arrivals", "Arrival Gate", "2", "1", 208, 144, 215, 140,
      false, secList[4]),
  Location("Gate E7 Arrivals", "Arrival Gate", "2", "1", 212, 164, 220, 164,
      false, secList[4]),
  Location("Gate F1 Arrivals", "Arrival Gate", "2", "1", 265, 192, 261, 185,
      false, secList[5]),
  Location("Gate F2 Arrivals", "Arrival Gate", "2", "1", 286, 185, 283, 178,
      false, secList[5]),
  Location("Gate F3 Arrivals", "Arrival Gate", "2", "1", 306, 185, 306, 176,
      false, secList[5]),
  Location("Gate F4 Arrivals", "Arrival Gate", "2", "1", 324, 191, 331, 186,
      false, secList[5]),
  Location("Gate F5 Arrivals", "Arrival Gate", "2", "1", 326, 210, 335, 212,
      false, secList[5]),
  Location("Gate F6 Arrivals", "Arrival Gate", "2", "1", 318, 228, 325, 232,
      false, secList[5]),
  Location("Gate F7 Arrivals", "Arrival Gate", "2", "1", 305, 243, 310, 249,
      false, secList[5]),

  //Gate Terminal 2 Floor 2
  Location("Gate D1", "Gate", "2", "2", 56, 241, 54, 250, false, secList[3]),
  Location("Gate D2", "Gate", "2", "2", 42, 227, 37, 232, false, secList[3]),
  Location("Gate D3", "Gate", "2", "2", 32, 207, 28, 212, false, secList[3]),
  Location("Gate D4", "Gate", "2", "2", 37, 190, 30, 187, false, secList[3]),
  Location("Gate D5", "Gate", "2", "2", 53, 182, 53, 175, false, secList[3]),
  Location("Gate D6", "Gate", "2", "2", 76, 185, 76, 178, false, secList[3]),
  Location("Gate D7", "Gate", "2", "2", 95, 191, 100, 184, false, secList[3]),
  Location("Gate E1", "Gate", "2", "2", 148, 162, 140, 163, false, secList[4]),
  Location("Gate E2", "Gate", "2", "2", 153, 143, 147, 140, false, secList[4]),
  Location("Gate E3", "Gate", "2", "2", 164, 124, 159, 121, false, secList[4]),
  Location("Gate E4", "Gate", "2", "2", 181, 116, 181, 109, false, secList[4]),
  Location("Gate E5", "Gate", "2", "2", 197, 124, 202, 121, false, secList[4]),
  Location("Gate E6", "Gate", "2", "2", 208, 143, 215, 140, false, secList[4]),
  Location("Gate E7", "Gate", "2", "2", 213, 162, 220, 162, false, secList[4]),
  Location("Gate F1", "Gate", "2", "2", 265, 191, 262, 185, false, secList[5]),
  Location("Gate F2", "Gate", "2", "2", 286, 185, 286, 178, false, secList[5]),
  Location("Gate F3", "Gate", "2", "2", 309, 183, 309, 176, false, secList[5]),
  Location("Gate F4", "Gate", "2", "2", 326, 189, 332, 187, false, secList[5]),
  Location("Gate F5", "Gate", "2", "2", 329, 207, 335, 212, false, secList[5]),
  Location("Gate F6", "Gate", "2", "2", 320, 227, 325, 232, false, secList[5]),
  Location("Gate F7", "Gate", "2", "2", 306, 242, 308, 249, false, secList[5]),
];

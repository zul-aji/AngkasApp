import 'package:timezone/timezone.dart' as tz;

const String pT1L1 = 'assets/T1_L1.jpg';
const String pT1L2 = 'assets/T1_L2.jpg';
const String pT2L1 = 'assets/T2_L1.jpg';
const String pT2L2 = 'assets/T2_L2.jpg';
const String pT3LA = 'assets/T3_1_Arrival.jpg';
const String pT3LB = 'assets/T3_2_BoardingLounge.jpg';
const String pT3LC = 'assets/T3_3_CheckInArea.jpg';
const String pT3GPD = 'assets/T3_4_GedungParkir&ExhibitionHallDomestic_M.jpg';
const String pT3GPI =
    'assets/T3_5_GedungParkir&ExhibitionHallInternational.jpg';
const String pT2L2p = 'assets/T2_L2_Path.png';

const String baseAirlabsURL = "https://airlabs.co/api/v9";
const String apiKey = "76116d05-65b6-4468-a71c-ac1facef1ba6";

tz.Location jakLoc = tz.getLocation('Asia/Jakarta');
tz.TZDateTime jakartaTime = tz.TZDateTime.now(jakLoc);

class Location {
  final String name;
  final String category;
  final String floor;
  final String terminal;
  final String terminalPath;
  final double xMap;
  final double yMap;
  final double xValue;
  final double yValue;

  const Location(
    this.name,
    this.category,
    this.floor,
    this.terminal,
    this.terminalPath,
    this.xValue,
    this.yValue,
    this.xMap,
    this.yMap,
  );
}

const conLoc = [];

const locList = [
  Location("Test", "Gate", "2", "2", pT2L2, 50.4, 117.1, 0, 0),
  Location("A1", "Gate", "2", "1", pT1L2, 45.6, 142.5, 40.1, 140.3),
  Location("A2", "Gate", "2", "1", pT1L2, 35, 153, 28.3, 153.4),
  Location("A3", "Gate", "2", "1", pT1L2, 28.3, 169, 21.5, 170.2),
  Location("A4", "Gate", "2", "1", pT1L2, 29.5, 184.5, 25.4, 189.6),
  Location("A5", "Gate", "2", "1", pT1L2, 45.4, 190.0, 45, 196.5),
  Location("A6", "Gate", "2", "1", pT1L2, 63, 187.4, 63.4, 194.1),
  Location("A7", "Gate", "2", "1", pT1L2, 78.7, 180, 80, 186.5),
  Location("B1", "Gate", "2", "1", pT1L2, 150.8, 214, 145, 214),
  Location("B2", "Gate", "2", "1", pT1L2, 153.2, 229, 149, 233.8),
  Location("B3", "Gate", "2", "1", pT1L2, 162.1, 243.5, 157.9, 247.1),
  Location("B4", "Gate", "2", "1", pT1L2, 175.8, 251.1, 175.8, 257),
  Location("B5", "Gate", "2", "1", pT1L2, 188.9, 243.6, 193.2, 248.8),
  Location("B6", "Gate", "2", "1", pT1L2, 197.7, 229, 201.2, 233.8),
  Location("B7", "Gate", "2", "1", pT1L2, 200.6, 214, 206.8, 214),
  Location("C1", "Gate", "2", "1", pT1L2, 273.3, 180.3, 270.2, 187.3),
  Location("C2", "Gate", "2", "1", pT1L2, 288.2, 187.3, 287.4, 193.7),
  Location("C3", "Gate", "2", "1", pT1L2, 306.1, 190.6, 305.3, 196.8),
  Location("C4", "Gate", "2", "1", pT1L2, 321.6, 184.6, 325.5, 189.4),
  Location("C5", "Gate", "2", "1", pT1L2, 323, 169.3, 328.2, 169.5),
  Location("C6", "Gate", "2", "1", pT1L2, 316.4, 153.3, 321.2, 152.7),
  Location("C7", "Gate", "2", "1", pT1L2, 305.5, 142.8, 308.1, 140.4),
  Location("D1", "Gate", "2", "2", pT2L2, 50.4, 117.1, 48.7, 109.8),
  Location("D2", "Gate", "2", "2", pT2L2, 36.8, 131.3, 33.1, 128.4),
  Location("D3", "Gate", "2", "2", pT2L2, 27.3, 150.7, 22.5, 149),
  Location("D4", "Gate", "2", "2", pT2L2, 31.4, 169, 25.1, 171.9),
  Location("D5", "Gate", "2", "2", pT2L2, 48.6, 176.5, 48.2, 182.8),
  Location("D6", "Gate", "2", "2", pT2L2, 71.5, 174.7, 70.8, 181.7),
  Location("D7", "Gate", "2", "2", pT2L2, 91.5, 168, 95.5, 174.5),
  Location("E1", "Gate", "2", "2", pT2L2, 143, 196.2, 135.4, 196.2),
  Location("E2", "Gate", "2", "2", pT2L2, 147.3, 215.3, 142.5, 219.2),
  Location("E3", "Gate", "2", "2", pT2L2, 158.6, 234.7, 153.7, 237.8),
  Location("E4", "Gate", "2", "2", pT2L2, 175.7, 244.4, 175.7, 251),
  Location("E5", "Gate", "2", "2", pT2L2, 192.8, 234.7, 197.5, 238.4),
  Location("E6", "Gate", "2", "2", pT2L2, 203.8, 215.3, 209.3, 219.1),
  Location("E7", "Gate", "2", "2", pT2L2, 208, 196.2, 215.4, 196.8),
  Location("F1", "Gate", "2", "2", pT2L2, 259.6, 168.3, 256.9, 173.8),
  Location("F2", "Gate", "2", "2", pT2L2, 280, 174.9, 280, 181),
  Location("F3", "Gate", "2", "2", pT2L2, 302.7, 176.8, 303.1, 181.6),
  Location("F4", "Gate", "2", "2", pT2L2, 320, 169, 326.4, 172.3),
  Location("F5", "Gate", "2", "2", pT2L2, 324, 150.6, 328.7, 149.1),
  Location("F6", "Gate", "2", "2", pT2L2, 314.3, 131.4, 317.6, 128.8),
  Location("F7", "Gate", "2", "2", pT2L2, 300.3, 116.5, 301.9, 110.6),
];

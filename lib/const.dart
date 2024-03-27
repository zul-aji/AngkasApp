import 'package:timezone/timezone.dart' as tz;

const String T1L1 = 'assets/map/T1_L1.jpg';
const String T1L2 = 'assets/map/T1_L2.jpg';
const String T2L1 = 'assets/map/T2_L1.jpg';
const String T2L2 = 'assets/map/T2_L2.jpg';
const String T3GPD = 'assets/map/T3_GP_DA.jpg';
const String T3GPI = 'assets/map/T3_GP_IA.jpg';
const String T3LDD = 'assets/map/T3_LD_DA.jpg';
const String T3LDI = 'assets/map/T3_LD_IA.jpg';
const String T3L1D = 'assets/map/T3_L1_DA.jpg';
const String T3L1I = 'assets/map/T3_L1_IA.jpg';
const String T3L2 = 'assets/map/T3_L2.jpg';

const String T1L1p = 'assets/path/T1_L1.png';
const String T1L2p = 'assets/path/T1_L2.png';
const String T2L1p = 'assets/path/T2_L1.png';
const String T2L2p = 'assets/path/T2_L2.png';
const String T3GPDp = 'assets/path/T3_GP_DA.png';
const String T3GPIp = 'assets/path/T3_GP_IA.png';
const String T3LDDp = 'assets/path/T3_LD_DA.png';
const String T3LDIp = 'assets/path/T3_LD_IA.png';
const String T3L1Dp = 'assets/path/T3_L1_DA.png';
const String T3L1Ip = 'assets/path/T3_L1_IA.png';
const String T3L2p = 'assets/path/T3_L2.png';

const String baseAirlabsURL = "https://airlabs.co/api/v9";
const String apiKey = "76116d05-65b6-4468-a71c-ac1facef1ba6";

tz.Location jakLoc = tz.getLocation('Asia/Jakarta');
tz.TZDateTime jakartaTime = tz.TZDateTime.now(jakLoc);

class Location {
  final String name;
  final String category;
  final String floor;
  final String terminal;
  final String tMap;
  final String tPath;
  final double xMap;
  final double yMap;
  final double xValue;
  final double yValue;

  const Location(
    this.name,
    this.category,
    this.floor,
    this.terminal,
    this.tMap,
    this.tPath,
    this.xValue,
    this.yValue,
    this.xMap,
    this.yMap,
  );
}

const conLoc = [];

const locList = [
  Location("Test", "Gate", "2", "2", T2L2, T2L2p, 50.4, 117.1, 0, 0),
  Location("Gate A1", "Gate", "2", "1", T1L2, T1L2p, 45.6, 142.5, 40.1, 140.3),
  Location("Gate A2", "Gate", "2", "1", T1L2, T1L2p, 35, 153, 28.3, 153.4),
  Location("Gate A3", "Gate", "2", "1", T1L2, T1L2p, 28.3, 169, 21.5, 170.2),
  Location("Gate A4", "Gate", "2", "1", T1L2, T1L2p, 29.5, 184.5, 25.4, 189.6),
  Location("Gate A5", "Gate", "2", "1", T1L2, T1L2p, 45.4, 190.0, 45, 196.5),
  Location("Gate A6", "Gate", "2", "1", T1L2, T1L2p, 63, 187.4, 63.4, 194.1),
  Location("Gate A7", "Gate", "2", "1", T1L2, T1L2p, 78.7, 180, 80, 186.5),
  Location("Gate B1", "Gate", "2", "1", T1L2, T1L2p, 150.8, 214, 145, 214),
  Location("Gate B2", "Gate", "2", "1", T1L2, T1L2p, 153.2, 229, 149, 233.8),
  Location(
      "Gate B3", "Gate", "2", "1", T1L2, T1L2p, 162.1, 243.5, 157.9, 247.1),
  Location("Gate B4", "Gate", "2", "1", T1L2, T1L2p, 175.8, 251.1, 175.8, 257),
  Location(
      "Gate B5", "Gate", "2", "1", T1L2, T1L2p, 188.9, 243.6, 193.2, 248.8),
  Location("Gate B6", "Gate", "2", "1", T1L2, T1L2p, 197.7, 229, 201.2, 233.8),
  Location("Gate B7", "Gate", "2", "1", T1L2, T1L2p, 200.6, 214, 206.8, 214),
  Location(
      "Gate C1", "Gate", "2", "1", T1L2, T1L2p, 273.3, 180.3, 270.2, 187.3),
  Location(
      "Gate C2", "Gate", "2", "1", T1L2, T1L2p, 288.2, 187.3, 287.4, 193.7),
  Location(
      "Gate C3", "Gate", "2", "1", T1L2, T1L2p, 306.1, 190.6, 305.3, 196.8),
  Location(
      "Gate C4", "Gate", "2", "1", T1L2, T1L2p, 321.6, 184.6, 325.5, 189.4),
  Location("Gate C5", "Gate", "2", "1", T1L2, T1L2p, 323, 169.3, 328.2, 169.5),
  Location(
      "Gate C6", "Gate", "2", "1", T1L2, T1L2p, 316.4, 153.3, 321.2, 152.7),
  Location(
      "Gate C7", "Gate", "2", "1", T1L2, T1L2p, 305.5, 142.8, 308.1, 140.4),
  Location("Gate D1", "Gate", "2", "2", T2L2, T2L2p, 50.4, 117.1, 48.7, 109.8),
  Location("Gate D2", "Gate", "2", "2", T2L2, T2L2p, 36.8, 131.3, 33.1, 128.4),
  Location("Gate D3", "Gate", "2", "2", T2L2, T2L2p, 27.3, 150.7, 22.5, 149),
  Location("Gate D4", "Gate", "2", "2", T2L2, T2L2p, 31.4, 169, 25.1, 171.9),
  Location("Gate D5", "Gate", "2", "2", T2L2, T2L2p, 48.6, 176.5, 48.2, 182.8),
  Location("Gate D5", "Gate", "2", "2", T2L2, T2L2p, 48.6, 176.5, 48.2, 182.8),
  Location("Gate D5", "Gate", "2", "2", T2L2, T2L2p, 48.6, 176.5, 48.2, 182.8),
  Location("Gate D5", "Gate", "2", "2", T2L2, T2L2p, 48.6, 176.5, 48.2, 182.8),
  Location("Gate D5", "Gate", "2", "2", T2L2, T2L2p, 48.6, 176.5, 48.2, 182.8),
  Location("Gate D6", "Gate", "2", "2", T2L2, T2L2p, 71.5, 174.7, 70.8, 181.7),
  Location("Gate D7", "Gate", "2", "2", T2L2, T2L2p, 91.5, 168, 95.5, 174.5),
  Location("Gate E1", "Gate", "2", "2", T2L2, T2L2p, 143, 196.2, 135.4, 196.2),
  Location(
      "Gate E2", "Gate", "2", "2", T2L2, T2L2p, 147.3, 215.3, 142.5, 219.2),
  Location(
      "Gate E3", "Gate", "2", "2", T2L2, T2L2p, 158.6, 234.7, 153.7, 237.8),
  Location("Gate E4", "Gate", "2", "2", T2L2, T2L2p, 175.7, 244.4, 175.7, 251),
  Location(
      "Gate E5", "Gate", "2", "2", T2L2, T2L2p, 192.8, 234.7, 197.5, 238.4),
  Location(
      "Gate E6", "Gate", "2", "2", T2L2, T2L2p, 203.8, 215.3, 209.3, 219.1),
  Location("Gate E7", "Gate", "2", "2", T2L2, T2L2p, 208, 196.2, 215.4, 196.8),
  Location(
      "Gate F1", "Gate", "2", "2", T2L2, T2L2p, 259.6, 168.3, 256.9, 173.8),
  Location("Gate F2", "Gate", "2", "2", T2L2, T2L2p, 280, 174.9, 280, 181),
  Location(
      "Gate F3", "Gate", "2", "2", T2L2, T2L2p, 302.7, 176.8, 303.1, 181.6),
  Location("Gate F4", "Gate", "2", "2", T2L2, T2L2p, 320, 169, 326.4, 172.3),
  Location("Gate F5", "Gate", "2", "2", T2L2, T2L2p, 324, 150.6, 328.7, 149.1),
  Location(
      "Gate F6", "Gate", "2", "2", T2L2, T2L2p, 314.3, 131.4, 317.6, 128.8),
  Location(
      "Gate F7", "Gate", "2", "2", T2L2, T2L2p, 300.3, 116.5, 301.9, 110.6),
];

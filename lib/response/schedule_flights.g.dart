// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_flights.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleFlightsAdapter extends TypeAdapter<ScheduleFlights> {
  @override
  final int typeId = 0;

  @override
  ScheduleFlights read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleFlights(
      airlineIata: fields[0] as String?,
      airlineIcao: fields[1] as String?,
      flightIata: fields[2] as String?,
      flightIcao: fields[3] as String?,
      flightNumber: fields[4] as String?,
      depIata: fields[5] as String?,
      depIcao: fields[6] as String?,
      depTerminal: fields[7] as String?,
      depGate: fields[8] as String?,
      depTime: fields[9] as String?,
      depTimeUtc: fields[10] as String?,
      arrIata: fields[11] as String?,
      arrIcao: fields[12] as String?,
      arrTerminal: fields[13] as String?,
      arrGate: fields[14] as String?,
      arrBaggage: fields[15] as String?,
      arrTime: fields[16] as String?,
      arrTimeUtc: fields[17] as String?,
      csAirlineIata: fields[18] as String?,
      csFlightNumber: fields[19] as String?,
      csFlightIata: fields[20] as String?,
      status: fields[21] as String?,
      duration: fields[22] as int?,
      delayed: fields[23] as int?,
      depDelayed: fields[24] as int?,
      arrDelayed: fields[25] as int?,
      aircraftIcao: fields[26] as String?,
      arrTimeTs: fields[27] as int?,
      depTimeTs: fields[28] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleFlights obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj.airlineIata)
      ..writeByte(1)
      ..write(obj.airlineIcao)
      ..writeByte(2)
      ..write(obj.flightIata)
      ..writeByte(3)
      ..write(obj.flightIcao)
      ..writeByte(4)
      ..write(obj.flightNumber)
      ..writeByte(5)
      ..write(obj.depIata)
      ..writeByte(6)
      ..write(obj.depIcao)
      ..writeByte(7)
      ..write(obj.depTerminal)
      ..writeByte(8)
      ..write(obj.depGate)
      ..writeByte(9)
      ..write(obj.depTime)
      ..writeByte(10)
      ..write(obj.depTimeUtc)
      ..writeByte(11)
      ..write(obj.arrIata)
      ..writeByte(12)
      ..write(obj.arrIcao)
      ..writeByte(13)
      ..write(obj.arrTerminal)
      ..writeByte(14)
      ..write(obj.arrGate)
      ..writeByte(15)
      ..write(obj.arrBaggage)
      ..writeByte(16)
      ..write(obj.arrTime)
      ..writeByte(17)
      ..write(obj.arrTimeUtc)
      ..writeByte(18)
      ..write(obj.csAirlineIata)
      ..writeByte(19)
      ..write(obj.csFlightNumber)
      ..writeByte(20)
      ..write(obj.csFlightIata)
      ..writeByte(21)
      ..write(obj.status)
      ..writeByte(22)
      ..write(obj.duration)
      ..writeByte(23)
      ..write(obj.delayed)
      ..writeByte(24)
      ..write(obj.depDelayed)
      ..writeByte(25)
      ..write(obj.arrDelayed)
      ..writeByte(26)
      ..write(obj.aircraftIcao)
      ..writeByte(27)
      ..write(obj.arrTimeTs)
      ..writeByte(28)
      ..write(obj.depTimeTs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleFlightsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

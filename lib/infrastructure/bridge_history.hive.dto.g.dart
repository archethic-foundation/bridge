// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_history.hive.dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BridgeHistoryHiveDTOAdapter extends TypeAdapter<_$_BridgeHistoryHiveDTO> {
  @override
  final int typeId = 2;

  @override
  _$_BridgeHistoryHiveDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_BridgeHistoryHiveDTO(
      bridgeList: (fields[0] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          ?.toList(),
    );
  }

  @override
  void write(BinaryWriter writer, _$_BridgeHistoryHiveDTO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.bridgeList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BridgeHistoryHiveDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

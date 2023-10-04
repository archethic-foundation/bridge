// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_history.hive.dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BridgeHistoryHiveDTOImplAdapter
    extends TypeAdapter<_$BridgeHistoryHiveDTOImpl> {
  @override
  final int typeId = 2;

  @override
  _$BridgeHistoryHiveDTOImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$BridgeHistoryHiveDTOImpl(
      bridgeList: (fields[0] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          ?.toList(),
    );
  }

  @override
  void write(BinaryWriter writer, _$BridgeHistoryHiveDTOImpl obj) {
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
      other is BridgeHistoryHiveDTOImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

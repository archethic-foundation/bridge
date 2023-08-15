// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BridgeAdapter extends TypeAdapter<_$_Bridge> {
  @override
  final int typeId = 0;

  @override
  _$_Bridge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Bridge(
      blockchainChainIdFrom: fields[0] as int?,
      blockchainChainIdTo: fields[1] as int?,
      tokenToBridge: fields[2] as BridgeToken?,
      tokenToBridgeAmount: fields[3] as double?,
      targetAddress: fields[4] as String?,
      timestampExec: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Bridge obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.blockchainChainIdFrom)
      ..writeByte(1)
      ..write(obj.blockchainChainIdTo)
      ..writeByte(2)
      ..write(obj.tokenToBridge)
      ..writeByte(3)
      ..write(obj.tokenToBridgeAmount)
      ..writeByte(4)
      ..write(obj.targetAddress)
      ..writeByte(5)
      ..write(obj.timestampExec);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BridgeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

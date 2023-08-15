// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BridgeTokenAdapter extends TypeAdapter<_$_BridgeToken> {
  @override
  final int typeId = 1;

  @override
  _$_BridgeToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_BridgeToken(
      name: fields[0] as String?,
      tokenAddress: fields[1] as String?,
      symbol: fields[2] as String?,
      targetTokenName: fields[3] as String?,
      targetTokenSymbol: fields[4] as String?,
      poolAddressFrom: fields[5] as String?,
      poolAddressTo: fields[6] as String?,
      type: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$_BridgeToken obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.tokenAddress)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.targetTokenName)
      ..writeByte(4)
      ..write(obj.targetTokenSymbol)
      ..writeByte(5)
      ..write(obj.poolAddressFrom)
      ..writeByte(6)
      ..write(obj.poolAddressTo)
      ..writeByte(7)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BridgeTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

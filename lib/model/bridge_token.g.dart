// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BridgeToken _$$_BridgeTokenFromJson(Map<String, dynamic> json) =>
    _$_BridgeToken(
      name: json['name'] as String? ?? '',
      tokenAddress: json['tokenAddress'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      targetTokenName: json['targetTokenName'] as String? ?? '',
      targetTokenSymbol: json['targetTokenSymbol'] as String? ?? '',
      poolAddressFrom: json['poolAddressFrom'] as String? ?? '',
      poolAddressTo: json['poolAddressTo'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$$_BridgeTokenToJson(_$_BridgeToken instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tokenAddress': instance.tokenAddress,
      'symbol': instance.symbol,
      'targetTokenName': instance.targetTokenName,
      'targetTokenSymbol': instance.targetTokenSymbol,
      'poolAddressFrom': instance.poolAddressFrom,
      'poolAddressTo': instance.poolAddressTo,
      'type': instance.type,
    };

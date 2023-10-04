// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BridgeTokenImpl _$$BridgeTokenImplFromJson(Map<String, dynamic> json) =>
    _$BridgeTokenImpl(
      name: json['name'] as String? ?? '',
      tokenAddressSource: json['tokenAddressSource'] as String? ?? '',
      tokenAddressTarget: json['tokenAddressTarget'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      targetTokenName: json['targetTokenName'] as String? ?? '',
      targetTokenSymbol: json['targetTokenSymbol'] as String? ?? '',
      poolAddressFrom: json['poolAddressFrom'] as String? ?? '',
      poolAddressTo: json['poolAddressTo'] as String? ?? '',
      type: json['type'] as String? ?? '',
    );

Map<String, dynamic> _$$BridgeTokenImplToJson(_$BridgeTokenImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tokenAddressSource': instance.tokenAddressSource,
      'tokenAddressTarget': instance.tokenAddressTarget,
      'symbol': instance.symbol,
      'targetTokenName': instance.targetTokenName,
      'targetTokenSymbol': instance.targetTokenSymbol,
      'poolAddressFrom': instance.poolAddressFrom,
      'poolAddressTo': instance.poolAddressTo,
      'type': instance.type,
    };

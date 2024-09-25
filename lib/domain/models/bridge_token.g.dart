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
      typeSource: json['typeSource'] as String? ?? '',
      typeTarget: json['typeTarget'] as String? ?? '',
      ucoV1Address: json['ucoV1Address'] as String? ?? '',
      contractToMintAndBurn: json['contractToMintAndBurn'] as bool?,
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
      'typeSource': instance.typeSource,
      'typeTarget': instance.typeTarget,
      'ucoV1Address': instance.ucoV1Address,
      'contractToMintAndBurn': instance.contractToMintAndBurn,
    };

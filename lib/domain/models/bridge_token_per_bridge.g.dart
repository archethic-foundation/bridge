// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_token_per_bridge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BridgeTokensPerBridgeImpl _$$BridgeTokensPerBridgeImplFromJson(
        Map<String, dynamic> json) =>
    _$BridgeTokensPerBridgeImpl(
      tokens: (json['tokens'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => TokenData.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$$BridgeTokensPerBridgeImplToJson(
        _$BridgeTokensPerBridgeImpl instance) =>
    <String, dynamic>{
      'tokens': instance.tokens,
    };

_$TokenDataImpl _$$TokenDataImplFromJson(Map<String, dynamic> json) =>
    _$TokenDataImpl(
      name: json['name'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      targetTokenName: json['targetTokenName'] as String? ?? '',
      targetTokenSymbol: json['targetTokenSymbol'] as String? ?? '',
      poolAddressFrom: json['poolAddressFrom'] as String? ?? '',
      poolAddressTo: json['poolAddressTo'] as String? ?? '',
      type: json['type'] as String? ?? '',
      tokenAddressSource: json['tokenAddressSource'] as String? ?? '',
      tokenAddressTarget: json['tokenAddressTarget'] as String? ?? '',
    );

Map<String, dynamic> _$$TokenDataImplToJson(_$TokenDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'targetTokenName': instance.targetTokenName,
      'targetTokenSymbol': instance.targetTokenSymbol,
      'poolAddressFrom': instance.poolAddressFrom,
      'poolAddressTo': instance.poolAddressTo,
      'type': instance.type,
      'tokenAddressSource': instance.tokenAddressSource,
      'tokenAddressTarget': instance.tokenAddressTarget,
    };

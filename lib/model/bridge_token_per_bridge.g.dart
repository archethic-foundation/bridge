// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_token_per_bridge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BridgeTokensPerBridge _$$_BridgeTokensPerBridgeFromJson(
        Map<String, dynamic> json) =>
    _$_BridgeTokensPerBridge(
      tokens: (json['tokens'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => TokenData.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$$_BridgeTokensPerBridgeToJson(
        _$_BridgeTokensPerBridge instance) =>
    <String, dynamic>{
      'tokens': instance.tokens,
    };

_$_TokenData _$$_TokenDataFromJson(Map<String, dynamic> json) => _$_TokenData(
      name: json['name'] as String? ?? '',
      symbol: json['symbol'] as String? ?? '',
      targetTokenName: json['targetTokenName'] as String? ?? '',
      targetTokenSymbol: json['targetTokenSymbol'] as String? ?? '',
    );

Map<String, dynamic> _$$_TokenDataToJson(_$_TokenData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'targetTokenName': instance.targetTokenName,
      'targetTokenSymbol': instance.targetTokenSymbol,
    };

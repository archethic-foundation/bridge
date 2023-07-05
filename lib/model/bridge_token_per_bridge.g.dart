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
                .map((e) => SymbolData.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$$_BridgeTokensPerBridgeToJson(
        _$_BridgeTokensPerBridge instance) =>
    <String, dynamic>{
      'tokens': instance.tokens,
    };

_$_SymbolData _$$_SymbolDataFromJson(Map<String, dynamic> json) =>
    _$_SymbolData(
      symbol: json['symbol'] as String? ?? '',
    );

Map<String, dynamic> _$$_SymbolDataToJson(_$_SymbolData instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
    };

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bridge_token_per_bridge.freezed.dart';
part 'bridge_token_per_bridge.g.dart';

@freezed
class BridgeTokensPerBridge with _$BridgeTokensPerBridge {
  const factory BridgeTokensPerBridge({
    Map<String, List<SymbolData>>? tokens,
  }) = _BridgeTokensPerBridge;

  factory BridgeTokensPerBridge.fromJson(Map<String, dynamic> json) =>
      _$BridgeTokensPerBridgeFromJson(json);
}

@freezed
class SymbolData with _$SymbolData {
  factory SymbolData({
    @Default('') String symbol,
  }) = _SymbolData;

  factory SymbolData.fromJson(Map<String, dynamic> json) =>
      _$SymbolDataFromJson(json);
}

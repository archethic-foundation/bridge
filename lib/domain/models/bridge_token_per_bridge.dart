/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bridge_token_per_bridge.freezed.dart';
part 'bridge_token_per_bridge.g.dart';

@freezed
class BridgeTokensPerBridge with _$BridgeTokensPerBridge {
  const factory BridgeTokensPerBridge({
    Map<String, List<TokenData>>? tokens,
  }) = _BridgeTokensPerBridge;

  factory BridgeTokensPerBridge.fromJson(Map<String, dynamic> json) =>
      _$BridgeTokensPerBridgeFromJson(json);
}

@freezed
class TokenData with _$TokenData {
  factory TokenData({
    @Default('') String name,
    @Default('') String symbol,
    @Default('') String targetTokenName,
    @Default('') String targetTokenSymbol,
    @Default('') String poolAddressFrom,
    @Default('') String poolAddressTo,
    @Default('') String typeSource,
    @Default('') String typeTarget,
    @Default('') String tokenAddressSource,
    @Default('') String tokenAddressTarget,
    @Default('') String ucoV1Address,
    bool? contractToMintAndBurn,
  }) = _TokenData;

  factory TokenData.fromJson(Map<String, dynamic> json) =>
      _$TokenDataFromJson(json);
}

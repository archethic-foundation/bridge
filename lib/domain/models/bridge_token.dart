/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bridge_token.freezed.dart';
part 'bridge_token.g.dart';

class BridgeTokenJsonConverter
    extends JsonConverter<BridgeToken, Map<String, dynamic>> {
  const BridgeTokenJsonConverter();

  @override
  BridgeToken fromJson(Map<String, dynamic> json) {
    return BridgeToken.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(BridgeToken object) => object.toJson();
}

@freezed
class BridgeToken with _$BridgeToken {
  const factory BridgeToken({
    @Default('') String name,
    @Default('') String tokenAddress,
    @Default('') String symbol,
    @Default('') String targetTokenName,
    @Default('') String targetTokenSymbol,
    @Default('') String poolAddressFrom,
    @Default('') String poolAddressTo,
    @Default('') String type,
  }) = _BridgeToken;

  factory BridgeToken.fromJson(Map<String, dynamic> json) =>
      _$BridgeTokenFromJson(json);
}

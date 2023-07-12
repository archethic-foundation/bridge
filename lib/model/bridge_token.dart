/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bridge_token.freezed.dart';

@freezed
class BridgeToken with _$BridgeToken {
  const factory BridgeToken({
    @Default('') String name,
    @Default('') String tokenAddress,
    @Default('') String symbol,
    @Default('') String targetTokenName,
    @Default('') String targetTokenSymbol,
    @Default('') String poolAddress,
    @Default('') String type,
  }) = _BridgeToken;
}

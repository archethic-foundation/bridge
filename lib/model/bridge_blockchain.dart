/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bridge_blockchain.freezed.dart';
part 'bridge_blockchain.g.dart';

@freezed
class BridgeBlockchain with _$BridgeBlockchain {
  const factory BridgeBlockchain({
    @Default('') String name,
    @Default(0) int chainId,
    @Default('') String env,
    @Default('') String icon,
    @Default('') String urlExplorer,
    @Default('') String providerEndpoint,
  }) = _BridgeBlockchain;

  factory BridgeBlockchain.fromJson(Map<String, dynamic> json) =>
      _$BridgeBlockchainFromJson(json);
}

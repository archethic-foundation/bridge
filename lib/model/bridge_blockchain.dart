/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bridge_blockchain.freezed.dart';
part 'bridge_blockchain.g.dart';

class BridgeBlockchainJsonConverter
    extends JsonConverter<BridgeBlockchain, Map<String, dynamic>> {
  const BridgeBlockchainJsonConverter();

  @override
  BridgeBlockchain fromJson(Map<String, dynamic> json) {
    return BridgeBlockchain.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(BridgeBlockchain object) => object.toJson();
}

@freezed
class BridgeBlockchain with _$BridgeBlockchain {
  const factory BridgeBlockchain({
    @Default('') String name,
    @Default(0) int chainId,
    @Default('') String env,
    @Default('') String icon,
    @Default('') String urlExplorer,
    @Default('') String providerEndpoint,
    String? htlcAddress,
  }) = _BridgeBlockchain;

  const BridgeBlockchain._();

  factory BridgeBlockchain.fromJson(Map<String, dynamic> json) =>
      _$BridgeBlockchainFromJson(json);

  bool get isArchethic => chainId < 0;
}

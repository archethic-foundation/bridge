/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_blockchain_environment.dart';
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

class BridgeBlockchainEnvironmentJsonConverter
    extends JsonConverter<BridgeBlockchainEnvironment, String> {
  const BridgeBlockchainEnvironmentJsonConverter();

  @override
  BridgeBlockchainEnvironment fromJson(String json) {
    return BridgeBlockchainEnvironment.byName(json);
  }

  @override
  String toJson(BridgeBlockchainEnvironment object) => object.name;
}

@freezed
class BridgeBlockchain with _$BridgeBlockchain {
  const factory BridgeBlockchain({
    @Default('') String name,
    @Default(0) int chainId,
    @Default(BridgeBlockchainEnvironment.mainnet)
    @BridgeBlockchainEnvironmentJsonConverter()
    BridgeBlockchainEnvironment env,
    @Default('') String icon,
    @Default('') String urlExplorerAddress,
    @Default('') String urlExplorerTransaction,
    @Default('') String urlExplorerChain,
    @Default('') String explorerApi,
    @Default('') String providerEndpoint,
    @Default(false) bool isArchethic,
    @Default('') String nativeCurrency,
    String? htlcAddress,
    String? archethicFactoryAddress,
  }) = _BridgeBlockchain;

  const BridgeBlockchain._();

  factory BridgeBlockchain.fromJson(Map<String, dynamic> json) =>
      _$BridgeBlockchainFromJson(json);
}

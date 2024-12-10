/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/bridge_blockchain_environment.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

mixin BlockchainSelectionMixin {
  Future<BridgeBlockchainEnvironment?> get selectedArchethicEnvironment async {
    try {
      final archethicDAppClient =
          await aedappfm.sl.getAsync<awc.ArchethicDAppClient>();
      final archethicEndpoint =
          await archethicDAppClient.getEndpoint().valueOrNull;

      if (archethicEndpoint == null) {
        return null;
      }

      return switch (archethicEndpoint.endpointUrl) {
        kArchethicEndPointMainnet => BridgeBlockchainEnvironment.mainnet,
        kArchethicEndPointTestnet => BridgeBlockchainEnvironment.testnet,
        _ => BridgeBlockchainEnvironment.devnet
      };
    } catch (e) {
      return null;
    }
  }
}

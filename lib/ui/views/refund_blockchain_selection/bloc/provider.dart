/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/bridge_blockchain_environment.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund_blockchain_selection/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class BlockchainSelectionFormNotifier
    extends _$BlockchainSelectionFormNotifier {
  @override
  Future<RefundBlockchainSelectionFormState> build() async {
    var isTestnetSelected = ref.watch(
      refundFormNotifierProvider.select((bridge) => bridge.isTestnetSelected),
    );

    var isTestnetIncludedComponentDisplayed = true;
    BridgeBlockchainEnvironment? archethicEnvironment;
    try {
      final archethicDAppClient =
          await aedappfm.sl.getAsync<awc.ArchethicDAppClient>();

      final endpointResponse = await archethicDAppClient.getEndpoint();

      await endpointResponse.when(
        failure: (failure) {},
        success: (result) async {
          isTestnetIncludedComponentDisplayed = false;

          switch (result.endpointUrl) {
            case kArchethicEndPointMainnet:
              isTestnetSelected = false;
              archethicEnvironment = BridgeBlockchainEnvironment.mainnet;
              break;
            case kArchethicEndPointTestnet:
              isTestnetSelected = true;
              archethicEnvironment = BridgeBlockchainEnvironment.testnet;
            default:
              isTestnetSelected = true;
              archethicEnvironment = BridgeBlockchainEnvironment.devnet;
              break;
          }
        },
      );
      // ignore: empty_catches
    } catch (e) {}
    return RefundBlockchainSelectionFormState(
      testnetIncluded: isTestnetSelected,
      archethicEnvironment: archethicEnvironment,
      isTestnetIncludedComponentDisplayed: isTestnetIncludedComponentDisplayed,
    );
  }

  Future<void> setTestnetIncluded(
    bool testnetIncluded,
  ) async {
    final lState = await future;

    state = AsyncData(
      lState.copyWith(
        testnetIncluded: testnetIncluded,
      ),
    );
  }
}

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_blockchain_environment.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge_blockchain_selection/bloc/state.dart';
import 'package:aebridge/util/blockchain_selection_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class BlockchainSelectionFormNotifier extends _$BlockchainSelectionFormNotifier
    with BlockchainSelectionMixin {
  @override
  Future<BridgeBlockchainSelectionFormState> build() async {
    final archethicEnvironment = await selectedArchethicEnvironment;
    if (archethicEnvironment == null) {
      final isTestnetSelected = ref.watch(
        bridgeFormNotifierProvider.select((bridge) => bridge.isTestnetSelected),
      );

      return BridgeBlockchainSelectionFormState(
        testnetIncluded: isTestnetSelected,
        archethicEnvironment: archethicEnvironment,
        isTestnetIncludedComponentDisplayed: true,
      );
    }

    return BridgeBlockchainSelectionFormState(
      testnetIncluded:
          archethicEnvironment == BridgeBlockchainEnvironment.mainnet,
      archethicEnvironment: archethicEnvironment,
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

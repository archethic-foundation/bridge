/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_blockchain_environment.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund_blockchain_selection/bloc/state.dart';
import 'package:aebridge/util/blockchain_selection_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class BlockchainSelectionFormNotifier extends _$BlockchainSelectionFormNotifier
    with BlockchainSelectionMixin {
  @override
  Future<RefundBlockchainSelectionFormState> build() async {
    final archethicEnvironment = await selectedArchethicEnvironment;
    if (archethicEnvironment == null) {
      final isTestnetSelected = ref.watch(
        refundFormNotifierProvider.select((bridge) => bridge.isTestnetSelected),
      );

      return RefundBlockchainSelectionFormState(
        testnetIncluded: isTestnetSelected,
        archethicEnvironment: archethicEnvironment,
        isTestnetIncludedComponentDisplayed: true,
      );
    }

    return RefundBlockchainSelectionFormState(
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

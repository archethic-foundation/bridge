/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge_blockchain_selection/bloc/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _blockchainSelectionFormProvider = NotifierProvider.autoDispose<
    BlockchainSelectionFormNotifier, BridgeBlockchainSelectionFormState>(
  () {
    return BlockchainSelectionFormNotifier();
  },
  name: 'BlockchainSelectionFormNotifierProvider',
);

class BlockchainSelectionFormNotifier
    extends AutoDisposeNotifier<BridgeBlockchainSelectionFormState> {
  BlockchainSelectionFormNotifier();

  @override
  BridgeBlockchainSelectionFormState build() {
    final isTestnetSelected = ref.watch(
      bridgeFormNotifierProvider.select((bridge) => bridge.isTestnetSelected),
    );
    return BridgeBlockchainSelectionFormState(
      testnetIncluded: isTestnetSelected,
    );
  }

  void setTestnetIncluded(
    bool testnetIncluded,
  ) {
    state = state.copyWith(
      testnetIncluded: testnetIncluded,
    );
  }
}

abstract class BlockchainSelectionFormProvider {
  static final blockchainSelectionForm = _blockchainSelectionFormProvider;
}

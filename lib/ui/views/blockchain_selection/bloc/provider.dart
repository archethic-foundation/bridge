/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/blockchain_selection/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _blockchainSelectionFormProvider = NotifierProvider.autoDispose<
    BlockchainSelectionFormNotifier, BlockchainSelectionFormState>(
  () {
    return BlockchainSelectionFormNotifier();
  },
  name: 'BlockchainSelectionFormNotifierProvider',
);

class BlockchainSelectionFormNotifier
    extends AutoDisposeNotifier<BlockchainSelectionFormState> {
  BlockchainSelectionFormNotifier();

  @override
  BlockchainSelectionFormState build() {
    final isTestnetSelected = ref.watch(
      bridgeFormNotifierProvider.select((bridge) => bridge.isTestnetSelected),
    );
    return BlockchainSelectionFormState(
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

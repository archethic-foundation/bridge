/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/ui/views/blockchain_selection/bloc/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _blockchainSelectionFormProvider = NotifierProvider.autoDispose<
    BlockchainSelectionFormNotifier, BlockchainSelectionFormState>(
  () {
    return BlockchainSelectionFormNotifier();
  },
);

class BlockchainSelectionFormNotifier
    extends AutoDisposeNotifier<BlockchainSelectionFormState> {
  BlockchainSelectionFormNotifier();

  @override
  BlockchainSelectionFormState build() => const BlockchainSelectionFormState();

  void setTestnetIncluded(
    bool testnetIncluded,
  ) {
    state = state.copyWith(
      testnetIncluded: testnetIncluded,
    );
    ref.invalidate(
      BridgeBlockchainsProviders.getBlockchainsList,
    );
  }

  void setForceChoiceTestnetIncluded(
    bool forceChoiceTestnetIncluded,
  ) {
    state = state.copyWith(
      forceChoiceTestnetIncluded: forceChoiceTestnetIncluded,
    );
    ref.invalidate(
      BridgeBlockchainsProviders.getBlockchainsList,
    );
  }
}

abstract class BlockchainSelectionFormProvider {
  static final blockchainSelectionForm = _blockchainSelectionFormProvider;
}

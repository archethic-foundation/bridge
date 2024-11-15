/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund_blockchain_selection/bloc/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _blockchainSelectionFormProvider = NotifierProvider.autoDispose<
    BlockchainSelectionFormNotifier, RefundBlockchainSelectionFormState>(
  () {
    return BlockchainSelectionFormNotifier();
  },
  name: 'BlockchainSelectionFormNotifierProvider',
);

class BlockchainSelectionFormNotifier
    extends AutoDisposeNotifier<RefundBlockchainSelectionFormState> {
  BlockchainSelectionFormNotifier();

  @override
  RefundBlockchainSelectionFormState build() {
    final isTestnetSelected = ref.watch(
      refundFormNotifierProvider.select((refund) => refund.isTestnetSelected),
    );
    return RefundBlockchainSelectionFormState(
      isTestnetSelected: isTestnetSelected,
    );
  }

  void setTestnetIncluded(
    bool isTestnetSelected,
  ) {
    state = state.copyWith(
      isTestnetSelected: isTestnetSelected,
    );
  }
}

abstract class BlockchainSelectionFormProvider {
  static final blockchainSelectionForm = _blockchainSelectionFormProvider;
}

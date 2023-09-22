/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/ui/views/local_history/bloc/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _localHistoryFormProvider = NotifierProvider.autoDispose<
    LocalHistoryFormNotifier, LocalHistoryFormState>(
  () {
    return LocalHistoryFormNotifier();
  },
);

class LocalHistoryFormNotifier
    extends AutoDisposeNotifier<LocalHistoryFormState> {
  LocalHistoryFormNotifier();

  @override
  LocalHistoryFormState build() => const LocalHistoryFormState();

  void setProcessCompletedIncluded(
    bool processCompletedIncluded,
  ) {
    state = state.copyWith(
      processCompletedIncluded: processCompletedIncluded,
    );
    ref.invalidate(
      BridgeHistoryProviders.fetchBridgesList,
    );
  }
}

abstract class LocalHistoryFormProvider {
  static final localHistoryForm = _localHistoryFormProvider;
}

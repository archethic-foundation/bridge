/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_history.dart';
import 'package:aebridge/ui/views/local_history/bloc/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
class LocalHistoryFormNotifier extends _$LocalHistoryFormNotifier {
  @override
  LocalHistoryFormState build() => const LocalHistoryFormState();

  void setProcessCompletedIncluded(
    bool processCompletedIncluded,
  ) {
    state = state.copyWith(
      processCompletedIncluded: processCompletedIncluded,
    );
    ref.invalidate(
      fetchBridgesListProvider,
    );
  }

  void setFilterPeriodStart(DateTime filterPeriodStart) {
    state = state.copyWith(filterPeriodStart: filterPeriodStart);
    ref.invalidate(
      fetchBridgesListProvider,
    );
  }

  void setFilterPeriodEnd(DateTime filterPeriodEnd) {
    state = state.copyWith(filterPeriodEnd: filterPeriodEnd);
    ref.invalidate(
      fetchBridgesListProvider,
    );
  }
}

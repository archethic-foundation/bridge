/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class LocalHistoryFormState with _$LocalHistoryFormState {
  const factory LocalHistoryFormState({
    @Default(false) bool processCompletedIncluded,
    DateTime? filterPeriodStart,
    DateTime? filterPeriodEnd,
  }) = _LocalHistoryFormState;
  const LocalHistoryFormState._();
}

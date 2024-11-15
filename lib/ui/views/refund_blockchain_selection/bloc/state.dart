/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class RefundBlockchainSelectionFormState
    with _$RefundBlockchainSelectionFormState {
  const factory RefundBlockchainSelectionFormState({
    @Default(false) bool isTestnetSelected,
  }) = _RefundBlockchainSelectionFormState;
  const RefundBlockchainSelectionFormState._();
}

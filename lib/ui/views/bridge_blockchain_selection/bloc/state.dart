/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class BridgeBlockchainSelectionFormState
    with _$BridgeBlockchainSelectionFormState {
  const factory BridgeBlockchainSelectionFormState({
    @Default(false) bool testnetIncluded,
  }) = _BridgeBlockchainSelectionFormState;
  const BridgeBlockchainSelectionFormState._();
}

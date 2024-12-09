/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_blockchain_environment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class BridgeBlockchainSelectionFormState
    with _$BridgeBlockchainSelectionFormState {
  const factory BridgeBlockchainSelectionFormState({
    @Default(false) bool isTestnetIncludedComponentDisplayed,
    @Default(false) bool testnetIncluded,
    BridgeBlockchainEnvironment? archethicEnvironment,
  }) = _BridgeBlockchainSelectionFormState;
  const BridgeBlockchainSelectionFormState._();
}

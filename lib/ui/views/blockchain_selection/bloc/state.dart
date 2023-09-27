/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class BlockchainSelectionFormState with _$BlockchainSelectionFormState {
  const factory BlockchainSelectionFormState({
    @Default(true) bool testnetIncluded,
  }) = _BlockchainSelectionFormState;
  const BlockchainSelectionFormState._();
}

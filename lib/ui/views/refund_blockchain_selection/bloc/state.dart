import 'package:aebridge/domain/models/bridge_blockchain_environment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class RefundBlockchainSelectionFormState
    with _$RefundBlockchainSelectionFormState {
  const factory RefundBlockchainSelectionFormState({
    @Default(false) bool isTestnetIncludedComponentDisplayed,
    @Default(false) bool testnetIncluded,
    BridgeBlockchainEnvironment? archethicEnvironment,
  }) = _RefundBlockchainSelectionFormState;
  const RefundBlockchainSelectionFormState._();
}

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:aebridge/model/bridge_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum BridgeProcessStep { form, confirmation }

enum WaitForWalletConfirmation { evm, archethic }

@freezed
class BridgeFormState with _$BridgeFormState {
  const factory BridgeFormState({
    @Default(BridgeProcessStep.form) BridgeProcessStep bridgeProcessStep,
    BridgeBlockchain? blockchainFrom,
    BridgeBlockchain? blockchainTo,
    BridgeToken? tokenToBridge,
    @Default(0) double tokenToBridgeAmount,
    @Default('') String targetAddress,
    @Default(0) double tokenToBridgeAmountFiat,
    @Default(0.0) double networkFees,
    @Default(0.0) double networkFeesFiat,
    @Default(0) double tokenToBridgeBalance,
    @Default('') String errorText,
    @Default(false) bool isTransferInProgress,
    WaitForWalletConfirmation? waitForWalletConfirmation,
    @Default(0) int currentStep,
    @Default(false) bool changeDirectionInProgress,
  }) = _BridgeFormState;
  const BridgeFormState._();

  bool get isControlsOk => errorText == '';

  bool get canBridge => isControlsOk;
}

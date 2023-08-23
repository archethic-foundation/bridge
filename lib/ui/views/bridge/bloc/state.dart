/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:aebridge/model/bridge_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';
part 'state.g.dart';

enum BridgeProcessStep { form, confirmation }

enum WaitForWalletConfirmation { evm, archethic }

@freezed
class BridgeFormState with _$BridgeFormState {
  const factory BridgeFormState({
    @Default(BridgeProcessStep.form) BridgeProcessStep bridgeProcessStep,
    @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainFrom,
    @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainTo,
    @BridgeTokenJsonConverter() BridgeToken? tokenToBridge,
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
    int? timestampExec,
  }) = _BridgeFormState;
  const BridgeFormState._();

  factory BridgeFormState.fromJson(Map<String, dynamic> json) =>
      _$BridgeFormStateFromJson(json);

  bool get isControlsOk => errorText == '';

  bool get canBridge => isControlsOk;
}

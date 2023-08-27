/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/oracle/state.dart';
import 'package:aebridge/domain/models/failures.dart';
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
    @Default(0.0) double networkFees,
    @Default(0) double tokenToBridgeBalance,
    @FailureJsonConverter() Failure? failure,
    @Default(false) bool isTransferInProgress,
    WaitForWalletConfirmation? waitForWalletConfirmation,
    @Default(0) int currentStep,
    @Default(false) bool changeDirectionInProgress,
    int? timestampExec,
    @ArchethicOracleUCOJsonConverter() ArchethicOracleUCO? archethicOracleUCO,
  }) = _BridgeFormState;
  const BridgeFormState._();

  factory BridgeFormState.fromJson(Map<String, dynamic> json) =>
      _$BridgeFormStateFromJson(json);

  bool get isControlsOk => failure == null;

  bool get canBridge => isControlsOk;
}

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/oracle/state.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';
part 'state.g.dart';

enum BridgeProcessStep { form, confirmation }

enum WaitForWalletConfirmation { evm, archethic }

@freezed
class BridgeFormState with _$BridgeFormState {
  const factory BridgeFormState({
    @Default(false) bool resumeProcess,
    @Default(BridgeProcessStep.form) BridgeProcessStep bridgeProcessStep,
    @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainFrom,
    @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainTo,
    @BridgeTokenJsonConverter() BridgeToken? tokenToBridge,
    @Default(0) double tokenToBridgeAmount,
    @Default('') String targetAddress,
    @Default(0) double tokenToBridgeBalance,
    @Default(0) double tokenBridgedBalance,
    @FailureJsonConverter() Failure? failure,
    @Default(false) bool isTransferInProgress,
    WaitForWalletConfirmation? waitForWalletConfirmation,
    @Default(0) int currentStep,
    @Default(false) bool changeDirectionInProgress,
    int? timestampExec,
    @ArchethicOracleUCOJsonConverter() ArchethicOracleUCO? archethicOracleUCO,
    String? htlcAEAddress,
    String? htlcEVMAddress,
    List<int>? secret,
    @Default(0.0) double safetyModuleFeesRate,
    @Default('') String safetyModuleFeesAddress,
    @Default(0.0) double archethicProtocolFeesRate,
    @Default('') String archethicProtocolFeesAddress,
    @Default(0.0) double archethicTransactionFees,
  }) = _BridgeFormState;
  const BridgeFormState._();

  factory BridgeFormState.fromJson(Map<String, dynamic> json) =>
      _$BridgeFormStateFromJson(json);

  String get feesSymbol => tokenToBridge!.symbol;
  double get safetyModuleFees =>
      safetyModuleFeesRate * tokenToBridgeAmount / 100;
  String get safetyModuleSymbol {
    if (tokenToBridge == null || tokenToBridge!.symbol.isEmpty) {
      return '';
    }
    return tokenToBridge!.symbol;
  }

  double get archethicProtocolFees =>
      archethicProtocolFeesRate *
      (tokenToBridgeAmount - safetyModuleFees) /
      100;
  String get archethicProtocolSymbol {
    if (tokenToBridge == null || tokenToBridge!.targetTokenSymbol.isEmpty) {
      return '';
    }
    return tokenToBridge!.targetTokenSymbol;
  }

  double get globalFees => safetyModuleFees + archethicProtocolFees;
  double get tokenToBridgeReceived => tokenToBridgeAmount - globalFees;

  bool get isControlsOk => failure == null;
}

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';
part 'state.g.dart';

enum WalletConfirmation { evm, archethic }

@freezed
class BridgeFormState with _$BridgeFormState {
  const factory BridgeFormState({
    @Default(false) bool resumeProcess,
    @Default(ProcessStep.form) ProcessStep processStep,
    @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainFrom,
    @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainTo,
    @BridgeTokenJsonConverter() BridgeToken? tokenToBridge,
    @Default(0) double tokenToBridgeAmount,
    @Default('') String targetAddress,
    @Default(0) double tokenToBridgeBalance,
    @Default(0) double tokenBridgedBalance,
    @Default(0) double poolTargetBalance,
    @Default(false) bool poolTargetMintAndBurn,
    @Default(8) int tokenToBridgeDecimals,
    @Default(8) int tokenBridgedDecimals,
    @FailureJsonConverter() Failure? failure,
    @Default(false) bool isTransferInProgress,
    WalletConfirmation? walletConfirmation,
    @Default(false) bool bridgeOk,
    @Default(0) int currentStep,
    @Default(false) bool changeDirectionInProgress,
    int? timestampExec,
    @ArchethicOracleUCOJsonConverter() ArchethicOracleUCO? archethicOracleUCO,
    String? htlcAEAddress,
    String? htlcEVMAddress,
    String? htlcEVMTxAddress,
    String? processCurrentAccountAddressEVM,
    String? processCurrentAccountAddressAE,
    List<int>? secret,
    @Default(0.0) double archethicProtocolFeesRate,
    @Default('') String archethicProtocolFeesAddress,
    @Default(0.0) double archethicTransactionFees,
    @Default(0.0) double feesEstimatedUCO,
    @Default(false) bool messageMaxHalfUCO,
    @Default(false) bool controlInProgress,
    DateTime? consentDateTime,
    @Default(false) bool requestTooLong,
    @Default(0) double ucoV1Balance,
    @Default(false) bool chainIdUpdated,
    @Default(false) bool accountUpdated,
  }) = _BridgeFormState;
  const BridgeFormState._();

  factory BridgeFormState.fromJson(Map<String, dynamic> json) =>
      _$BridgeFormStateFromJson(json);

  String get feesSymbol => tokenToBridge!.symbol;

  double get archethicProtocolFees =>
      archethicProtocolFeesRate * tokenToBridgeAmount / 100;
  String get archethicProtocolSymbol {
    if (tokenToBridge == null || tokenToBridge!.targetTokenSymbol.isEmpty) {
      return '';
    }
    return tokenToBridge!.targetTokenSymbol;
  }

  double get tokenToBridgeReceived =>
      tokenToBridgeAmount - archethicProtocolFees;

  bool get isControlsOk =>
      failure == null &&
      targetAddress.isNotEmpty &&
      tokenToBridgeAmount > 0 &&
      controlInProgress == false;
}

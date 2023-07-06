/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:aebridge/model/bridge_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class BridgeFormState with _$BridgeFormState {
  const factory BridgeFormState({
    @Default(0) int step,
    @Default('') String stepError,
    BridgeBlockchain? blockchainFrom,
    BridgeBlockchain? blockchainTo,
    BridgeToken? tokenToBridge,
    @Default(0) double tokenToBridgeAmount,
    @Default('') String targetAddress,
    @Default(0) double tokenToBridgeAmountFiat,
    @Default(0.0) double networkFees,
    @Default(0.0) double networkFeesFiat,
    @Default(0) double tokenToBridgeBalance,
    @Default(false) bool? controlInProgress,
    @Default('') String errorText,
  }) = _BridgeFormState;
  const BridgeFormState._();

  bool get isControlsOk => errorText == '';

  bool get canBridge => isControlsOk;
}

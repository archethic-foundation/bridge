import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum WalletConfirmationRefund { evm }

enum ProcessRefund { chargeable, signed }

@freezed
class RefundFormState with _$RefundFormState {
  const factory RefundFormState({
    @Default('') String htlcAddressFilled,
    String? htlcAddressAE,
    String? htlcAddressEVM,
    String? refundTxAddress,
    int? chainId,
    bool? isAlreadyRefunded,
    bool? isAlreadyWithdrawn,
    @Default(false) refundOk,
    @Default(false) refundInProgress,
    bool? addressOk,
    int? htlcDateLock,
    @Default(0) double amount,
    @Default('') String amountCurrency,
    @Default(0) double fee,
    @Default(false) htlcCanRefund,
    WalletConfirmationRefund? walletConfirmation,
    ProcessRefund? processRefund,
    bool? isERC20,
    BridgeWallet? evmWallet,
    @FailureJsonConverter() Failure? failure,
  }) = _RefundFormState;
  const RefundFormState._();

  bool get isControlsOk =>
      failure == null &&
      htlcAddressFilled.isNotEmpty &&
      addressOk != null &&
      addressOk == true &&
      processRefund != null;

  double get totalAmountToRefund => amount + fee;
}

import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum WalletConfirmationRefund { evm, archethic }

enum ProcessRefund { chargeable, signed }

enum AddressType { evm, archethic }

@freezed
class RefundFormState with _$RefundFormState {
  const factory RefundFormState({
    @Default('') String htlcAddressFilled,
    String? refundTxAddress,
    int? chainId,
    bool? isAlreadyRefunded,
    bool? isAlreadyWithdrawn,
    @Default(false) refundOk,
    @Default(false) refundInProgress,
    AddressType? addressType,
    int? htlcDateLock,
    @Default(0) double amount,
    @Default('') String amountCurrency,
    @Default(0) double fee,
    @Default(false) htlcCanRefund,
    WalletConfirmationRefund? walletConfirmation,
    ProcessRefund? processRefund,
    String? blockchainTo,
    bool? isERC20,
    BridgeWallet? wallet,
    @FailureJsonConverter() Failure? failure,
  }) = _RefundFormState;
  const RefundFormState._();

  bool get isControlsOk =>
      failure == null &&
      htlcAddressFilled.isNotEmpty &&
      addressType != null &&
      processRefund != null;

  double get totalAmountToRefund => amount + fee;
}

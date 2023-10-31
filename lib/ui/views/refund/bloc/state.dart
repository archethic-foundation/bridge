import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum WalletConfirmationRefund { evm, archethic }

@freezed
class RefundFormState with _$RefundFormState {
  const factory RefundFormState({
    @Default('') String htlcAddress,
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
    BridgeWallet? evmWallet,
    @FailureJsonConverter() Failure? failure,
  }) = _RefundFormState;
  const RefundFormState._();

  bool get isControlsOk =>
      failure == null &&
      htlcAddress.isNotEmpty &&
      addressOk != null &&
      addressOk == true;

  double get totalAmountToRefund => amount + fee;
}

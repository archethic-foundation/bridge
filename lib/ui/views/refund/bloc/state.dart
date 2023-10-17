import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class RefundFormState with _$RefundFormState {
  const factory RefundFormState({
    @Default('') String htlcAddress,
    String? refundTxAddress,
    int? chainId,
    bool? isAlreadyRefunded,
    @Default(false) refundOk,
    bool? addressOk,
    int? htlcDateLock,
    @Default(0) double amount,
    @Default(0) double fee,
    @Default(false) htlcCanRefund,
    BridgeWallet? evmWallet,
    @FailureJsonConverter() Failure? failure,
  }) = _RefundFormState;
  const RefundFormState._();

  bool get isControlsOk =>
      failure == null &&
      htlcAddress.isNotEmpty &&
      addressOk != null &&
      addressOk == true;
}

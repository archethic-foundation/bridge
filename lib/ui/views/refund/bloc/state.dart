import 'package:aebridge/domain/models/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class RefundFormState with _$RefundFormState {
  const factory RefundFormState({
    @Default('') String contractAddress,
    String? refundTxAddress,
    int? chainId,
    bool? isAlwaysRefunded,
    @Default(false) refundOk,
    bool? addressOk,
    DateTime? htlcDateLock,
    @Default(0) double amount,
    @Default(0) double fee,
    @Default(false) htlcCanRefund,
    @FailureJsonConverter() Failure? failure,
  }) = _RefundFormState;
  const RefundFormState._();

  bool get isControlsOk =>
      failure == null &&
      contractAddress.isNotEmpty &&
      addressOk != null &&
      addressOk == true;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RefundFormState {
  String get contractAddress => throw _privateConstructorUsedError;
  String? get refundTxAddress => throw _privateConstructorUsedError;
  int? get chainId => throw _privateConstructorUsedError;
  bool? get isArchethic => throw _privateConstructorUsedError;
  bool? get isAlwaysRefunded => throw _privateConstructorUsedError;
  dynamic get refundOk => throw _privateConstructorUsedError;
  DateTime? get htlcDateLock => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;
  dynamic get htlcCanRefund => throw _privateConstructorUsedError;
  @FailureJsonConverter()
  Failure? get failure => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RefundFormStateCopyWith<RefundFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefundFormStateCopyWith<$Res> {
  factory $RefundFormStateCopyWith(
          RefundFormState value, $Res Function(RefundFormState) then) =
      _$RefundFormStateCopyWithImpl<$Res, RefundFormState>;
  @useResult
  $Res call(
      {String contractAddress,
      String? refundTxAddress,
      int? chainId,
      bool? isArchethic,
      bool? isAlwaysRefunded,
      dynamic refundOk,
      DateTime? htlcDateLock,
      double amount,
      double fee,
      dynamic htlcCanRefund,
      @FailureJsonConverter() Failure? failure});

  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$RefundFormStateCopyWithImpl<$Res, $Val extends RefundFormState>
    implements $RefundFormStateCopyWith<$Res> {
  _$RefundFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contractAddress = null,
    Object? refundTxAddress = freezed,
    Object? chainId = freezed,
    Object? isArchethic = freezed,
    Object? isAlwaysRefunded = freezed,
    Object? refundOk = freezed,
    Object? htlcDateLock = freezed,
    Object? amount = null,
    Object? fee = null,
    Object? htlcCanRefund = freezed,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      contractAddress: null == contractAddress
          ? _value.contractAddress
          : contractAddress // ignore: cast_nullable_to_non_nullable
              as String,
      refundTxAddress: freezed == refundTxAddress
          ? _value.refundTxAddress
          : refundTxAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      isArchethic: freezed == isArchethic
          ? _value.isArchethic
          : isArchethic // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAlwaysRefunded: freezed == isAlwaysRefunded
          ? _value.isAlwaysRefunded
          : isAlwaysRefunded // ignore: cast_nullable_to_non_nullable
              as bool?,
      refundOk: freezed == refundOk
          ? _value.refundOk
          : refundOk // ignore: cast_nullable_to_non_nullable
              as dynamic,
      htlcDateLock: freezed == htlcDateLock
          ? _value.htlcDateLock
          : htlcDateLock // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      htlcCanRefund: freezed == htlcCanRefund
          ? _value.htlcCanRefund
          : htlcCanRefund // ignore: cast_nullable_to_non_nullable
              as dynamic,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res>? get failure {
    if (_value.failure == null) {
      return null;
    }

    return $FailureCopyWith<$Res>(_value.failure!, (value) {
      return _then(_value.copyWith(failure: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RefundFormStateCopyWith<$Res>
    implements $RefundFormStateCopyWith<$Res> {
  factory _$$_RefundFormStateCopyWith(
          _$_RefundFormState value, $Res Function(_$_RefundFormState) then) =
      __$$_RefundFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String contractAddress,
      String? refundTxAddress,
      int? chainId,
      bool? isArchethic,
      bool? isAlwaysRefunded,
      dynamic refundOk,
      DateTime? htlcDateLock,
      double amount,
      double fee,
      dynamic htlcCanRefund,
      @FailureJsonConverter() Failure? failure});

  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$_RefundFormStateCopyWithImpl<$Res>
    extends _$RefundFormStateCopyWithImpl<$Res, _$_RefundFormState>
    implements _$$_RefundFormStateCopyWith<$Res> {
  __$$_RefundFormStateCopyWithImpl(
      _$_RefundFormState _value, $Res Function(_$_RefundFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contractAddress = null,
    Object? refundTxAddress = freezed,
    Object? chainId = freezed,
    Object? isArchethic = freezed,
    Object? isAlwaysRefunded = freezed,
    Object? refundOk = freezed,
    Object? htlcDateLock = freezed,
    Object? amount = null,
    Object? fee = null,
    Object? htlcCanRefund = freezed,
    Object? failure = freezed,
  }) {
    return _then(_$_RefundFormState(
      contractAddress: null == contractAddress
          ? _value.contractAddress
          : contractAddress // ignore: cast_nullable_to_non_nullable
              as String,
      refundTxAddress: freezed == refundTxAddress
          ? _value.refundTxAddress
          : refundTxAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      isArchethic: freezed == isArchethic
          ? _value.isArchethic
          : isArchethic // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAlwaysRefunded: freezed == isAlwaysRefunded
          ? _value.isAlwaysRefunded
          : isAlwaysRefunded // ignore: cast_nullable_to_non_nullable
              as bool?,
      refundOk: freezed == refundOk ? _value.refundOk! : refundOk,
      htlcDateLock: freezed == htlcDateLock
          ? _value.htlcDateLock
          : htlcDateLock // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      htlcCanRefund:
          freezed == htlcCanRefund ? _value.htlcCanRefund! : htlcCanRefund,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class _$_RefundFormState extends _RefundFormState {
  const _$_RefundFormState(
      {this.contractAddress = '',
      this.refundTxAddress,
      this.chainId,
      this.isArchethic,
      this.isAlwaysRefunded,
      this.refundOk = false,
      this.htlcDateLock,
      this.amount = 0,
      this.fee = 0,
      this.htlcCanRefund = false,
      @FailureJsonConverter() this.failure})
      : super._();

  @override
  @JsonKey()
  final String contractAddress;
  @override
  final String? refundTxAddress;
  @override
  final int? chainId;
  @override
  final bool? isArchethic;
  @override
  final bool? isAlwaysRefunded;
  @override
  @JsonKey()
  final dynamic refundOk;
  @override
  final DateTime? htlcDateLock;
  @override
  @JsonKey()
  final double amount;
  @override
  @JsonKey()
  final double fee;
  @override
  @JsonKey()
  final dynamic htlcCanRefund;
  @override
  @FailureJsonConverter()
  final Failure? failure;

  @override
  String toString() {
    return 'RefundFormState(contractAddress: $contractAddress, refundTxAddress: $refundTxAddress, chainId: $chainId, isArchethic: $isArchethic, isAlwaysRefunded: $isAlwaysRefunded, refundOk: $refundOk, htlcDateLock: $htlcDateLock, amount: $amount, fee: $fee, htlcCanRefund: $htlcCanRefund, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RefundFormState &&
            (identical(other.contractAddress, contractAddress) ||
                other.contractAddress == contractAddress) &&
            (identical(other.refundTxAddress, refundTxAddress) ||
                other.refundTxAddress == refundTxAddress) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.isArchethic, isArchethic) ||
                other.isArchethic == isArchethic) &&
            (identical(other.isAlwaysRefunded, isAlwaysRefunded) ||
                other.isAlwaysRefunded == isAlwaysRefunded) &&
            const DeepCollectionEquality().equals(other.refundOk, refundOk) &&
            (identical(other.htlcDateLock, htlcDateLock) ||
                other.htlcDateLock == htlcDateLock) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            const DeepCollectionEquality()
                .equals(other.htlcCanRefund, htlcCanRefund) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      contractAddress,
      refundTxAddress,
      chainId,
      isArchethic,
      isAlwaysRefunded,
      const DeepCollectionEquality().hash(refundOk),
      htlcDateLock,
      amount,
      fee,
      const DeepCollectionEquality().hash(htlcCanRefund),
      failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RefundFormStateCopyWith<_$_RefundFormState> get copyWith =>
      __$$_RefundFormStateCopyWithImpl<_$_RefundFormState>(this, _$identity);
}

abstract class _RefundFormState extends RefundFormState {
  const factory _RefundFormState(
      {final String contractAddress,
      final String? refundTxAddress,
      final int? chainId,
      final bool? isArchethic,
      final bool? isAlwaysRefunded,
      final dynamic refundOk,
      final DateTime? htlcDateLock,
      final double amount,
      final double fee,
      final dynamic htlcCanRefund,
      @FailureJsonConverter() final Failure? failure}) = _$_RefundFormState;
  const _RefundFormState._() : super._();

  @override
  String get contractAddress;
  @override
  String? get refundTxAddress;
  @override
  int? get chainId;
  @override
  bool? get isArchethic;
  @override
  bool? get isAlwaysRefunded;
  @override
  dynamic get refundOk;
  @override
  DateTime? get htlcDateLock;
  @override
  double get amount;
  @override
  double get fee;
  @override
  dynamic get htlcCanRefund;
  @override
  @FailureJsonConverter()
  Failure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$_RefundFormStateCopyWith<_$_RefundFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
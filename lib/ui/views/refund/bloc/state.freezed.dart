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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RefundFormState {
  String get htlcAddressFilled => throw _privateConstructorUsedError;
  String? get refundTxAddress => throw _privateConstructorUsedError;
  int? get chainId => throw _privateConstructorUsedError;
  bool? get isAlreadyRefunded => throw _privateConstructorUsedError;
  bool? get isAlreadyWithdrawn => throw _privateConstructorUsedError;
  dynamic get refundOk => throw _privateConstructorUsedError;
  dynamic get refundInProgress => throw _privateConstructorUsedError;
  AddressType? get addressType => throw _privateConstructorUsedError;
  int? get htlcDateLock => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get amountCurrency => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;
  dynamic get htlcCanRefund => throw _privateConstructorUsedError;
  WalletConfirmationRefund? get walletConfirmation =>
      throw _privateConstructorUsedError;
  ProcessRefund? get processRefund => throw _privateConstructorUsedError;
  String? get blockchainTo => throw _privateConstructorUsedError;
  bool? get isERC20 => throw _privateConstructorUsedError;
  BridgeWallet? get wallet => throw _privateConstructorUsedError;
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
      {String htlcAddressFilled,
      String? refundTxAddress,
      int? chainId,
      bool? isAlreadyRefunded,
      bool? isAlreadyWithdrawn,
      dynamic refundOk,
      dynamic refundInProgress,
      AddressType? addressType,
      int? htlcDateLock,
      double amount,
      String amountCurrency,
      double fee,
      dynamic htlcCanRefund,
      WalletConfirmationRefund? walletConfirmation,
      ProcessRefund? processRefund,
      String? blockchainTo,
      bool? isERC20,
      BridgeWallet? wallet,
      @FailureJsonConverter() Failure? failure});

  $BridgeWalletCopyWith<$Res>? get wallet;
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
    Object? htlcAddressFilled = null,
    Object? refundTxAddress = freezed,
    Object? chainId = freezed,
    Object? isAlreadyRefunded = freezed,
    Object? isAlreadyWithdrawn = freezed,
    Object? refundOk = freezed,
    Object? refundInProgress = freezed,
    Object? addressType = freezed,
    Object? htlcDateLock = freezed,
    Object? amount = null,
    Object? amountCurrency = null,
    Object? fee = null,
    Object? htlcCanRefund = freezed,
    Object? walletConfirmation = freezed,
    Object? processRefund = freezed,
    Object? blockchainTo = freezed,
    Object? isERC20 = freezed,
    Object? wallet = freezed,
    Object? failure = freezed,
  }) {
    return _then(_value.copyWith(
      htlcAddressFilled: null == htlcAddressFilled
          ? _value.htlcAddressFilled
          : htlcAddressFilled // ignore: cast_nullable_to_non_nullable
              as String,
      refundTxAddress: freezed == refundTxAddress
          ? _value.refundTxAddress
          : refundTxAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      isAlreadyRefunded: freezed == isAlreadyRefunded
          ? _value.isAlreadyRefunded
          : isAlreadyRefunded // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAlreadyWithdrawn: freezed == isAlreadyWithdrawn
          ? _value.isAlreadyWithdrawn
          : isAlreadyWithdrawn // ignore: cast_nullable_to_non_nullable
              as bool?,
      refundOk: freezed == refundOk
          ? _value.refundOk
          : refundOk // ignore: cast_nullable_to_non_nullable
              as dynamic,
      refundInProgress: freezed == refundInProgress
          ? _value.refundInProgress
          : refundInProgress // ignore: cast_nullable_to_non_nullable
              as dynamic,
      addressType: freezed == addressType
          ? _value.addressType
          : addressType // ignore: cast_nullable_to_non_nullable
              as AddressType?,
      htlcDateLock: freezed == htlcDateLock
          ? _value.htlcDateLock
          : htlcDateLock // ignore: cast_nullable_to_non_nullable
              as int?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      amountCurrency: null == amountCurrency
          ? _value.amountCurrency
          : amountCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      htlcCanRefund: freezed == htlcCanRefund
          ? _value.htlcCanRefund
          : htlcCanRefund // ignore: cast_nullable_to_non_nullable
              as dynamic,
      walletConfirmation: freezed == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as WalletConfirmationRefund?,
      processRefund: freezed == processRefund
          ? _value.processRefund
          : processRefund // ignore: cast_nullable_to_non_nullable
              as ProcessRefund?,
      blockchainTo: freezed == blockchainTo
          ? _value.blockchainTo
          : blockchainTo // ignore: cast_nullable_to_non_nullable
              as String?,
      isERC20: freezed == isERC20
          ? _value.isERC20
          : isERC20 // ignore: cast_nullable_to_non_nullable
              as bool?,
      wallet: freezed == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as BridgeWallet?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BridgeWalletCopyWith<$Res>? get wallet {
    if (_value.wallet == null) {
      return null;
    }

    return $BridgeWalletCopyWith<$Res>(_value.wallet!, (value) {
      return _then(_value.copyWith(wallet: value) as $Val);
    });
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
abstract class _$$RefundFormStateImplCopyWith<$Res>
    implements $RefundFormStateCopyWith<$Res> {
  factory _$$RefundFormStateImplCopyWith(_$RefundFormStateImpl value,
          $Res Function(_$RefundFormStateImpl) then) =
      __$$RefundFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String htlcAddressFilled,
      String? refundTxAddress,
      int? chainId,
      bool? isAlreadyRefunded,
      bool? isAlreadyWithdrawn,
      dynamic refundOk,
      dynamic refundInProgress,
      AddressType? addressType,
      int? htlcDateLock,
      double amount,
      String amountCurrency,
      double fee,
      dynamic htlcCanRefund,
      WalletConfirmationRefund? walletConfirmation,
      ProcessRefund? processRefund,
      String? blockchainTo,
      bool? isERC20,
      BridgeWallet? wallet,
      @FailureJsonConverter() Failure? failure});

  @override
  $BridgeWalletCopyWith<$Res>? get wallet;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$RefundFormStateImplCopyWithImpl<$Res>
    extends _$RefundFormStateCopyWithImpl<$Res, _$RefundFormStateImpl>
    implements _$$RefundFormStateImplCopyWith<$Res> {
  __$$RefundFormStateImplCopyWithImpl(
      _$RefundFormStateImpl _value, $Res Function(_$RefundFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? htlcAddressFilled = null,
    Object? refundTxAddress = freezed,
    Object? chainId = freezed,
    Object? isAlreadyRefunded = freezed,
    Object? isAlreadyWithdrawn = freezed,
    Object? refundOk = freezed,
    Object? refundInProgress = freezed,
    Object? addressType = freezed,
    Object? htlcDateLock = freezed,
    Object? amount = null,
    Object? amountCurrency = null,
    Object? fee = null,
    Object? htlcCanRefund = freezed,
    Object? walletConfirmation = freezed,
    Object? processRefund = freezed,
    Object? blockchainTo = freezed,
    Object? isERC20 = freezed,
    Object? wallet = freezed,
    Object? failure = freezed,
  }) {
    return _then(_$RefundFormStateImpl(
      htlcAddressFilled: null == htlcAddressFilled
          ? _value.htlcAddressFilled
          : htlcAddressFilled // ignore: cast_nullable_to_non_nullable
              as String,
      refundTxAddress: freezed == refundTxAddress
          ? _value.refundTxAddress
          : refundTxAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      isAlreadyRefunded: freezed == isAlreadyRefunded
          ? _value.isAlreadyRefunded
          : isAlreadyRefunded // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAlreadyWithdrawn: freezed == isAlreadyWithdrawn
          ? _value.isAlreadyWithdrawn
          : isAlreadyWithdrawn // ignore: cast_nullable_to_non_nullable
              as bool?,
      refundOk: freezed == refundOk ? _value.refundOk! : refundOk,
      refundInProgress: freezed == refundInProgress
          ? _value.refundInProgress!
          : refundInProgress,
      addressType: freezed == addressType
          ? _value.addressType
          : addressType // ignore: cast_nullable_to_non_nullable
              as AddressType?,
      htlcDateLock: freezed == htlcDateLock
          ? _value.htlcDateLock
          : htlcDateLock // ignore: cast_nullable_to_non_nullable
              as int?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      amountCurrency: null == amountCurrency
          ? _value.amountCurrency
          : amountCurrency // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as double,
      htlcCanRefund:
          freezed == htlcCanRefund ? _value.htlcCanRefund! : htlcCanRefund,
      walletConfirmation: freezed == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as WalletConfirmationRefund?,
      processRefund: freezed == processRefund
          ? _value.processRefund
          : processRefund // ignore: cast_nullable_to_non_nullable
              as ProcessRefund?,
      blockchainTo: freezed == blockchainTo
          ? _value.blockchainTo
          : blockchainTo // ignore: cast_nullable_to_non_nullable
              as String?,
      isERC20: freezed == isERC20
          ? _value.isERC20
          : isERC20 // ignore: cast_nullable_to_non_nullable
              as bool?,
      wallet: freezed == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as BridgeWallet?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
    ));
  }
}

/// @nodoc

class _$RefundFormStateImpl extends _RefundFormState {
  const _$RefundFormStateImpl(
      {this.htlcAddressFilled = '',
      this.refundTxAddress,
      this.chainId,
      this.isAlreadyRefunded,
      this.isAlreadyWithdrawn,
      this.refundOk = false,
      this.refundInProgress = false,
      this.addressType,
      this.htlcDateLock,
      this.amount = 0,
      this.amountCurrency = '',
      this.fee = 0,
      this.htlcCanRefund = false,
      this.walletConfirmation,
      this.processRefund,
      this.blockchainTo,
      this.isERC20,
      this.wallet,
      @FailureJsonConverter() this.failure})
      : super._();

  @override
  @JsonKey()
  final String htlcAddressFilled;
  @override
  final String? refundTxAddress;
  @override
  final int? chainId;
  @override
  final bool? isAlreadyRefunded;
  @override
  final bool? isAlreadyWithdrawn;
  @override
  @JsonKey()
  final dynamic refundOk;
  @override
  @JsonKey()
  final dynamic refundInProgress;
  @override
  final AddressType? addressType;
  @override
  final int? htlcDateLock;
  @override
  @JsonKey()
  final double amount;
  @override
  @JsonKey()
  final String amountCurrency;
  @override
  @JsonKey()
  final double fee;
  @override
  @JsonKey()
  final dynamic htlcCanRefund;
  @override
  final WalletConfirmationRefund? walletConfirmation;
  @override
  final ProcessRefund? processRefund;
  @override
  final String? blockchainTo;
  @override
  final bool? isERC20;
  @override
  final BridgeWallet? wallet;
  @override
  @FailureJsonConverter()
  final Failure? failure;

  @override
  String toString() {
    return 'RefundFormState(htlcAddressFilled: $htlcAddressFilled, refundTxAddress: $refundTxAddress, chainId: $chainId, isAlreadyRefunded: $isAlreadyRefunded, isAlreadyWithdrawn: $isAlreadyWithdrawn, refundOk: $refundOk, refundInProgress: $refundInProgress, addressType: $addressType, htlcDateLock: $htlcDateLock, amount: $amount, amountCurrency: $amountCurrency, fee: $fee, htlcCanRefund: $htlcCanRefund, walletConfirmation: $walletConfirmation, processRefund: $processRefund, blockchainTo: $blockchainTo, isERC20: $isERC20, wallet: $wallet, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefundFormStateImpl &&
            (identical(other.htlcAddressFilled, htlcAddressFilled) ||
                other.htlcAddressFilled == htlcAddressFilled) &&
            (identical(other.refundTxAddress, refundTxAddress) ||
                other.refundTxAddress == refundTxAddress) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.isAlreadyRefunded, isAlreadyRefunded) ||
                other.isAlreadyRefunded == isAlreadyRefunded) &&
            (identical(other.isAlreadyWithdrawn, isAlreadyWithdrawn) ||
                other.isAlreadyWithdrawn == isAlreadyWithdrawn) &&
            const DeepCollectionEquality().equals(other.refundOk, refundOk) &&
            const DeepCollectionEquality()
                .equals(other.refundInProgress, refundInProgress) &&
            (identical(other.addressType, addressType) ||
                other.addressType == addressType) &&
            (identical(other.htlcDateLock, htlcDateLock) ||
                other.htlcDateLock == htlcDateLock) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.amountCurrency, amountCurrency) ||
                other.amountCurrency == amountCurrency) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            const DeepCollectionEquality()
                .equals(other.htlcCanRefund, htlcCanRefund) &&
            (identical(other.walletConfirmation, walletConfirmation) ||
                other.walletConfirmation == walletConfirmation) &&
            (identical(other.processRefund, processRefund) ||
                other.processRefund == processRefund) &&
            (identical(other.blockchainTo, blockchainTo) ||
                other.blockchainTo == blockchainTo) &&
            (identical(other.isERC20, isERC20) || other.isERC20 == isERC20) &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        htlcAddressFilled,
        refundTxAddress,
        chainId,
        isAlreadyRefunded,
        isAlreadyWithdrawn,
        const DeepCollectionEquality().hash(refundOk),
        const DeepCollectionEquality().hash(refundInProgress),
        addressType,
        htlcDateLock,
        amount,
        amountCurrency,
        fee,
        const DeepCollectionEquality().hash(htlcCanRefund),
        walletConfirmation,
        processRefund,
        blockchainTo,
        isERC20,
        wallet,
        failure
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RefundFormStateImplCopyWith<_$RefundFormStateImpl> get copyWith =>
      __$$RefundFormStateImplCopyWithImpl<_$RefundFormStateImpl>(
          this, _$identity);
}

abstract class _RefundFormState extends RefundFormState {
  const factory _RefundFormState(
      {final String htlcAddressFilled,
      final String? refundTxAddress,
      final int? chainId,
      final bool? isAlreadyRefunded,
      final bool? isAlreadyWithdrawn,
      final dynamic refundOk,
      final dynamic refundInProgress,
      final AddressType? addressType,
      final int? htlcDateLock,
      final double amount,
      final String amountCurrency,
      final double fee,
      final dynamic htlcCanRefund,
      final WalletConfirmationRefund? walletConfirmation,
      final ProcessRefund? processRefund,
      final String? blockchainTo,
      final bool? isERC20,
      final BridgeWallet? wallet,
      @FailureJsonConverter() final Failure? failure}) = _$RefundFormStateImpl;
  const _RefundFormState._() : super._();

  @override
  String get htlcAddressFilled;
  @override
  String? get refundTxAddress;
  @override
  int? get chainId;
  @override
  bool? get isAlreadyRefunded;
  @override
  bool? get isAlreadyWithdrawn;
  @override
  dynamic get refundOk;
  @override
  dynamic get refundInProgress;
  @override
  AddressType? get addressType;
  @override
  int? get htlcDateLock;
  @override
  double get amount;
  @override
  String get amountCurrency;
  @override
  double get fee;
  @override
  dynamic get htlcCanRefund;
  @override
  WalletConfirmationRefund? get walletConfirmation;
  @override
  ProcessRefund? get processRefund;
  @override
  String? get blockchainTo;
  @override
  bool? get isERC20;
  @override
  BridgeWallet? get wallet;
  @override
  @FailureJsonConverter()
  Failure? get failure;
  @override
  @JsonKey(ignore: true)
  _$$RefundFormStateImplCopyWith<_$RefundFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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
  @BridgeBlockchainJsonConverter()
  BridgeBlockchain? get blockchain => throw _privateConstructorUsedError;
  int? get chainId => throw _privateConstructorUsedError;
  bool? get isAlreadyRefunded => throw _privateConstructorUsedError;
  bool? get isAlreadyWithdrawn => throw _privateConstructorUsedError;
  bool get refundOk => throw _privateConstructorUsedError;
  bool get refundInProgress => throw _privateConstructorUsedError;
  AddressType? get addressType => throw _privateConstructorUsedError;
  int? get htlcDateLock => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get amountCurrency => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;
  bool get htlcCanRefund => throw _privateConstructorUsedError;
  WalletConfirmationRefund? get walletConfirmation =>
      throw _privateConstructorUsedError;
  ProcessRefund? get processRefund => throw _privateConstructorUsedError;
  String? get blockchainTo => throw _privateConstructorUsedError;
  bool? get isERC20 => throw _privateConstructorUsedError;
  BridgeWallet? get wallet => throw _privateConstructorUsedError;
  @FailureJsonConverter()
  Failure? get failure => throw _privateConstructorUsedError;
  bool get defineStatusInProgress => throw _privateConstructorUsedError;
  bool get requestTooLong => throw _privateConstructorUsedError;

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
      @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchain,
      int? chainId,
      bool? isAlreadyRefunded,
      bool? isAlreadyWithdrawn,
      bool refundOk,
      bool refundInProgress,
      AddressType? addressType,
      int? htlcDateLock,
      double amount,
      String amountCurrency,
      double fee,
      bool htlcCanRefund,
      WalletConfirmationRefund? walletConfirmation,
      ProcessRefund? processRefund,
      String? blockchainTo,
      bool? isERC20,
      BridgeWallet? wallet,
      @FailureJsonConverter() Failure? failure,
      bool defineStatusInProgress,
      bool requestTooLong});

  $BridgeBlockchainCopyWith<$Res>? get blockchain;
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
    Object? blockchain = freezed,
    Object? chainId = freezed,
    Object? isAlreadyRefunded = freezed,
    Object? isAlreadyWithdrawn = freezed,
    Object? refundOk = null,
    Object? refundInProgress = null,
    Object? addressType = freezed,
    Object? htlcDateLock = freezed,
    Object? amount = null,
    Object? amountCurrency = null,
    Object? fee = null,
    Object? htlcCanRefund = null,
    Object? walletConfirmation = freezed,
    Object? processRefund = freezed,
    Object? blockchainTo = freezed,
    Object? isERC20 = freezed,
    Object? wallet = freezed,
    Object? failure = freezed,
    Object? defineStatusInProgress = null,
    Object? requestTooLong = null,
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
      blockchain: freezed == blockchain
          ? _value.blockchain
          : blockchain // ignore: cast_nullable_to_non_nullable
              as BridgeBlockchain?,
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
      refundOk: null == refundOk
          ? _value.refundOk
          : refundOk // ignore: cast_nullable_to_non_nullable
              as bool,
      refundInProgress: null == refundInProgress
          ? _value.refundInProgress
          : refundInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
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
      htlcCanRefund: null == htlcCanRefund
          ? _value.htlcCanRefund
          : htlcCanRefund // ignore: cast_nullable_to_non_nullable
              as bool,
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
      defineStatusInProgress: null == defineStatusInProgress
          ? _value.defineStatusInProgress
          : defineStatusInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      requestTooLong: null == requestTooLong
          ? _value.requestTooLong
          : requestTooLong // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BridgeBlockchainCopyWith<$Res>? get blockchain {
    if (_value.blockchain == null) {
      return null;
    }

    return $BridgeBlockchainCopyWith<$Res>(_value.blockchain!, (value) {
      return _then(_value.copyWith(blockchain: value) as $Val);
    });
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
      @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchain,
      int? chainId,
      bool? isAlreadyRefunded,
      bool? isAlreadyWithdrawn,
      bool refundOk,
      bool refundInProgress,
      AddressType? addressType,
      int? htlcDateLock,
      double amount,
      String amountCurrency,
      double fee,
      bool htlcCanRefund,
      WalletConfirmationRefund? walletConfirmation,
      ProcessRefund? processRefund,
      String? blockchainTo,
      bool? isERC20,
      BridgeWallet? wallet,
      @FailureJsonConverter() Failure? failure,
      bool defineStatusInProgress,
      bool requestTooLong});

  @override
  $BridgeBlockchainCopyWith<$Res>? get blockchain;
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
    Object? blockchain = freezed,
    Object? chainId = freezed,
    Object? isAlreadyRefunded = freezed,
    Object? isAlreadyWithdrawn = freezed,
    Object? refundOk = null,
    Object? refundInProgress = null,
    Object? addressType = freezed,
    Object? htlcDateLock = freezed,
    Object? amount = null,
    Object? amountCurrency = null,
    Object? fee = null,
    Object? htlcCanRefund = null,
    Object? walletConfirmation = freezed,
    Object? processRefund = freezed,
    Object? blockchainTo = freezed,
    Object? isERC20 = freezed,
    Object? wallet = freezed,
    Object? failure = freezed,
    Object? defineStatusInProgress = null,
    Object? requestTooLong = null,
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
      blockchain: freezed == blockchain
          ? _value.blockchain
          : blockchain // ignore: cast_nullable_to_non_nullable
              as BridgeBlockchain?,
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
      refundOk: null == refundOk
          ? _value.refundOk
          : refundOk // ignore: cast_nullable_to_non_nullable
              as bool,
      refundInProgress: null == refundInProgress
          ? _value.refundInProgress
          : refundInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
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
      htlcCanRefund: null == htlcCanRefund
          ? _value.htlcCanRefund
          : htlcCanRefund // ignore: cast_nullable_to_non_nullable
              as bool,
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
      defineStatusInProgress: null == defineStatusInProgress
          ? _value.defineStatusInProgress
          : defineStatusInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      requestTooLong: null == requestTooLong
          ? _value.requestTooLong
          : requestTooLong // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RefundFormStateImpl extends _RefundFormState {
  const _$RefundFormStateImpl(
      {this.htlcAddressFilled = '',
      this.refundTxAddress,
      @BridgeBlockchainJsonConverter() this.blockchain,
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
      @FailureJsonConverter() this.failure,
      this.defineStatusInProgress = false,
      this.requestTooLong = false})
      : super._();

  @override
  @JsonKey()
  final String htlcAddressFilled;
  @override
  final String? refundTxAddress;
  @override
  @BridgeBlockchainJsonConverter()
  final BridgeBlockchain? blockchain;
  @override
  final int? chainId;
  @override
  final bool? isAlreadyRefunded;
  @override
  final bool? isAlreadyWithdrawn;
  @override
  @JsonKey()
  final bool refundOk;
  @override
  @JsonKey()
  final bool refundInProgress;
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
  final bool htlcCanRefund;
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
  @JsonKey()
  final bool defineStatusInProgress;
  @override
  @JsonKey()
  final bool requestTooLong;

  @override
  String toString() {
    return 'RefundFormState(htlcAddressFilled: $htlcAddressFilled, refundTxAddress: $refundTxAddress, blockchain: $blockchain, chainId: $chainId, isAlreadyRefunded: $isAlreadyRefunded, isAlreadyWithdrawn: $isAlreadyWithdrawn, refundOk: $refundOk, refundInProgress: $refundInProgress, addressType: $addressType, htlcDateLock: $htlcDateLock, amount: $amount, amountCurrency: $amountCurrency, fee: $fee, htlcCanRefund: $htlcCanRefund, walletConfirmation: $walletConfirmation, processRefund: $processRefund, blockchainTo: $blockchainTo, isERC20: $isERC20, wallet: $wallet, failure: $failure, defineStatusInProgress: $defineStatusInProgress, requestTooLong: $requestTooLong)';
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
            (identical(other.blockchain, blockchain) ||
                other.blockchain == blockchain) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.isAlreadyRefunded, isAlreadyRefunded) ||
                other.isAlreadyRefunded == isAlreadyRefunded) &&
            (identical(other.isAlreadyWithdrawn, isAlreadyWithdrawn) ||
                other.isAlreadyWithdrawn == isAlreadyWithdrawn) &&
            (identical(other.refundOk, refundOk) ||
                other.refundOk == refundOk) &&
            (identical(other.refundInProgress, refundInProgress) ||
                other.refundInProgress == refundInProgress) &&
            (identical(other.addressType, addressType) ||
                other.addressType == addressType) &&
            (identical(other.htlcDateLock, htlcDateLock) ||
                other.htlcDateLock == htlcDateLock) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.amountCurrency, amountCurrency) ||
                other.amountCurrency == amountCurrency) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.htlcCanRefund, htlcCanRefund) ||
                other.htlcCanRefund == htlcCanRefund) &&
            (identical(other.walletConfirmation, walletConfirmation) ||
                other.walletConfirmation == walletConfirmation) &&
            (identical(other.processRefund, processRefund) ||
                other.processRefund == processRefund) &&
            (identical(other.blockchainTo, blockchainTo) ||
                other.blockchainTo == blockchainTo) &&
            (identical(other.isERC20, isERC20) || other.isERC20 == isERC20) &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.defineStatusInProgress, defineStatusInProgress) ||
                other.defineStatusInProgress == defineStatusInProgress) &&
            (identical(other.requestTooLong, requestTooLong) ||
                other.requestTooLong == requestTooLong));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        htlcAddressFilled,
        refundTxAddress,
        blockchain,
        chainId,
        isAlreadyRefunded,
        isAlreadyWithdrawn,
        refundOk,
        refundInProgress,
        addressType,
        htlcDateLock,
        amount,
        amountCurrency,
        fee,
        htlcCanRefund,
        walletConfirmation,
        processRefund,
        blockchainTo,
        isERC20,
        wallet,
        failure,
        defineStatusInProgress,
        requestTooLong
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
      @BridgeBlockchainJsonConverter() final BridgeBlockchain? blockchain,
      final int? chainId,
      final bool? isAlreadyRefunded,
      final bool? isAlreadyWithdrawn,
      final bool refundOk,
      final bool refundInProgress,
      final AddressType? addressType,
      final int? htlcDateLock,
      final double amount,
      final String amountCurrency,
      final double fee,
      final bool htlcCanRefund,
      final WalletConfirmationRefund? walletConfirmation,
      final ProcessRefund? processRefund,
      final String? blockchainTo,
      final bool? isERC20,
      final BridgeWallet? wallet,
      @FailureJsonConverter() final Failure? failure,
      final bool defineStatusInProgress,
      final bool requestTooLong}) = _$RefundFormStateImpl;
  const _RefundFormState._() : super._();

  @override
  String get htlcAddressFilled;
  @override
  String? get refundTxAddress;
  @override
  @BridgeBlockchainJsonConverter()
  BridgeBlockchain? get blockchain;
  @override
  int? get chainId;
  @override
  bool? get isAlreadyRefunded;
  @override
  bool? get isAlreadyWithdrawn;
  @override
  bool get refundOk;
  @override
  bool get refundInProgress;
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
  bool get htlcCanRefund;
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
  bool get defineStatusInProgress;
  @override
  bool get requestTooLong;
  @override
  @JsonKey(ignore: true)
  _$$RefundFormStateImplCopyWith<_$RefundFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

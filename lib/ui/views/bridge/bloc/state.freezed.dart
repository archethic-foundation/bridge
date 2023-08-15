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
mixin _$BridgeFormState {
  BridgeProcessStep get bridgeProcessStep => throw _privateConstructorUsedError;
  BridgeBlockchain? get blockchainFrom => throw _privateConstructorUsedError;
  BridgeBlockchain? get blockchainTo => throw _privateConstructorUsedError;
  BridgeToken? get tokenToBridge => throw _privateConstructorUsedError;
  double get tokenToBridgeAmount => throw _privateConstructorUsedError;
  String get targetAddress => throw _privateConstructorUsedError;
  double get tokenToBridgeAmountFiat => throw _privateConstructorUsedError;
  double get networkFees => throw _privateConstructorUsedError;
  double get networkFeesFiat => throw _privateConstructorUsedError;
  double get tokenToBridgeBalance => throw _privateConstructorUsedError;
  String get errorText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BridgeFormStateCopyWith<BridgeFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BridgeFormStateCopyWith<$Res> {
  factory $BridgeFormStateCopyWith(
          BridgeFormState value, $Res Function(BridgeFormState) then) =
      _$BridgeFormStateCopyWithImpl<$Res, BridgeFormState>;
  @useResult
  $Res call(
      {BridgeProcessStep bridgeProcessStep,
      BridgeBlockchain? blockchainFrom,
      BridgeBlockchain? blockchainTo,
      BridgeToken? tokenToBridge,
      double tokenToBridgeAmount,
      String targetAddress,
      double tokenToBridgeAmountFiat,
      double networkFees,
      double networkFeesFiat,
      double tokenToBridgeBalance,
      String errorText});

  $BridgeBlockchainCopyWith<$Res>? get blockchainFrom;
  $BridgeBlockchainCopyWith<$Res>? get blockchainTo;
  $BridgeTokenCopyWith<$Res>? get tokenToBridge;
}

/// @nodoc
class _$BridgeFormStateCopyWithImpl<$Res, $Val extends BridgeFormState>
    implements $BridgeFormStateCopyWith<$Res> {
  _$BridgeFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bridgeProcessStep = null,
    Object? blockchainFrom = freezed,
    Object? blockchainTo = freezed,
    Object? tokenToBridge = freezed,
    Object? tokenToBridgeAmount = null,
    Object? targetAddress = null,
    Object? tokenToBridgeAmountFiat = null,
    Object? networkFees = null,
    Object? networkFeesFiat = null,
    Object? tokenToBridgeBalance = null,
    Object? errorText = null,
  }) {
    return _then(_value.copyWith(
      bridgeProcessStep: null == bridgeProcessStep
          ? _value.bridgeProcessStep
          : bridgeProcessStep // ignore: cast_nullable_to_non_nullable
              as BridgeProcessStep,
      blockchainFrom: freezed == blockchainFrom
          ? _value.blockchainFrom
          : blockchainFrom // ignore: cast_nullable_to_non_nullable
              as BridgeBlockchain?,
      blockchainTo: freezed == blockchainTo
          ? _value.blockchainTo
          : blockchainTo // ignore: cast_nullable_to_non_nullable
              as BridgeBlockchain?,
      tokenToBridge: freezed == tokenToBridge
          ? _value.tokenToBridge
          : tokenToBridge // ignore: cast_nullable_to_non_nullable
              as BridgeToken?,
      tokenToBridgeAmount: null == tokenToBridgeAmount
          ? _value.tokenToBridgeAmount
          : tokenToBridgeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      targetAddress: null == targetAddress
          ? _value.targetAddress
          : targetAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenToBridgeAmountFiat: null == tokenToBridgeAmountFiat
          ? _value.tokenToBridgeAmountFiat
          : tokenToBridgeAmountFiat // ignore: cast_nullable_to_non_nullable
              as double,
      networkFees: null == networkFees
          ? _value.networkFees
          : networkFees // ignore: cast_nullable_to_non_nullable
              as double,
      networkFeesFiat: null == networkFeesFiat
          ? _value.networkFeesFiat
          : networkFeesFiat // ignore: cast_nullable_to_non_nullable
              as double,
      tokenToBridgeBalance: null == tokenToBridgeBalance
          ? _value.tokenToBridgeBalance
          : tokenToBridgeBalance // ignore: cast_nullable_to_non_nullable
              as double,
      errorText: null == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BridgeBlockchainCopyWith<$Res>? get blockchainFrom {
    if (_value.blockchainFrom == null) {
      return null;
    }

    return $BridgeBlockchainCopyWith<$Res>(_value.blockchainFrom!, (value) {
      return _then(_value.copyWith(blockchainFrom: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BridgeBlockchainCopyWith<$Res>? get blockchainTo {
    if (_value.blockchainTo == null) {
      return null;
    }

    return $BridgeBlockchainCopyWith<$Res>(_value.blockchainTo!, (value) {
      return _then(_value.copyWith(blockchainTo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BridgeTokenCopyWith<$Res>? get tokenToBridge {
    if (_value.tokenToBridge == null) {
      return null;
    }

    return $BridgeTokenCopyWith<$Res>(_value.tokenToBridge!, (value) {
      return _then(_value.copyWith(tokenToBridge: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BridgeFormStateCopyWith<$Res>
    implements $BridgeFormStateCopyWith<$Res> {
  factory _$$_BridgeFormStateCopyWith(
          _$_BridgeFormState value, $Res Function(_$_BridgeFormState) then) =
      __$$_BridgeFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BridgeProcessStep bridgeProcessStep,
      BridgeBlockchain? blockchainFrom,
      BridgeBlockchain? blockchainTo,
      BridgeToken? tokenToBridge,
      double tokenToBridgeAmount,
      String targetAddress,
      double tokenToBridgeAmountFiat,
      double networkFees,
      double networkFeesFiat,
      double tokenToBridgeBalance,
      String errorText});

  @override
  $BridgeBlockchainCopyWith<$Res>? get blockchainFrom;
  @override
  $BridgeBlockchainCopyWith<$Res>? get blockchainTo;
  @override
  $BridgeTokenCopyWith<$Res>? get tokenToBridge;
}

/// @nodoc
class __$$_BridgeFormStateCopyWithImpl<$Res>
    extends _$BridgeFormStateCopyWithImpl<$Res, _$_BridgeFormState>
    implements _$$_BridgeFormStateCopyWith<$Res> {
  __$$_BridgeFormStateCopyWithImpl(
      _$_BridgeFormState _value, $Res Function(_$_BridgeFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bridgeProcessStep = null,
    Object? blockchainFrom = freezed,
    Object? blockchainTo = freezed,
    Object? tokenToBridge = freezed,
    Object? tokenToBridgeAmount = null,
    Object? targetAddress = null,
    Object? tokenToBridgeAmountFiat = null,
    Object? networkFees = null,
    Object? networkFeesFiat = null,
    Object? tokenToBridgeBalance = null,
    Object? errorText = null,
  }) {
    return _then(_$_BridgeFormState(
      bridgeProcessStep: null == bridgeProcessStep
          ? _value.bridgeProcessStep
          : bridgeProcessStep // ignore: cast_nullable_to_non_nullable
              as BridgeProcessStep,
      blockchainFrom: freezed == blockchainFrom
          ? _value.blockchainFrom
          : blockchainFrom // ignore: cast_nullable_to_non_nullable
              as BridgeBlockchain?,
      blockchainTo: freezed == blockchainTo
          ? _value.blockchainTo
          : blockchainTo // ignore: cast_nullable_to_non_nullable
              as BridgeBlockchain?,
      tokenToBridge: freezed == tokenToBridge
          ? _value.tokenToBridge
          : tokenToBridge // ignore: cast_nullable_to_non_nullable
              as BridgeToken?,
      tokenToBridgeAmount: null == tokenToBridgeAmount
          ? _value.tokenToBridgeAmount
          : tokenToBridgeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      targetAddress: null == targetAddress
          ? _value.targetAddress
          : targetAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenToBridgeAmountFiat: null == tokenToBridgeAmountFiat
          ? _value.tokenToBridgeAmountFiat
          : tokenToBridgeAmountFiat // ignore: cast_nullable_to_non_nullable
              as double,
      networkFees: null == networkFees
          ? _value.networkFees
          : networkFees // ignore: cast_nullable_to_non_nullable
              as double,
      networkFeesFiat: null == networkFeesFiat
          ? _value.networkFeesFiat
          : networkFeesFiat // ignore: cast_nullable_to_non_nullable
              as double,
      tokenToBridgeBalance: null == tokenToBridgeBalance
          ? _value.tokenToBridgeBalance
          : tokenToBridgeBalance // ignore: cast_nullable_to_non_nullable
              as double,
      errorText: null == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BridgeFormState extends _BridgeFormState {
  const _$_BridgeFormState(
      {this.bridgeProcessStep = BridgeProcessStep.form,
      this.blockchainFrom,
      this.blockchainTo,
      this.tokenToBridge,
      this.tokenToBridgeAmount = 0,
      this.targetAddress = '',
      this.tokenToBridgeAmountFiat = 0,
      this.networkFees = 0.0,
      this.networkFeesFiat = 0.0,
      this.tokenToBridgeBalance = 0,
      this.errorText = ''})
      : super._();

  @override
  @JsonKey()
  final BridgeProcessStep bridgeProcessStep;
  @override
  final BridgeBlockchain? blockchainFrom;
  @override
  final BridgeBlockchain? blockchainTo;
  @override
  final BridgeToken? tokenToBridge;
  @override
  @JsonKey()
  final double tokenToBridgeAmount;
  @override
  @JsonKey()
  final String targetAddress;
  @override
  @JsonKey()
  final double tokenToBridgeAmountFiat;
  @override
  @JsonKey()
  final double networkFees;
  @override
  @JsonKey()
  final double networkFeesFiat;
  @override
  @JsonKey()
  final double tokenToBridgeBalance;
  @override
  @JsonKey()
  final String errorText;

  @override
  String toString() {
    return 'BridgeFormState(bridgeProcessStep: $bridgeProcessStep, blockchainFrom: $blockchainFrom, blockchainTo: $blockchainTo, tokenToBridge: $tokenToBridge, tokenToBridgeAmount: $tokenToBridgeAmount, targetAddress: $targetAddress, tokenToBridgeAmountFiat: $tokenToBridgeAmountFiat, networkFees: $networkFees, networkFeesFiat: $networkFeesFiat, tokenToBridgeBalance: $tokenToBridgeBalance, errorText: $errorText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BridgeFormState &&
            (identical(other.bridgeProcessStep, bridgeProcessStep) ||
                other.bridgeProcessStep == bridgeProcessStep) &&
            (identical(other.blockchainFrom, blockchainFrom) ||
                other.blockchainFrom == blockchainFrom) &&
            (identical(other.blockchainTo, blockchainTo) ||
                other.blockchainTo == blockchainTo) &&
            (identical(other.tokenToBridge, tokenToBridge) ||
                other.tokenToBridge == tokenToBridge) &&
            (identical(other.tokenToBridgeAmount, tokenToBridgeAmount) ||
                other.tokenToBridgeAmount == tokenToBridgeAmount) &&
            (identical(other.targetAddress, targetAddress) ||
                other.targetAddress == targetAddress) &&
            (identical(
                    other.tokenToBridgeAmountFiat, tokenToBridgeAmountFiat) ||
                other.tokenToBridgeAmountFiat == tokenToBridgeAmountFiat) &&
            (identical(other.networkFees, networkFees) ||
                other.networkFees == networkFees) &&
            (identical(other.networkFeesFiat, networkFeesFiat) ||
                other.networkFeesFiat == networkFeesFiat) &&
            (identical(other.tokenToBridgeBalance, tokenToBridgeBalance) ||
                other.tokenToBridgeBalance == tokenToBridgeBalance) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      bridgeProcessStep,
      blockchainFrom,
      blockchainTo,
      tokenToBridge,
      tokenToBridgeAmount,
      targetAddress,
      tokenToBridgeAmountFiat,
      networkFees,
      networkFeesFiat,
      tokenToBridgeBalance,
      errorText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BridgeFormStateCopyWith<_$_BridgeFormState> get copyWith =>
      __$$_BridgeFormStateCopyWithImpl<_$_BridgeFormState>(this, _$identity);
}

abstract class _BridgeFormState extends BridgeFormState {
  const factory _BridgeFormState(
      {final BridgeProcessStep bridgeProcessStep,
      final BridgeBlockchain? blockchainFrom,
      final BridgeBlockchain? blockchainTo,
      final BridgeToken? tokenToBridge,
      final double tokenToBridgeAmount,
      final String targetAddress,
      final double tokenToBridgeAmountFiat,
      final double networkFees,
      final double networkFeesFiat,
      final double tokenToBridgeBalance,
      final String errorText}) = _$_BridgeFormState;
  const _BridgeFormState._() : super._();

  @override
  BridgeProcessStep get bridgeProcessStep;
  @override
  BridgeBlockchain? get blockchainFrom;
  @override
  BridgeBlockchain? get blockchainTo;
  @override
  BridgeToken? get tokenToBridge;
  @override
  double get tokenToBridgeAmount;
  @override
  String get targetAddress;
  @override
  double get tokenToBridgeAmountFiat;
  @override
  double get networkFees;
  @override
  double get networkFeesFiat;
  @override
  double get tokenToBridgeBalance;
  @override
  String get errorText;
  @override
  @JsonKey(ignore: true)
  _$$_BridgeFormStateCopyWith<_$_BridgeFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

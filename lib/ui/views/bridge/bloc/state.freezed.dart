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

BridgeFormState _$BridgeFormStateFromJson(Map<String, dynamic> json) {
  return _BridgeFormState.fromJson(json);
}

/// @nodoc
mixin _$BridgeFormState {
  BridgeProcessStep get bridgeProcessStep => throw _privateConstructorUsedError;
  @BridgeBlockchainJsonConverter()
  BridgeBlockchain? get blockchainFrom => throw _privateConstructorUsedError;
  @BridgeBlockchainJsonConverter()
  BridgeBlockchain? get blockchainTo => throw _privateConstructorUsedError;
  @BridgeTokenJsonConverter()
  BridgeToken? get tokenToBridge => throw _privateConstructorUsedError;
  double get tokenToBridgeAmount => throw _privateConstructorUsedError;
  String get targetAddress => throw _privateConstructorUsedError;
  double get tokenToBridgeAmountFiat => throw _privateConstructorUsedError;
  double get networkFees => throw _privateConstructorUsedError;
  double get networkFeesFiat => throw _privateConstructorUsedError;
  double get tokenToBridgeBalance => throw _privateConstructorUsedError;
  @FailureJsonConverter()
  Failure? get failure => throw _privateConstructorUsedError;
  bool get isTransferInProgress => throw _privateConstructorUsedError;
  WaitForWalletConfirmation? get waitForWalletConfirmation =>
      throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  bool get changeDirectionInProgress => throw _privateConstructorUsedError;
  int? get timestampExec => throw _privateConstructorUsedError;
  @ArchethicOracleUCOJsonConverter()
  ArchethicOracleUCO? get archethicOracleUCO =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
      @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainFrom,
      @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainTo,
      @BridgeTokenJsonConverter() BridgeToken? tokenToBridge,
      double tokenToBridgeAmount,
      String targetAddress,
      double tokenToBridgeAmountFiat,
      double networkFees,
      double networkFeesFiat,
      double tokenToBridgeBalance,
      @FailureJsonConverter() Failure? failure,
      bool isTransferInProgress,
      WaitForWalletConfirmation? waitForWalletConfirmation,
      int currentStep,
      bool changeDirectionInProgress,
      int? timestampExec,
      @ArchethicOracleUCOJsonConverter()
      ArchethicOracleUCO? archethicOracleUCO});

  $BridgeBlockchainCopyWith<$Res>? get blockchainFrom;
  $BridgeBlockchainCopyWith<$Res>? get blockchainTo;
  $BridgeTokenCopyWith<$Res>? get tokenToBridge;
  $FailureCopyWith<$Res>? get failure;
  $ArchethicOracleUCOCopyWith<$Res>? get archethicOracleUCO;
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
    Object? failure = freezed,
    Object? isTransferInProgress = null,
    Object? waitForWalletConfirmation = freezed,
    Object? currentStep = null,
    Object? changeDirectionInProgress = null,
    Object? timestampExec = freezed,
    Object? archethicOracleUCO = freezed,
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
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      isTransferInProgress: null == isTransferInProgress
          ? _value.isTransferInProgress
          : isTransferInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      waitForWalletConfirmation: freezed == waitForWalletConfirmation
          ? _value.waitForWalletConfirmation
          : waitForWalletConfirmation // ignore: cast_nullable_to_non_nullable
              as WaitForWalletConfirmation?,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      changeDirectionInProgress: null == changeDirectionInProgress
          ? _value.changeDirectionInProgress
          : changeDirectionInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      timestampExec: freezed == timestampExec
          ? _value.timestampExec
          : timestampExec // ignore: cast_nullable_to_non_nullable
              as int?,
      archethicOracleUCO: freezed == archethicOracleUCO
          ? _value.archethicOracleUCO
          : archethicOracleUCO // ignore: cast_nullable_to_non_nullable
              as ArchethicOracleUCO?,
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

  @override
  @pragma('vm:prefer-inline')
  $ArchethicOracleUCOCopyWith<$Res>? get archethicOracleUCO {
    if (_value.archethicOracleUCO == null) {
      return null;
    }

    return $ArchethicOracleUCOCopyWith<$Res>(_value.archethicOracleUCO!,
        (value) {
      return _then(_value.copyWith(archethicOracleUCO: value) as $Val);
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
      @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainFrom,
      @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainTo,
      @BridgeTokenJsonConverter() BridgeToken? tokenToBridge,
      double tokenToBridgeAmount,
      String targetAddress,
      double tokenToBridgeAmountFiat,
      double networkFees,
      double networkFeesFiat,
      double tokenToBridgeBalance,
      @FailureJsonConverter() Failure? failure,
      bool isTransferInProgress,
      WaitForWalletConfirmation? waitForWalletConfirmation,
      int currentStep,
      bool changeDirectionInProgress,
      int? timestampExec,
      @ArchethicOracleUCOJsonConverter()
      ArchethicOracleUCO? archethicOracleUCO});

  @override
  $BridgeBlockchainCopyWith<$Res>? get blockchainFrom;
  @override
  $BridgeBlockchainCopyWith<$Res>? get blockchainTo;
  @override
  $BridgeTokenCopyWith<$Res>? get tokenToBridge;
  @override
  $FailureCopyWith<$Res>? get failure;
  @override
  $ArchethicOracleUCOCopyWith<$Res>? get archethicOracleUCO;
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
    Object? failure = freezed,
    Object? isTransferInProgress = null,
    Object? waitForWalletConfirmation = freezed,
    Object? currentStep = null,
    Object? changeDirectionInProgress = null,
    Object? timestampExec = freezed,
    Object? archethicOracleUCO = freezed,
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
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      isTransferInProgress: null == isTransferInProgress
          ? _value.isTransferInProgress
          : isTransferInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      waitForWalletConfirmation: freezed == waitForWalletConfirmation
          ? _value.waitForWalletConfirmation
          : waitForWalletConfirmation // ignore: cast_nullable_to_non_nullable
              as WaitForWalletConfirmation?,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      changeDirectionInProgress: null == changeDirectionInProgress
          ? _value.changeDirectionInProgress
          : changeDirectionInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      timestampExec: freezed == timestampExec
          ? _value.timestampExec
          : timestampExec // ignore: cast_nullable_to_non_nullable
              as int?,
      archethicOracleUCO: freezed == archethicOracleUCO
          ? _value.archethicOracleUCO
          : archethicOracleUCO // ignore: cast_nullable_to_non_nullable
              as ArchethicOracleUCO?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BridgeFormState extends _BridgeFormState {
  const _$_BridgeFormState(
      {this.bridgeProcessStep = BridgeProcessStep.form,
      @BridgeBlockchainJsonConverter() this.blockchainFrom,
      @BridgeBlockchainJsonConverter() this.blockchainTo,
      @BridgeTokenJsonConverter() this.tokenToBridge,
      this.tokenToBridgeAmount = 0,
      this.targetAddress = '',
      this.tokenToBridgeAmountFiat = 0,
      this.networkFees = 0.0,
      this.networkFeesFiat = 0.0,
      this.tokenToBridgeBalance = 0,
      @FailureJsonConverter() this.failure,
      this.isTransferInProgress = false,
      this.waitForWalletConfirmation,
      this.currentStep = 0,
      this.changeDirectionInProgress = false,
      this.timestampExec,
      @ArchethicOracleUCOJsonConverter() this.archethicOracleUCO})
      : super._();

  factory _$_BridgeFormState.fromJson(Map<String, dynamic> json) =>
      _$$_BridgeFormStateFromJson(json);

  @override
  @JsonKey()
  final BridgeProcessStep bridgeProcessStep;
  @override
  @BridgeBlockchainJsonConverter()
  final BridgeBlockchain? blockchainFrom;
  @override
  @BridgeBlockchainJsonConverter()
  final BridgeBlockchain? blockchainTo;
  @override
  @BridgeTokenJsonConverter()
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
  @FailureJsonConverter()
  final Failure? failure;
  @override
  @JsonKey()
  final bool isTransferInProgress;
  @override
  final WaitForWalletConfirmation? waitForWalletConfirmation;
  @override
  @JsonKey()
  final int currentStep;
  @override
  @JsonKey()
  final bool changeDirectionInProgress;
  @override
  final int? timestampExec;
  @override
  @ArchethicOracleUCOJsonConverter()
  final ArchethicOracleUCO? archethicOracleUCO;

  @override
  String toString() {
    return 'BridgeFormState(bridgeProcessStep: $bridgeProcessStep, blockchainFrom: $blockchainFrom, blockchainTo: $blockchainTo, tokenToBridge: $tokenToBridge, tokenToBridgeAmount: $tokenToBridgeAmount, targetAddress: $targetAddress, tokenToBridgeAmountFiat: $tokenToBridgeAmountFiat, networkFees: $networkFees, networkFeesFiat: $networkFeesFiat, tokenToBridgeBalance: $tokenToBridgeBalance, failure: $failure, isTransferInProgress: $isTransferInProgress, waitForWalletConfirmation: $waitForWalletConfirmation, currentStep: $currentStep, changeDirectionInProgress: $changeDirectionInProgress, timestampExec: $timestampExec, archethicOracleUCO: $archethicOracleUCO)';
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
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.isTransferInProgress, isTransferInProgress) ||
                other.isTransferInProgress == isTransferInProgress) &&
            (identical(other.waitForWalletConfirmation,
                    waitForWalletConfirmation) ||
                other.waitForWalletConfirmation == waitForWalletConfirmation) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.changeDirectionInProgress,
                    changeDirectionInProgress) ||
                other.changeDirectionInProgress == changeDirectionInProgress) &&
            (identical(other.timestampExec, timestampExec) ||
                other.timestampExec == timestampExec) &&
            (identical(other.archethicOracleUCO, archethicOracleUCO) ||
                other.archethicOracleUCO == archethicOracleUCO));
  }

  @JsonKey(ignore: true)
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
      failure,
      isTransferInProgress,
      waitForWalletConfirmation,
      currentStep,
      changeDirectionInProgress,
      timestampExec,
      archethicOracleUCO);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BridgeFormStateCopyWith<_$_BridgeFormState> get copyWith =>
      __$$_BridgeFormStateCopyWithImpl<_$_BridgeFormState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BridgeFormStateToJson(
      this,
    );
  }
}

abstract class _BridgeFormState extends BridgeFormState {
  const factory _BridgeFormState(
      {final BridgeProcessStep bridgeProcessStep,
      @BridgeBlockchainJsonConverter() final BridgeBlockchain? blockchainFrom,
      @BridgeBlockchainJsonConverter() final BridgeBlockchain? blockchainTo,
      @BridgeTokenJsonConverter() final BridgeToken? tokenToBridge,
      final double tokenToBridgeAmount,
      final String targetAddress,
      final double tokenToBridgeAmountFiat,
      final double networkFees,
      final double networkFeesFiat,
      final double tokenToBridgeBalance,
      @FailureJsonConverter() final Failure? failure,
      final bool isTransferInProgress,
      final WaitForWalletConfirmation? waitForWalletConfirmation,
      final int currentStep,
      final bool changeDirectionInProgress,
      final int? timestampExec,
      @ArchethicOracleUCOJsonConverter()
      final ArchethicOracleUCO? archethicOracleUCO}) = _$_BridgeFormState;
  const _BridgeFormState._() : super._();

  factory _BridgeFormState.fromJson(Map<String, dynamic> json) =
      _$_BridgeFormState.fromJson;

  @override
  BridgeProcessStep get bridgeProcessStep;
  @override
  @BridgeBlockchainJsonConverter()
  BridgeBlockchain? get blockchainFrom;
  @override
  @BridgeBlockchainJsonConverter()
  BridgeBlockchain? get blockchainTo;
  @override
  @BridgeTokenJsonConverter()
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
  @FailureJsonConverter()
  Failure? get failure;
  @override
  bool get isTransferInProgress;
  @override
  WaitForWalletConfirmation? get waitForWalletConfirmation;
  @override
  int get currentStep;
  @override
  bool get changeDirectionInProgress;
  @override
  int? get timestampExec;
  @override
  @ArchethicOracleUCOJsonConverter()
  ArchethicOracleUCO? get archethicOracleUCO;
  @override
  @JsonKey(ignore: true)
  _$$_BridgeFormStateCopyWith<_$_BridgeFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

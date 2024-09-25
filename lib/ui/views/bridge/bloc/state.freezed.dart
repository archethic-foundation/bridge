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

BridgeFormState _$BridgeFormStateFromJson(Map<String, dynamic> json) {
  return _BridgeFormState.fromJson(json);
}

/// @nodoc
mixin _$BridgeFormState {
  bool get resumeProcess => throw _privateConstructorUsedError;
  ProcessStep get processStep => throw _privateConstructorUsedError;
  @BridgeBlockchainJsonConverter()
  BridgeBlockchain? get blockchainFrom => throw _privateConstructorUsedError;
  @BridgeBlockchainJsonConverter()
  BridgeBlockchain? get blockchainTo => throw _privateConstructorUsedError;
  @BridgeTokenJsonConverter()
  BridgeToken? get tokenToBridge => throw _privateConstructorUsedError;
  double get tokenToBridgeAmount => throw _privateConstructorUsedError;
  String get targetAddress => throw _privateConstructorUsedError;
  double get tokenToBridgeBalance => throw _privateConstructorUsedError;
  double get tokenBridgedBalance => throw _privateConstructorUsedError;
  double get poolTargetBalance => throw _privateConstructorUsedError;
  bool get poolTargetMintAndBurn => throw _privateConstructorUsedError;
  int get tokenToBridgeDecimals => throw _privateConstructorUsedError;
  int get tokenBridgedDecimals => throw _privateConstructorUsedError;
  @FailureJsonConverter()
  Failure? get failure => throw _privateConstructorUsedError;
  bool get isTransferInProgress => throw _privateConstructorUsedError;
  WalletConfirmation? get walletConfirmation =>
      throw _privateConstructorUsedError;
  bool get bridgeOk => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  bool get changeDirectionInProgress => throw _privateConstructorUsedError;
  int? get timestampExec => throw _privateConstructorUsedError;
  @ArchethicOracleUCOJsonConverter()
  ArchethicOracleUCO? get archethicOracleUCO =>
      throw _privateConstructorUsedError;
  String? get htlcAEAddress => throw _privateConstructorUsedError;
  String? get htlcEVMAddress => throw _privateConstructorUsedError;
  String? get htlcEVMTxAddress => throw _privateConstructorUsedError;
  List<int>? get secret => throw _privateConstructorUsedError;
  double get archethicProtocolFeesRate => throw _privateConstructorUsedError;
  String get archethicProtocolFeesAddress => throw _privateConstructorUsedError;
  double get archethicTransactionFees => throw _privateConstructorUsedError;
  double get feesEstimatedUCO => throw _privateConstructorUsedError;
  bool get messageMaxHalfUCO => throw _privateConstructorUsedError;
  bool get controlInProgress => throw _privateConstructorUsedError;
  DateTime? get consentDateTime => throw _privateConstructorUsedError;
  bool get requestTooLong => throw _privateConstructorUsedError;
  double get ucoV1Balance => throw _privateConstructorUsedError;

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
      {bool resumeProcess,
      ProcessStep processStep,
      @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainFrom,
      @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainTo,
      @BridgeTokenJsonConverter() BridgeToken? tokenToBridge,
      double tokenToBridgeAmount,
      String targetAddress,
      double tokenToBridgeBalance,
      double tokenBridgedBalance,
      double poolTargetBalance,
      bool poolTargetMintAndBurn,
      int tokenToBridgeDecimals,
      int tokenBridgedDecimals,
      @FailureJsonConverter() Failure? failure,
      bool isTransferInProgress,
      WalletConfirmation? walletConfirmation,
      bool bridgeOk,
      int currentStep,
      bool changeDirectionInProgress,
      int? timestampExec,
      @ArchethicOracleUCOJsonConverter() ArchethicOracleUCO? archethicOracleUCO,
      String? htlcAEAddress,
      String? htlcEVMAddress,
      String? htlcEVMTxAddress,
      List<int>? secret,
      double archethicProtocolFeesRate,
      String archethicProtocolFeesAddress,
      double archethicTransactionFees,
      double feesEstimatedUCO,
      bool messageMaxHalfUCO,
      bool controlInProgress,
      DateTime? consentDateTime,
      bool requestTooLong,
      double ucoV1Balance});

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
    Object? resumeProcess = null,
    Object? processStep = null,
    Object? blockchainFrom = freezed,
    Object? blockchainTo = freezed,
    Object? tokenToBridge = freezed,
    Object? tokenToBridgeAmount = null,
    Object? targetAddress = null,
    Object? tokenToBridgeBalance = null,
    Object? tokenBridgedBalance = null,
    Object? poolTargetBalance = null,
    Object? poolTargetMintAndBurn = null,
    Object? tokenToBridgeDecimals = null,
    Object? tokenBridgedDecimals = null,
    Object? failure = freezed,
    Object? isTransferInProgress = null,
    Object? walletConfirmation = freezed,
    Object? bridgeOk = null,
    Object? currentStep = null,
    Object? changeDirectionInProgress = null,
    Object? timestampExec = freezed,
    Object? archethicOracleUCO = freezed,
    Object? htlcAEAddress = freezed,
    Object? htlcEVMAddress = freezed,
    Object? htlcEVMTxAddress = freezed,
    Object? secret = freezed,
    Object? archethicProtocolFeesRate = null,
    Object? archethicProtocolFeesAddress = null,
    Object? archethicTransactionFees = null,
    Object? feesEstimatedUCO = null,
    Object? messageMaxHalfUCO = null,
    Object? controlInProgress = null,
    Object? consentDateTime = freezed,
    Object? requestTooLong = null,
    Object? ucoV1Balance = null,
  }) {
    return _then(_value.copyWith(
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      processStep: null == processStep
          ? _value.processStep
          : processStep // ignore: cast_nullable_to_non_nullable
              as ProcessStep,
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
      tokenToBridgeBalance: null == tokenToBridgeBalance
          ? _value.tokenToBridgeBalance
          : tokenToBridgeBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tokenBridgedBalance: null == tokenBridgedBalance
          ? _value.tokenBridgedBalance
          : tokenBridgedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      poolTargetBalance: null == poolTargetBalance
          ? _value.poolTargetBalance
          : poolTargetBalance // ignore: cast_nullable_to_non_nullable
              as double,
      poolTargetMintAndBurn: null == poolTargetMintAndBurn
          ? _value.poolTargetMintAndBurn
          : poolTargetMintAndBurn // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenToBridgeDecimals: null == tokenToBridgeDecimals
          ? _value.tokenToBridgeDecimals
          : tokenToBridgeDecimals // ignore: cast_nullable_to_non_nullable
              as int,
      tokenBridgedDecimals: null == tokenBridgedDecimals
          ? _value.tokenBridgedDecimals
          : tokenBridgedDecimals // ignore: cast_nullable_to_non_nullable
              as int,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      isTransferInProgress: null == isTransferInProgress
          ? _value.isTransferInProgress
          : isTransferInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: freezed == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as WalletConfirmation?,
      bridgeOk: null == bridgeOk
          ? _value.bridgeOk
          : bridgeOk // ignore: cast_nullable_to_non_nullable
              as bool,
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
      htlcAEAddress: freezed == htlcAEAddress
          ? _value.htlcAEAddress
          : htlcAEAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      htlcEVMAddress: freezed == htlcEVMAddress
          ? _value.htlcEVMAddress
          : htlcEVMAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      htlcEVMTxAddress: freezed == htlcEVMTxAddress
          ? _value.htlcEVMTxAddress
          : htlcEVMTxAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      archethicProtocolFeesRate: null == archethicProtocolFeesRate
          ? _value.archethicProtocolFeesRate
          : archethicProtocolFeesRate // ignore: cast_nullable_to_non_nullable
              as double,
      archethicProtocolFeesAddress: null == archethicProtocolFeesAddress
          ? _value.archethicProtocolFeesAddress
          : archethicProtocolFeesAddress // ignore: cast_nullable_to_non_nullable
              as String,
      archethicTransactionFees: null == archethicTransactionFees
          ? _value.archethicTransactionFees
          : archethicTransactionFees // ignore: cast_nullable_to_non_nullable
              as double,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      messageMaxHalfUCO: null == messageMaxHalfUCO
          ? _value.messageMaxHalfUCO
          : messageMaxHalfUCO // ignore: cast_nullable_to_non_nullable
              as bool,
      controlInProgress: null == controlInProgress
          ? _value.controlInProgress
          : controlInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requestTooLong: null == requestTooLong
          ? _value.requestTooLong
          : requestTooLong // ignore: cast_nullable_to_non_nullable
              as bool,
      ucoV1Balance: null == ucoV1Balance
          ? _value.ucoV1Balance
          : ucoV1Balance // ignore: cast_nullable_to_non_nullable
              as double,
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
abstract class _$$BridgeFormStateImplCopyWith<$Res>
    implements $BridgeFormStateCopyWith<$Res> {
  factory _$$BridgeFormStateImplCopyWith(_$BridgeFormStateImpl value,
          $Res Function(_$BridgeFormStateImpl) then) =
      __$$BridgeFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool resumeProcess,
      ProcessStep processStep,
      @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainFrom,
      @BridgeBlockchainJsonConverter() BridgeBlockchain? blockchainTo,
      @BridgeTokenJsonConverter() BridgeToken? tokenToBridge,
      double tokenToBridgeAmount,
      String targetAddress,
      double tokenToBridgeBalance,
      double tokenBridgedBalance,
      double poolTargetBalance,
      bool poolTargetMintAndBurn,
      int tokenToBridgeDecimals,
      int tokenBridgedDecimals,
      @FailureJsonConverter() Failure? failure,
      bool isTransferInProgress,
      WalletConfirmation? walletConfirmation,
      bool bridgeOk,
      int currentStep,
      bool changeDirectionInProgress,
      int? timestampExec,
      @ArchethicOracleUCOJsonConverter() ArchethicOracleUCO? archethicOracleUCO,
      String? htlcAEAddress,
      String? htlcEVMAddress,
      String? htlcEVMTxAddress,
      List<int>? secret,
      double archethicProtocolFeesRate,
      String archethicProtocolFeesAddress,
      double archethicTransactionFees,
      double feesEstimatedUCO,
      bool messageMaxHalfUCO,
      bool controlInProgress,
      DateTime? consentDateTime,
      bool requestTooLong,
      double ucoV1Balance});

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
class __$$BridgeFormStateImplCopyWithImpl<$Res>
    extends _$BridgeFormStateCopyWithImpl<$Res, _$BridgeFormStateImpl>
    implements _$$BridgeFormStateImplCopyWith<$Res> {
  __$$BridgeFormStateImplCopyWithImpl(
      _$BridgeFormStateImpl _value, $Res Function(_$BridgeFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resumeProcess = null,
    Object? processStep = null,
    Object? blockchainFrom = freezed,
    Object? blockchainTo = freezed,
    Object? tokenToBridge = freezed,
    Object? tokenToBridgeAmount = null,
    Object? targetAddress = null,
    Object? tokenToBridgeBalance = null,
    Object? tokenBridgedBalance = null,
    Object? poolTargetBalance = null,
    Object? poolTargetMintAndBurn = null,
    Object? tokenToBridgeDecimals = null,
    Object? tokenBridgedDecimals = null,
    Object? failure = freezed,
    Object? isTransferInProgress = null,
    Object? walletConfirmation = freezed,
    Object? bridgeOk = null,
    Object? currentStep = null,
    Object? changeDirectionInProgress = null,
    Object? timestampExec = freezed,
    Object? archethicOracleUCO = freezed,
    Object? htlcAEAddress = freezed,
    Object? htlcEVMAddress = freezed,
    Object? htlcEVMTxAddress = freezed,
    Object? secret = freezed,
    Object? archethicProtocolFeesRate = null,
    Object? archethicProtocolFeesAddress = null,
    Object? archethicTransactionFees = null,
    Object? feesEstimatedUCO = null,
    Object? messageMaxHalfUCO = null,
    Object? controlInProgress = null,
    Object? consentDateTime = freezed,
    Object? requestTooLong = null,
    Object? ucoV1Balance = null,
  }) {
    return _then(_$BridgeFormStateImpl(
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      processStep: null == processStep
          ? _value.processStep
          : processStep // ignore: cast_nullable_to_non_nullable
              as ProcessStep,
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
      tokenToBridgeBalance: null == tokenToBridgeBalance
          ? _value.tokenToBridgeBalance
          : tokenToBridgeBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tokenBridgedBalance: null == tokenBridgedBalance
          ? _value.tokenBridgedBalance
          : tokenBridgedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      poolTargetBalance: null == poolTargetBalance
          ? _value.poolTargetBalance
          : poolTargetBalance // ignore: cast_nullable_to_non_nullable
              as double,
      poolTargetMintAndBurn: null == poolTargetMintAndBurn
          ? _value.poolTargetMintAndBurn
          : poolTargetMintAndBurn // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenToBridgeDecimals: null == tokenToBridgeDecimals
          ? _value.tokenToBridgeDecimals
          : tokenToBridgeDecimals // ignore: cast_nullable_to_non_nullable
              as int,
      tokenBridgedDecimals: null == tokenBridgedDecimals
          ? _value.tokenBridgedDecimals
          : tokenBridgedDecimals // ignore: cast_nullable_to_non_nullable
              as int,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      isTransferInProgress: null == isTransferInProgress
          ? _value.isTransferInProgress
          : isTransferInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      walletConfirmation: freezed == walletConfirmation
          ? _value.walletConfirmation
          : walletConfirmation // ignore: cast_nullable_to_non_nullable
              as WalletConfirmation?,
      bridgeOk: null == bridgeOk
          ? _value.bridgeOk
          : bridgeOk // ignore: cast_nullable_to_non_nullable
              as bool,
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
      htlcAEAddress: freezed == htlcAEAddress
          ? _value.htlcAEAddress
          : htlcAEAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      htlcEVMAddress: freezed == htlcEVMAddress
          ? _value.htlcEVMAddress
          : htlcEVMAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      htlcEVMTxAddress: freezed == htlcEVMTxAddress
          ? _value.htlcEVMTxAddress
          : htlcEVMTxAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      secret: freezed == secret
          ? _value._secret
          : secret // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      archethicProtocolFeesRate: null == archethicProtocolFeesRate
          ? _value.archethicProtocolFeesRate
          : archethicProtocolFeesRate // ignore: cast_nullable_to_non_nullable
              as double,
      archethicProtocolFeesAddress: null == archethicProtocolFeesAddress
          ? _value.archethicProtocolFeesAddress
          : archethicProtocolFeesAddress // ignore: cast_nullable_to_non_nullable
              as String,
      archethicTransactionFees: null == archethicTransactionFees
          ? _value.archethicTransactionFees
          : archethicTransactionFees // ignore: cast_nullable_to_non_nullable
              as double,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      messageMaxHalfUCO: null == messageMaxHalfUCO
          ? _value.messageMaxHalfUCO
          : messageMaxHalfUCO // ignore: cast_nullable_to_non_nullable
              as bool,
      controlInProgress: null == controlInProgress
          ? _value.controlInProgress
          : controlInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      requestTooLong: null == requestTooLong
          ? _value.requestTooLong
          : requestTooLong // ignore: cast_nullable_to_non_nullable
              as bool,
      ucoV1Balance: null == ucoV1Balance
          ? _value.ucoV1Balance
          : ucoV1Balance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BridgeFormStateImpl extends _BridgeFormState {
  const _$BridgeFormStateImpl(
      {this.resumeProcess = false,
      this.processStep = ProcessStep.form,
      @BridgeBlockchainJsonConverter() this.blockchainFrom,
      @BridgeBlockchainJsonConverter() this.blockchainTo,
      @BridgeTokenJsonConverter() this.tokenToBridge,
      this.tokenToBridgeAmount = 0,
      this.targetAddress = '',
      this.tokenToBridgeBalance = 0,
      this.tokenBridgedBalance = 0,
      this.poolTargetBalance = 0,
      this.poolTargetMintAndBurn = false,
      this.tokenToBridgeDecimals = 8,
      this.tokenBridgedDecimals = 8,
      @FailureJsonConverter() this.failure,
      this.isTransferInProgress = false,
      this.walletConfirmation,
      this.bridgeOk = false,
      this.currentStep = 0,
      this.changeDirectionInProgress = false,
      this.timestampExec,
      @ArchethicOracleUCOJsonConverter() this.archethicOracleUCO,
      this.htlcAEAddress,
      this.htlcEVMAddress,
      this.htlcEVMTxAddress,
      final List<int>? secret,
      this.archethicProtocolFeesRate = 0.0,
      this.archethicProtocolFeesAddress = '',
      this.archethicTransactionFees = 0.0,
      this.feesEstimatedUCO = 0.0,
      this.messageMaxHalfUCO = false,
      this.controlInProgress = false,
      this.consentDateTime,
      this.requestTooLong = false,
      this.ucoV1Balance = 0})
      : _secret = secret,
        super._();

  factory _$BridgeFormStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BridgeFormStateImplFromJson(json);

  @override
  @JsonKey()
  final bool resumeProcess;
  @override
  @JsonKey()
  final ProcessStep processStep;
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
  final double tokenToBridgeBalance;
  @override
  @JsonKey()
  final double tokenBridgedBalance;
  @override
  @JsonKey()
  final double poolTargetBalance;
  @override
  @JsonKey()
  final bool poolTargetMintAndBurn;
  @override
  @JsonKey()
  final int tokenToBridgeDecimals;
  @override
  @JsonKey()
  final int tokenBridgedDecimals;
  @override
  @FailureJsonConverter()
  final Failure? failure;
  @override
  @JsonKey()
  final bool isTransferInProgress;
  @override
  final WalletConfirmation? walletConfirmation;
  @override
  @JsonKey()
  final bool bridgeOk;
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
  final String? htlcAEAddress;
  @override
  final String? htlcEVMAddress;
  @override
  final String? htlcEVMTxAddress;
  final List<int>? _secret;
  @override
  List<int>? get secret {
    final value = _secret;
    if (value == null) return null;
    if (_secret is EqualUnmodifiableListView) return _secret;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final double archethicProtocolFeesRate;
  @override
  @JsonKey()
  final String archethicProtocolFeesAddress;
  @override
  @JsonKey()
  final double archethicTransactionFees;
  @override
  @JsonKey()
  final double feesEstimatedUCO;
  @override
  @JsonKey()
  final bool messageMaxHalfUCO;
  @override
  @JsonKey()
  final bool controlInProgress;
  @override
  final DateTime? consentDateTime;
  @override
  @JsonKey()
  final bool requestTooLong;
  @override
  @JsonKey()
  final double ucoV1Balance;

  @override
  String toString() {
    return 'BridgeFormState(resumeProcess: $resumeProcess, processStep: $processStep, blockchainFrom: $blockchainFrom, blockchainTo: $blockchainTo, tokenToBridge: $tokenToBridge, tokenToBridgeAmount: $tokenToBridgeAmount, targetAddress: $targetAddress, tokenToBridgeBalance: $tokenToBridgeBalance, tokenBridgedBalance: $tokenBridgedBalance, poolTargetBalance: $poolTargetBalance, poolTargetMintAndBurn: $poolTargetMintAndBurn, tokenToBridgeDecimals: $tokenToBridgeDecimals, tokenBridgedDecimals: $tokenBridgedDecimals, failure: $failure, isTransferInProgress: $isTransferInProgress, walletConfirmation: $walletConfirmation, bridgeOk: $bridgeOk, currentStep: $currentStep, changeDirectionInProgress: $changeDirectionInProgress, timestampExec: $timestampExec, archethicOracleUCO: $archethicOracleUCO, htlcAEAddress: $htlcAEAddress, htlcEVMAddress: $htlcEVMAddress, htlcEVMTxAddress: $htlcEVMTxAddress, secret: $secret, archethicProtocolFeesRate: $archethicProtocolFeesRate, archethicProtocolFeesAddress: $archethicProtocolFeesAddress, archethicTransactionFees: $archethicTransactionFees, feesEstimatedUCO: $feesEstimatedUCO, messageMaxHalfUCO: $messageMaxHalfUCO, controlInProgress: $controlInProgress, consentDateTime: $consentDateTime, requestTooLong: $requestTooLong, ucoV1Balance: $ucoV1Balance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BridgeFormStateImpl &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.processStep, processStep) ||
                other.processStep == processStep) &&
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
            (identical(other.tokenToBridgeBalance, tokenToBridgeBalance) ||
                other.tokenToBridgeBalance == tokenToBridgeBalance) &&
            (identical(other.tokenBridgedBalance, tokenBridgedBalance) ||
                other.tokenBridgedBalance == tokenBridgedBalance) &&
            (identical(other.poolTargetBalance, poolTargetBalance) ||
                other.poolTargetBalance == poolTargetBalance) &&
            (identical(other.poolTargetMintAndBurn, poolTargetMintAndBurn) ||
                other.poolTargetMintAndBurn == poolTargetMintAndBurn) &&
            (identical(other.tokenToBridgeDecimals, tokenToBridgeDecimals) ||
                other.tokenToBridgeDecimals == tokenToBridgeDecimals) &&
            (identical(other.tokenBridgedDecimals, tokenBridgedDecimals) ||
                other.tokenBridgedDecimals == tokenBridgedDecimals) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.isTransferInProgress, isTransferInProgress) ||
                other.isTransferInProgress == isTransferInProgress) &&
            (identical(other.walletConfirmation, walletConfirmation) ||
                other.walletConfirmation == walletConfirmation) &&
            (identical(other.bridgeOk, bridgeOk) ||
                other.bridgeOk == bridgeOk) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.changeDirectionInProgress, changeDirectionInProgress) ||
                other.changeDirectionInProgress == changeDirectionInProgress) &&
            (identical(other.timestampExec, timestampExec) ||
                other.timestampExec == timestampExec) &&
            (identical(other.archethicOracleUCO, archethicOracleUCO) ||
                other.archethicOracleUCO == archethicOracleUCO) &&
            (identical(other.htlcAEAddress, htlcAEAddress) ||
                other.htlcAEAddress == htlcAEAddress) &&
            (identical(other.htlcEVMAddress, htlcEVMAddress) ||
                other.htlcEVMAddress == htlcEVMAddress) &&
            (identical(other.htlcEVMTxAddress, htlcEVMTxAddress) ||
                other.htlcEVMTxAddress == htlcEVMTxAddress) &&
            const DeepCollectionEquality().equals(other._secret, _secret) &&
            (identical(other.archethicProtocolFeesRate, archethicProtocolFeesRate) ||
                other.archethicProtocolFeesRate == archethicProtocolFeesRate) &&
            (identical(other.archethicProtocolFeesAddress,
                    archethicProtocolFeesAddress) ||
                other.archethicProtocolFeesAddress ==
                    archethicProtocolFeesAddress) &&
            (identical(
                    other.archethicTransactionFees, archethicTransactionFees) ||
                other.archethicTransactionFees == archethicTransactionFees) &&
            (identical(other.feesEstimatedUCO, feesEstimatedUCO) ||
                other.feesEstimatedUCO == feesEstimatedUCO) &&
            (identical(other.messageMaxHalfUCO, messageMaxHalfUCO) ||
                other.messageMaxHalfUCO == messageMaxHalfUCO) &&
            (identical(other.controlInProgress, controlInProgress) ||
                other.controlInProgress == controlInProgress) &&
            (identical(other.consentDateTime, consentDateTime) ||
                other.consentDateTime == consentDateTime) &&
            (identical(other.requestTooLong, requestTooLong) ||
                other.requestTooLong == requestTooLong) &&
            (identical(other.ucoV1Balance, ucoV1Balance) ||
                other.ucoV1Balance == ucoV1Balance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        resumeProcess,
        processStep,
        blockchainFrom,
        blockchainTo,
        tokenToBridge,
        tokenToBridgeAmount,
        targetAddress,
        tokenToBridgeBalance,
        tokenBridgedBalance,
        poolTargetBalance,
        poolTargetMintAndBurn,
        tokenToBridgeDecimals,
        tokenBridgedDecimals,
        failure,
        isTransferInProgress,
        walletConfirmation,
        bridgeOk,
        currentStep,
        changeDirectionInProgress,
        timestampExec,
        archethicOracleUCO,
        htlcAEAddress,
        htlcEVMAddress,
        htlcEVMTxAddress,
        const DeepCollectionEquality().hash(_secret),
        archethicProtocolFeesRate,
        archethicProtocolFeesAddress,
        archethicTransactionFees,
        feesEstimatedUCO,
        messageMaxHalfUCO,
        controlInProgress,
        consentDateTime,
        requestTooLong,
        ucoV1Balance
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BridgeFormStateImplCopyWith<_$BridgeFormStateImpl> get copyWith =>
      __$$BridgeFormStateImplCopyWithImpl<_$BridgeFormStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BridgeFormStateImplToJson(
      this,
    );
  }
}

abstract class _BridgeFormState extends BridgeFormState {
  const factory _BridgeFormState(
      {final bool resumeProcess,
      final ProcessStep processStep,
      @BridgeBlockchainJsonConverter() final BridgeBlockchain? blockchainFrom,
      @BridgeBlockchainJsonConverter() final BridgeBlockchain? blockchainTo,
      @BridgeTokenJsonConverter() final BridgeToken? tokenToBridge,
      final double tokenToBridgeAmount,
      final String targetAddress,
      final double tokenToBridgeBalance,
      final double tokenBridgedBalance,
      final double poolTargetBalance,
      final bool poolTargetMintAndBurn,
      final int tokenToBridgeDecimals,
      final int tokenBridgedDecimals,
      @FailureJsonConverter() final Failure? failure,
      final bool isTransferInProgress,
      final WalletConfirmation? walletConfirmation,
      final bool bridgeOk,
      final int currentStep,
      final bool changeDirectionInProgress,
      final int? timestampExec,
      @ArchethicOracleUCOJsonConverter()
      final ArchethicOracleUCO? archethicOracleUCO,
      final String? htlcAEAddress,
      final String? htlcEVMAddress,
      final String? htlcEVMTxAddress,
      final List<int>? secret,
      final double archethicProtocolFeesRate,
      final String archethicProtocolFeesAddress,
      final double archethicTransactionFees,
      final double feesEstimatedUCO,
      final bool messageMaxHalfUCO,
      final bool controlInProgress,
      final DateTime? consentDateTime,
      final bool requestTooLong,
      final double ucoV1Balance}) = _$BridgeFormStateImpl;
  const _BridgeFormState._() : super._();

  factory _BridgeFormState.fromJson(Map<String, dynamic> json) =
      _$BridgeFormStateImpl.fromJson;

  @override
  bool get resumeProcess;
  @override
  ProcessStep get processStep;
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
  double get tokenToBridgeBalance;
  @override
  double get tokenBridgedBalance;
  @override
  double get poolTargetBalance;
  @override
  bool get poolTargetMintAndBurn;
  @override
  int get tokenToBridgeDecimals;
  @override
  int get tokenBridgedDecimals;
  @override
  @FailureJsonConverter()
  Failure? get failure;
  @override
  bool get isTransferInProgress;
  @override
  WalletConfirmation? get walletConfirmation;
  @override
  bool get bridgeOk;
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
  String? get htlcAEAddress;
  @override
  String? get htlcEVMAddress;
  @override
  String? get htlcEVMTxAddress;
  @override
  List<int>? get secret;
  @override
  double get archethicProtocolFeesRate;
  @override
  String get archethicProtocolFeesAddress;
  @override
  double get archethicTransactionFees;
  @override
  double get feesEstimatedUCO;
  @override
  bool get messageMaxHalfUCO;
  @override
  bool get controlInProgress;
  @override
  DateTime? get consentDateTime;
  @override
  bool get requestTooLong;
  @override
  double get ucoV1Balance;
  @override
  @JsonKey(ignore: true)
  _$$BridgeFormStateImplCopyWith<_$BridgeFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

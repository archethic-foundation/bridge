// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BridgeFormStateImpl _$$BridgeFormStateImplFromJson(
        Map<String, dynamic> json) =>
    _$BridgeFormStateImpl(
      resumeProcess: json['resumeProcess'] as bool? ?? false,
      processStep:
          $enumDecodeNullable(_$ProcessStepEnumMap, json['processStep']) ??
              ProcessStep.form,
      blockchainFrom:
          _$JsonConverterFromJson<Map<String, dynamic>, BridgeBlockchain>(
              json['blockchainFrom'],
              const BridgeBlockchainJsonConverter().fromJson),
      blockchainTo:
          _$JsonConverterFromJson<Map<String, dynamic>, BridgeBlockchain>(
              json['blockchainTo'],
              const BridgeBlockchainJsonConverter().fromJson),
      tokenToBridge: _$JsonConverterFromJson<Map<String, dynamic>, BridgeToken>(
          json['tokenToBridge'], const BridgeTokenJsonConverter().fromJson),
      tokenToBridgeAmount:
          (json['tokenToBridgeAmount'] as num?)?.toDouble() ?? 0,
      targetAddress: json['targetAddress'] as String? ?? '',
      tokenToBridgeBalance:
          (json['tokenToBridgeBalance'] as num?)?.toDouble() ?? 0,
      tokenBridgedBalance:
          (json['tokenBridgedBalance'] as num?)?.toDouble() ?? 0,
      poolTargetBalance: (json['poolTargetBalance'] as num?)?.toDouble() ?? 0,
      tokenToBridgeDecimals: json['tokenToBridgeDecimals'] as int? ?? 8,
      failure: _$JsonConverterFromJson<Map<String, dynamic>, Failure>(
          json['failure'], const FailureJsonConverter().fromJson),
      isTransferInProgress: json['isTransferInProgress'] as bool? ?? false,
      walletConfirmation: $enumDecodeNullable(
          _$WalletConfirmationEnumMap, json['walletConfirmation']),
      bridgeOk: json['bridgeOk'] as bool? ?? false,
      currentStep: json['currentStep'] as int? ?? 0,
      changeDirectionInProgress:
          json['changeDirectionInProgress'] as bool? ?? false,
      timestampExec: json['timestampExec'] as int?,
      archethicOracleUCO:
          _$JsonConverterFromJson<Map<String, dynamic>, ArchethicOracleUCO>(
              json['archethicOracleUCO'],
              const ArchethicOracleUCOJsonConverter().fromJson),
      htlcAEAddress: json['htlcAEAddress'] as String?,
      htlcEVMAddress: json['htlcEVMAddress'] as String?,
      htlcEVMTxAddress: json['htlcEVMTxAddress'] as String?,
      secret: (json['secret'] as List<dynamic>?)?.map((e) => e as int).toList(),
      safetyModuleFeesRate:
          (json['safetyModuleFeesRate'] as num?)?.toDouble() ?? 0.0,
      safetyModuleFeesAddress: json['safetyModuleFeesAddress'] as String? ?? '',
      archethicProtocolFeesRate:
          (json['archethicProtocolFeesRate'] as num?)?.toDouble() ?? 0.0,
      archethicProtocolFeesAddress:
          json['archethicProtocolFeesAddress'] as String? ?? '',
      archethicTransactionFees:
          (json['archethicTransactionFees'] as num?)?.toDouble() ?? 0.0,
      feesEstimatedUCO: (json['feesEstimatedUCO'] as num?)?.toDouble() ?? 0.0,
      messageMaxHalfUCO: json['messageMaxHalfUCO'] as bool? ?? false,
      consentDateTime: json['consentDateTime'] == null
          ? null
          : DateTime.parse(json['consentDateTime'] as String),
    );

Map<String, dynamic> _$$BridgeFormStateImplToJson(
        _$BridgeFormStateImpl instance) =>
    <String, dynamic>{
      'resumeProcess': instance.resumeProcess,
      'processStep': _$ProcessStepEnumMap[instance.processStep]!,
      'blockchainFrom':
          _$JsonConverterToJson<Map<String, dynamic>, BridgeBlockchain>(
              instance.blockchainFrom,
              const BridgeBlockchainJsonConverter().toJson),
      'blockchainTo':
          _$JsonConverterToJson<Map<String, dynamic>, BridgeBlockchain>(
              instance.blockchainTo,
              const BridgeBlockchainJsonConverter().toJson),
      'tokenToBridge': _$JsonConverterToJson<Map<String, dynamic>, BridgeToken>(
          instance.tokenToBridge, const BridgeTokenJsonConverter().toJson),
      'tokenToBridgeAmount': instance.tokenToBridgeAmount,
      'targetAddress': instance.targetAddress,
      'tokenToBridgeBalance': instance.tokenToBridgeBalance,
      'tokenBridgedBalance': instance.tokenBridgedBalance,
      'poolTargetBalance': instance.poolTargetBalance,
      'tokenToBridgeDecimals': instance.tokenToBridgeDecimals,
      'failure': _$JsonConverterToJson<Map<String, dynamic>, Failure>(
          instance.failure, const FailureJsonConverter().toJson),
      'isTransferInProgress': instance.isTransferInProgress,
      'walletConfirmation':
          _$WalletConfirmationEnumMap[instance.walletConfirmation],
      'bridgeOk': instance.bridgeOk,
      'currentStep': instance.currentStep,
      'changeDirectionInProgress': instance.changeDirectionInProgress,
      'timestampExec': instance.timestampExec,
      'archethicOracleUCO':
          _$JsonConverterToJson<Map<String, dynamic>, ArchethicOracleUCO>(
              instance.archethicOracleUCO,
              const ArchethicOracleUCOJsonConverter().toJson),
      'htlcAEAddress': instance.htlcAEAddress,
      'htlcEVMAddress': instance.htlcEVMAddress,
      'htlcEVMTxAddress': instance.htlcEVMTxAddress,
      'secret': instance.secret,
      'safetyModuleFeesRate': instance.safetyModuleFeesRate,
      'safetyModuleFeesAddress': instance.safetyModuleFeesAddress,
      'archethicProtocolFeesRate': instance.archethicProtocolFeesRate,
      'archethicProtocolFeesAddress': instance.archethicProtocolFeesAddress,
      'archethicTransactionFees': instance.archethicTransactionFees,
      'feesEstimatedUCO': instance.feesEstimatedUCO,
      'messageMaxHalfUCO': instance.messageMaxHalfUCO,
      'consentDateTime': instance.consentDateTime?.toIso8601String(),
    };

const _$ProcessStepEnumMap = {
  ProcessStep.form: 'form',
  ProcessStep.confirmation: 'confirmation',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$WalletConfirmationEnumMap = {
  WalletConfirmation.evm: 'evm',
  WalletConfirmation.archethic: 'archethic',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

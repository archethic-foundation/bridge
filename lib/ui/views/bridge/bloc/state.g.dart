// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BridgeFormState _$$_BridgeFormStateFromJson(Map<String, dynamic> json) =>
    _$_BridgeFormState(
      bridgeProcessStep: $enumDecodeNullable(
              _$BridgeProcessStepEnumMap, json['bridgeProcessStep']) ??
          BridgeProcessStep.form,
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
      tokenToBridgeAmountFiat:
          (json['tokenToBridgeAmountFiat'] as num?)?.toDouble() ?? 0,
      networkFees: (json['networkFees'] as num?)?.toDouble() ?? 0.0,
      networkFeesFiat: (json['networkFeesFiat'] as num?)?.toDouble() ?? 0.0,
      tokenToBridgeBalance:
          (json['tokenToBridgeBalance'] as num?)?.toDouble() ?? 0,
      failure: _$JsonConverterFromJson<Map<String, dynamic>, Failure>(
          json['failure'], const FailureJsonConverter().fromJson),
      isTransferInProgress: json['isTransferInProgress'] as bool? ?? false,
      waitForWalletConfirmation: $enumDecodeNullable(
          _$WaitForWalletConfirmationEnumMap,
          json['waitForWalletConfirmation']),
      currentStep: json['currentStep'] as int? ?? 0,
      changeDirectionInProgress:
          json['changeDirectionInProgress'] as bool? ?? false,
      timestampExec: json['timestampExec'] as int?,
    );

Map<String, dynamic> _$$_BridgeFormStateToJson(_$_BridgeFormState instance) =>
    <String, dynamic>{
      'bridgeProcessStep':
          _$BridgeProcessStepEnumMap[instance.bridgeProcessStep]!,
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
      'tokenToBridgeAmountFiat': instance.tokenToBridgeAmountFiat,
      'networkFees': instance.networkFees,
      'networkFeesFiat': instance.networkFeesFiat,
      'tokenToBridgeBalance': instance.tokenToBridgeBalance,
      'failure': _$JsonConverterToJson<Map<String, dynamic>, Failure>(
          instance.failure, const FailureJsonConverter().toJson),
      'isTransferInProgress': instance.isTransferInProgress,
      'waitForWalletConfirmation': _$WaitForWalletConfirmationEnumMap[
          instance.waitForWalletConfirmation],
      'currentStep': instance.currentStep,
      'changeDirectionInProgress': instance.changeDirectionInProgress,
      'timestampExec': instance.timestampExec,
    };

const _$BridgeProcessStepEnumMap = {
  BridgeProcessStep.form: 'form',
  BridgeProcessStep.confirmation: 'confirmation',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$WaitForWalletConfirmationEnumMap = {
  WaitForWalletConfirmation.evm: 'evm',
  WaitForWalletConfirmation.archethic: 'archethic',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

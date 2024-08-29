// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_contract_creation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetContractCreationResponseImpl _$$GetContractCreationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GetContractCreationResponseImpl(
      status: json['status'] as String,
      message: json['message'] as String,
      result: (json['result'] as List<dynamic>)
          .map((e) => GetContractCreationResponseResult.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GetContractCreationResponseImplToJson(
        _$GetContractCreationResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result,
    };

_$GetContractCreationResponseResultImpl
    _$$GetContractCreationResponseResultImplFromJson(
            Map<String, dynamic> json) =>
        _$GetContractCreationResponseResultImpl(
          contractAddress: json['contractAddress'] as String,
          contractCreator: json['contractCreator'] as String,
          txHash: json['txHash'] as String,
        );

Map<String, dynamic> _$$GetContractCreationResponseResultImplToJson(
        _$GetContractCreationResponseResultImpl instance) =>
    <String, dynamic>{
      'contractAddress': instance.contractAddress,
      'contractCreator': instance.contractCreator,
      'txHash': instance.txHash,
    };

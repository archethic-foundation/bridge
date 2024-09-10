// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeeLevelImpl _$$FeeLevelImplFromJson(Map<String, dynamic> json) =>
    _$FeeLevelImpl(
      suggestedMaxPriorityFeePerGas:
          json['suggestedMaxPriorityFeePerGas'] as String,
      suggestedMaxFeePerGas: json['suggestedMaxFeePerGas'] as String,
      minWaitTimeEstimate: (json['minWaitTimeEstimate'] as num).toInt(),
      maxWaitTimeEstimate: (json['maxWaitTimeEstimate'] as num).toInt(),
    );

Map<String, dynamic> _$$FeeLevelImplToJson(_$FeeLevelImpl instance) =>
    <String, dynamic>{
      'suggestedMaxPriorityFeePerGas': instance.suggestedMaxPriorityFeePerGas,
      'suggestedMaxFeePerGas': instance.suggestedMaxFeePerGas,
      'minWaitTimeEstimate': instance.minWaitTimeEstimate,
      'maxWaitTimeEstimate': instance.maxWaitTimeEstimate,
    };

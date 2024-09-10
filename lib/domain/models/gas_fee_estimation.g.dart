// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas_fee_estimation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GasFeeEstimationImpl _$$GasFeeEstimationImplFromJson(
        Map<String, dynamic> json) =>
    _$GasFeeEstimationImpl(
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      low: const FeeLevelJsonConverter()
          .fromJson(json['low'] as Map<String, dynamic>),
      medium: const FeeLevelJsonConverter()
          .fromJson(json['medium'] as Map<String, dynamic>),
      high: const FeeLevelJsonConverter()
          .fromJson(json['high'] as Map<String, dynamic>),
      estimatedBaseFee: json['estimatedBaseFee'] as String,
      networkCongestion: (json['networkCongestion'] as num).toDouble(),
      latestPriorityFeeRange: (json['latestPriorityFeeRange'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      historicalPriorityFeeRange:
          (json['historicalPriorityFeeRange'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      historicalBaseFeeRange: (json['historicalBaseFeeRange'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      priorityFeeTrend: json['priorityFeeTrend'] as String,
      baseFeeTrend: json['baseFeeTrend'] as String,
    );

Map<String, dynamic> _$$GasFeeEstimationImplToJson(
        _$GasFeeEstimationImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'low': const FeeLevelJsonConverter().toJson(instance.low),
      'medium': const FeeLevelJsonConverter().toJson(instance.medium),
      'high': const FeeLevelJsonConverter().toJson(instance.high),
      'estimatedBaseFee': instance.estimatedBaseFee,
      'networkCongestion': instance.networkCongestion,
      'latestPriorityFeeRange': instance.latestPriorityFeeRange,
      'historicalPriorityFeeRange': instance.historicalPriorityFeeRange,
      'historicalBaseFeeRange': instance.historicalBaseFeeRange,
      'priorityFeeTrend': instance.priorityFeeTrend,
      'baseFeeTrend': instance.baseFeeTrend,
    };

import 'package:aebridge/domain/models/fee_level.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gas_fee_estimation.freezed.dart';
part 'gas_fee_estimation.g.dart';

class GasFeeEstimationJsonConverter
    extends JsonConverter<GasFeeEstimation, Map<String, dynamic>> {
  const GasFeeEstimationJsonConverter();

  @override
  GasFeeEstimation fromJson(Map<String, dynamic> json) {
    return GasFeeEstimation.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(GasFeeEstimation object) => object.toJson();
}

@freezed
class GasFeeEstimation with _$GasFeeEstimation {
  const factory GasFeeEstimation({
    DateTime? timestamp,
    @FeeLevelJsonConverter() required FeeLevel low,
    @FeeLevelJsonConverter() required FeeLevel medium,
    @FeeLevelJsonConverter() required FeeLevel high,
    required String estimatedBaseFee,
    required double networkCongestion,
    required List<String> latestPriorityFeeRange,
    required List<String> historicalPriorityFeeRange,
    required List<String> historicalBaseFeeRange,
    required String priorityFeeTrend,
    required String baseFeeTrend,
  }) = _GasFeeEstimation;

  factory GasFeeEstimation.fromJson(Map<String, dynamic> json) =>
      _$GasFeeEstimationFromJson(json);
}

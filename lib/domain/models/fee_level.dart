import 'package:freezed_annotation/freezed_annotation.dart';

part 'fee_level.freezed.dart';
part 'fee_level.g.dart';

class FeeLevelJsonConverter
    extends JsonConverter<FeeLevel, Map<String, dynamic>> {
  const FeeLevelJsonConverter();

  @override
  FeeLevel fromJson(Map<String, dynamic> json) {
    return FeeLevel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(FeeLevel object) => object.toJson();
}

@freezed
class FeeLevel with _$FeeLevel {
  const factory FeeLevel({
    required String suggestedMaxPriorityFeePerGas,
    required String suggestedMaxFeePerGas,
    required int minWaitTimeEstimate,
    required int maxWaitTimeEstimate,
  }) = _FeeLevel;

  factory FeeLevel.fromJson(Map<String, dynamic> json) =>
      _$FeeLevelFromJson(json);
}

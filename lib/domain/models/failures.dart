import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';
part 'failures.g.dart';

class FailureJsonConverter
    extends JsonConverter<Failure, Map<String, dynamic>> {
  const FailureJsonConverter();

  @override
  Failure fromJson(Map<String, dynamic> json) {
    return Failure.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Failure object) => object.toJson();
}

@freezed
class Failure with _$Failure implements Exception {
  const Failure._();
  const factory Failure.loggedOut() = LoggedOut;
  const factory Failure.network() = NetworkFailure;
  const factory Failure.quotaExceeded({
    DateTime? cooldownEndDate,
  }) = QuotaExceededFailure;
  const factory Failure.serviceNotFound() = ServiceNotFound;
  const factory Failure.serviceAlreadyExists() = _ServiceAlreadyExists;
  const factory Failure.insufficientFunds() = InsuffientFunds;
  const factory Failure.unauthorized() = Inauthorized;
  const factory Failure.invalidValue() = InvalidValue;
  const factory Failure.userRejected() = UserRejected;
  const factory Failure.other({
    Object? cause,
    String? stack,
  }) = OtherFailure;

  factory Failure.fromJson(Map<String, dynamic> json) =>
      _$FailureFromJson(json);
}

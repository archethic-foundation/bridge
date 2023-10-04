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
  const factory Failure.serviceAlreadyExists() = ServiceAlreadyExists;
  const factory Failure.insufficientFunds() = InsuffientFunds;
  const factory Failure.unauthorized() = Inauthorized;
  const factory Failure.invalidValue() = InvalidValue;
  const factory Failure.wrongNetwork(
    String cause,
  ) = WrongNetwork;
  const factory Failure.userRejected() = UserRejected;
  const factory Failure.connectivityArchethic() = ConnectivityArchethic;
  const factory Failure.connectivityEVM() = ConnectivityEVM;
  const factory Failure.rpcErrorEVM({
    Map<String, RPCErrorEVMData>? data,
    String? stack,
    String? name,
  }) = RPCErrorEVM;

  const factory Failure.other({
    String? cause,
    String? stack,
  }) = OtherFailure;

  factory Failure.fromJson(Map<String, dynamic> json) =>
      _$FailureFromJson(json);
}

@freezed
class RPCErrorEVMData with _$RPCErrorEVMData {
  const factory RPCErrorEVMData({
    required String error,
    // ignore: non_constant_identifier_names
    required int program_counter,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'return') required String returnValue,
    required String reason,
  }) = _RPCErrorEVMData;

  factory RPCErrorEVMData.fromJson(Map<String, dynamic> json) =>
      _$RPCErrorEVMDataFromJson(json);
}

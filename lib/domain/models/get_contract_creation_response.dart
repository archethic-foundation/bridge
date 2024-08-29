import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_contract_creation_response.freezed.dart';
part 'get_contract_creation_response.g.dart';

@freezed
class GetContractCreationResponse with _$GetContractCreationResponse {
  const factory GetContractCreationResponse({
    required String status,
    required String message,
    required List<GetContractCreationResponseResult> result,
  }) = _GetContractCreationResponse;

  factory GetContractCreationResponse.fromJson(Map<String, dynamic> json) =>
      _$GetContractCreationResponseFromJson(json);
}

@freezed
class GetContractCreationResponseResult
    with _$GetContractCreationResponseResult {
  const factory GetContractCreationResponseResult({
    required String contractAddress,
    required String contractCreator,
    required String txHash,
  }) = _GetContractCreationResponseResult;

  factory GetContractCreationResponseResult.fromJson(
          Map<String, dynamic> json) =>
      _$GetContractCreationResponseResultFromJson(json);
}

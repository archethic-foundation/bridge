/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'secret_hash.freezed.dart';
part 'secret_hash.g.dart';

@freezed
class SecretHash with _$SecretHash {
  factory SecretHash({
    String? secretHash,
    SecretHashSignature? secretHashSignature,
  }) = _SecretHash;

  factory SecretHash.fromJson(Map<String, dynamic> json) =>
      _$SecretHashFromJson(json);
}

@freezed
class SecretHashSignature with _$SecretHashSignature {
  factory SecretHashSignature({
    String? r,
    String? s,
    int? v,
  }) = _SecretHashSignature;

  factory SecretHashSignature.fromJson(Map<String, dynamic> json) =>
      _$SecretHashSignatureFromJson(json);
}

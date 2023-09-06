/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'secret.freezed.dart';
part 'secret.g.dart';

@freezed
class Secret with _$Secret {
  factory Secret({
    String? secret,
    SecretSignature? secretSignature,
  }) = _Secret;

  factory Secret.fromJson(Map<String, dynamic> json) => _$SecretFromJson(json);
}

@freezed
class SecretSignature with _$SecretSignature {
  factory SecretSignature({
    String? r,
    String? s,
    int? v,
  }) = _SecretSignature;

  factory SecretSignature.fromJson(Map<String, dynamic> json) =>
      _$SecretSignatureFromJson(json);
}

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

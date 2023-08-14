// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret_hash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SecretHash _$$_SecretHashFromJson(Map<String, dynamic> json) =>
    _$_SecretHash(
      secretHash: json['secretHash'] as String?,
      secretHashSignature: json['secretHashSignature'] == null
          ? null
          : SecretHashSignature.fromJson(
              json['secretHashSignature'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SecretHashToJson(_$_SecretHash instance) =>
    <String, dynamic>{
      'secretHash': instance.secretHash,
      'secretHashSignature': instance.secretHashSignature,
    };

_$_SecretHashSignature _$$_SecretHashSignatureFromJson(
        Map<String, dynamic> json) =>
    _$_SecretHashSignature(
      r: json['r'] as String?,
      s: json['s'] as String?,
      v: json['v'] as int?,
    );

Map<String, dynamic> _$$_SecretHashSignatureToJson(
        _$_SecretHashSignature instance) =>
    <String, dynamic>{
      'r': instance.r,
      's': instance.s,
      'v': instance.v,
    };

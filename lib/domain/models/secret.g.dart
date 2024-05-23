// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecretImpl _$$SecretImplFromJson(Map<String, dynamic> json) => _$SecretImpl(
      secret: json['secret'] as String?,
      secretSignature: json['secretSignature'] == null
          ? null
          : SecretSignature.fromJson(
              json['secretSignature'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SecretImplToJson(_$SecretImpl instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'secretSignature': instance.secretSignature,
    };

_$SecretSignatureImpl _$$SecretSignatureImplFromJson(
        Map<String, dynamic> json) =>
    _$SecretSignatureImpl(
      r: json['r'] as String?,
      s: json['s'] as String?,
      v: (json['v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SecretSignatureImplToJson(
        _$SecretSignatureImpl instance) =>
    <String, dynamic>{
      'r': instance.r,
      's': instance.s,
      'v': instance.v,
    };

_$SecretHashImpl _$$SecretHashImplFromJson(Map<String, dynamic> json) =>
    _$SecretHashImpl(
      secretHash: json['secretHash'] as String?,
      secretHashSignature: json['secretHashSignature'] == null
          ? null
          : SecretHashSignature.fromJson(
              json['secretHashSignature'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SecretHashImplToJson(_$SecretHashImpl instance) =>
    <String, dynamic>{
      'secretHash': instance.secretHash,
      'secretHashSignature': instance.secretHashSignature,
    };

_$SecretHashSignatureImpl _$$SecretHashSignatureImplFromJson(
        Map<String, dynamic> json) =>
    _$SecretHashSignatureImpl(
      r: json['r'] as String?,
      s: json['s'] as String?,
      v: (json['v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SecretHashSignatureImplToJson(
        _$SecretHashSignatureImpl instance) =>
    <String, dynamic>{
      'r': instance.r,
      's': instance.s,
      'v': instance.v,
    };

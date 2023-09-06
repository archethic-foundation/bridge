// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Secret _$$_SecretFromJson(Map<String, dynamic> json) => _$_Secret(
      secret: json['secret'] as String?,
      secretSignature: json['secretSignature'] == null
          ? null
          : SecretSignature.fromJson(
              json['secretSignature'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SecretToJson(_$_Secret instance) => <String, dynamic>{
      'secret': instance.secret,
      'secretSignature': instance.secretSignature,
    };

_$_SecretSignature _$$_SecretSignatureFromJson(Map<String, dynamic> json) =>
    _$_SecretSignature(
      r: json['r'] as String?,
      s: json['s'] as String?,
      v: json['v'] as int?,
    );

Map<String, dynamic> _$$_SecretSignatureToJson(_$_SecretSignature instance) =>
    <String, dynamic>{
      'r': instance.r,
      's': instance.s,
      'v': instance.v,
    };

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

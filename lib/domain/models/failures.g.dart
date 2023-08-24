// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoggedOut _$$LoggedOutFromJson(Map<String, dynamic> json) => _$LoggedOut(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LoggedOutToJson(_$LoggedOut instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$NetworkFailure _$$NetworkFailureFromJson(Map<String, dynamic> json) =>
    _$NetworkFailure(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NetworkFailureToJson(_$NetworkFailure instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$QuotaExceededFailure _$$QuotaExceededFailureFromJson(
        Map<String, dynamic> json) =>
    _$QuotaExceededFailure(
      cooldownEndDate: json['cooldownEndDate'] == null
          ? null
          : DateTime.parse(json['cooldownEndDate'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$QuotaExceededFailureToJson(
        _$QuotaExceededFailure instance) =>
    <String, dynamic>{
      'cooldownEndDate': instance.cooldownEndDate?.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$ServiceNotFound _$$ServiceNotFoundFromJson(Map<String, dynamic> json) =>
    _$ServiceNotFound(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ServiceNotFoundToJson(_$ServiceNotFound instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_ServiceAlreadyExists _$$_ServiceAlreadyExistsFromJson(
        Map<String, dynamic> json) =>
    _$_ServiceAlreadyExists(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ServiceAlreadyExistsToJson(
        _$_ServiceAlreadyExists instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$InsuffientFunds _$$InsuffientFundsFromJson(Map<String, dynamic> json) =>
    _$InsuffientFunds(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InsuffientFundsToJson(_$InsuffientFunds instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$Inauthorized _$$InauthorizedFromJson(Map<String, dynamic> json) =>
    _$Inauthorized(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InauthorizedToJson(_$Inauthorized instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$InvalidValue _$$InvalidValueFromJson(Map<String, dynamic> json) =>
    _$InvalidValue(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InvalidValueToJson(_$InvalidValue instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$UserRejected _$$UserRejectedFromJson(Map<String, dynamic> json) =>
    _$UserRejected(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UserRejectedToJson(_$UserRejected instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$OtherFailure _$$OtherFailureFromJson(Map<String, dynamic> json) =>
    _$OtherFailure(
      cause: json['cause'],
      stack: json['stack'],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$OtherFailureToJson(_$OtherFailure instance) =>
    <String, dynamic>{
      'cause': instance.cause,
      'stack': instance.stack,
      'runtimeType': instance.$type,
    };

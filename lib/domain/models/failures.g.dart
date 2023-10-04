// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoggedOutImpl _$$LoggedOutImplFromJson(Map<String, dynamic> json) =>
    _$LoggedOutImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LoggedOutImplToJson(_$LoggedOutImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$NetworkFailureImpl _$$NetworkFailureImplFromJson(Map<String, dynamic> json) =>
    _$NetworkFailureImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NetworkFailureImplToJson(
        _$NetworkFailureImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$QuotaExceededFailureImpl _$$QuotaExceededFailureImplFromJson(
        Map<String, dynamic> json) =>
    _$QuotaExceededFailureImpl(
      cooldownEndDate: json['cooldownEndDate'] == null
          ? null
          : DateTime.parse(json['cooldownEndDate'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$QuotaExceededFailureImplToJson(
        _$QuotaExceededFailureImpl instance) =>
    <String, dynamic>{
      'cooldownEndDate': instance.cooldownEndDate?.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$ServiceNotFoundImpl _$$ServiceNotFoundImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceNotFoundImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ServiceNotFoundImplToJson(
        _$ServiceNotFoundImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ServiceAlreadyExistsImpl _$$ServiceAlreadyExistsImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceAlreadyExistsImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ServiceAlreadyExistsImplToJson(
        _$ServiceAlreadyExistsImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$InsuffientFundsImpl _$$InsuffientFundsImplFromJson(
        Map<String, dynamic> json) =>
    _$InsuffientFundsImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InsuffientFundsImplToJson(
        _$InsuffientFundsImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$InauthorizedImpl _$$InauthorizedImplFromJson(Map<String, dynamic> json) =>
    _$InauthorizedImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InauthorizedImplToJson(_$InauthorizedImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$InvalidValueImpl _$$InvalidValueImplFromJson(Map<String, dynamic> json) =>
    _$InvalidValueImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InvalidValueImplToJson(_$InvalidValueImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$UserRejectedImpl _$$UserRejectedImplFromJson(Map<String, dynamic> json) =>
    _$UserRejectedImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UserRejectedImplToJson(_$UserRejectedImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ConnectivityArchethicImpl _$$ConnectivityArchethicImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectivityArchethicImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ConnectivityArchethicImplToJson(
        _$ConnectivityArchethicImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ConnectivityEVMImpl _$$ConnectivityEVMImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectivityEVMImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ConnectivityEVMImplToJson(
        _$ConnectivityEVMImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$RPCErrorEVMImpl _$$RPCErrorEVMImplFromJson(Map<String, dynamic> json) =>
    _$RPCErrorEVMImpl(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, RPCErrorEVMData.fromJson(e as Map<String, dynamic>)),
      ),
      stack: json['stack'] as String?,
      name: json['name'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RPCErrorEVMImplToJson(_$RPCErrorEVMImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'stack': instance.stack,
      'name': instance.name,
      'runtimeType': instance.$type,
    };

_$OtherFailureImpl _$$OtherFailureImplFromJson(Map<String, dynamic> json) =>
    _$OtherFailureImpl(
      cause: json['cause'] as String?,
      stack: json['stack'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$OtherFailureImplToJson(_$OtherFailureImpl instance) =>
    <String, dynamic>{
      'cause': instance.cause,
      'stack': instance.stack,
      'runtimeType': instance.$type,
    };

_$RPCErrorEVMDataImpl _$$RPCErrorEVMDataImplFromJson(
        Map<String, dynamic> json) =>
    _$RPCErrorEVMDataImpl(
      error: json['error'] as String,
      program_counter: json['program_counter'] as int,
      returnValue: json['return'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$$RPCErrorEVMDataImplToJson(
        _$RPCErrorEVMDataImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'program_counter': instance.program_counter,
      'return': instance.returnValue,
      'reason': instance.reason,
    };

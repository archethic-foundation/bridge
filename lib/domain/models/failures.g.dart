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

_$ServiceAlreadyExists _$$ServiceAlreadyExistsFromJson(
        Map<String, dynamic> json) =>
    _$ServiceAlreadyExists(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ServiceAlreadyExistsToJson(
        _$ServiceAlreadyExists instance) =>
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

_$ConnectivityArchethic _$$ConnectivityArchethicFromJson(
        Map<String, dynamic> json) =>
    _$ConnectivityArchethic(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ConnectivityArchethicToJson(
        _$ConnectivityArchethic instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ConnectivityEVM _$$ConnectivityEVMFromJson(Map<String, dynamic> json) =>
    _$ConnectivityEVM(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ConnectivityEVMToJson(_$ConnectivityEVM instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$RPCErrorEVM _$$RPCErrorEVMFromJson(Map<String, dynamic> json) =>
    _$RPCErrorEVM(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, RPCErrorEVMData.fromJson(e as Map<String, dynamic>)),
      ),
      stack: json['stack'] as String?,
      name: json['name'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RPCErrorEVMToJson(_$RPCErrorEVM instance) =>
    <String, dynamic>{
      'data': instance.data,
      'stack': instance.stack,
      'name': instance.name,
      'runtimeType': instance.$type,
    };

_$OtherFailure _$$OtherFailureFromJson(Map<String, dynamic> json) =>
    _$OtherFailure(
      cause: json['cause'],
      stack: json['stack'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$OtherFailureToJson(_$OtherFailure instance) =>
    <String, dynamic>{
      'cause': instance.cause,
      'stack': instance.stack,
      'runtimeType': instance.$type,
    };

_$_RPCErrorEVMData _$$_RPCErrorEVMDataFromJson(Map<String, dynamic> json) =>
    _$_RPCErrorEVMData(
      error: json['error'] as String,
      program_counter: json['program_counter'] as int,
      returnValue: json['return'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$$_RPCErrorEVMDataToJson(_$_RPCErrorEVMData instance) =>
    <String, dynamic>{
      'error': instance.error,
      'program_counter': instance.program_counter,
      'return': instance.returnValue,
      'reason': instance.reason,
    };

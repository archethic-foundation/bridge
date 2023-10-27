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

_$InsufficientFundsImpl _$$InsufficientFundsImplFromJson(
        Map<String, dynamic> json) =>
    _$InsufficientFundsImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InsufficientFundsImplToJson(
        _$InsufficientFundsImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$InsufficientPoolFundsImpl _$$InsufficientPoolFundsImplFromJson(
        Map<String, dynamic> json) =>
    _$InsufficientPoolFundsImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InsufficientPoolFundsImplToJson(
        _$InsufficientPoolFundsImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$UnauthorizedImpl _$$UnauthorizedImplFromJson(Map<String, dynamic> json) =>
    _$UnauthorizedImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UnauthorizedImplToJson(_$UnauthorizedImpl instance) =>
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

_$HTLCWithoutFundsImpl _$$HTLCWithoutFundsImplFromJson(
        Map<String, dynamic> json) =>
    _$HTLCWithoutFundsImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$HTLCWithoutFundsImplToJson(
        _$HTLCWithoutFundsImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$WrongNetworkImpl _$$WrongNetworkImplFromJson(Map<String, dynamic> json) =>
    _$WrongNetworkImpl(
      json['cause'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WrongNetworkImplToJson(_$WrongNetworkImpl instance) =>
    <String, dynamic>{
      'cause': instance.cause,
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

_$TimeoutImpl _$$TimeoutImplFromJson(Map<String, dynamic> json) =>
    _$TimeoutImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TimeoutImplToJson(_$TimeoutImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$RPCErrorEVMImpl _$$RPCErrorEVMImplFromJson(Map<String, dynamic> json) =>
    _$RPCErrorEVMImpl(
      json['cause'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RPCErrorEVMImplToJson(_$RPCErrorEVMImpl instance) =>
    <String, dynamic>{
      'cause': instance.cause,
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

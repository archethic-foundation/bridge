// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Failure _$FailureFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'loggedOut':
      return LoggedOut.fromJson(json);
    case 'network':
      return NetworkFailure.fromJson(json);
    case 'quotaExceeded':
      return QuotaExceededFailure.fromJson(json);
    case 'serviceNotFound':
      return ServiceNotFound.fromJson(json);
    case 'serviceAlreadyExists':
      return ServiceAlreadyExists.fromJson(json);
    case 'insufficientFunds':
      return InsuffientFunds.fromJson(json);
    case 'unauthorized':
      return Inauthorized.fromJson(json);
    case 'invalidValue':
      return InvalidValue.fromJson(json);
    case 'userRejected':
      return UserRejected.fromJson(json);
    case 'connectivityArchethic':
      return ConnectivityArchethic.fromJson(json);
    case 'connectivityEVM':
      return ConnectivityEVM.fromJson(json);
    case 'rpcErrorEVM':
      return RPCErrorEVM.fromJson(json);
    case 'other':
      return OtherFailure.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Failure',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Failure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoggedOutCopyWith<$Res> {
  factory _$$LoggedOutCopyWith(
          _$LoggedOut value, $Res Function(_$LoggedOut) then) =
      __$$LoggedOutCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoggedOutCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$LoggedOut>
    implements _$$LoggedOutCopyWith<$Res> {
  __$$LoggedOutCopyWithImpl(
      _$LoggedOut _value, $Res Function(_$LoggedOut) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$LoggedOut extends LoggedOut {
  const _$LoggedOut({final String? $type})
      : $type = $type ?? 'loggedOut',
        super._();

  factory _$LoggedOut.fromJson(Map<String, dynamic> json) =>
      _$$LoggedOutFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.loggedOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoggedOut);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return loggedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return loggedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return loggedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return loggedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoggedOutToJson(
      this,
    );
  }
}

abstract class LoggedOut extends Failure {
  const factory LoggedOut() = _$LoggedOut;
  const LoggedOut._() : super._();

  factory LoggedOut.fromJson(Map<String, dynamic> json) = _$LoggedOut.fromJson;
}

/// @nodoc
abstract class _$$NetworkFailureCopyWith<$Res> {
  factory _$$NetworkFailureCopyWith(
          _$NetworkFailure value, $Res Function(_$NetworkFailure) then) =
      __$$NetworkFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NetworkFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailure>
    implements _$$NetworkFailureCopyWith<$Res> {
  __$$NetworkFailureCopyWithImpl(
      _$NetworkFailure _value, $Res Function(_$NetworkFailure) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$NetworkFailure extends NetworkFailure {
  const _$NetworkFailure({final String? $type})
      : $type = $type ?? 'network',
        super._();

  factory _$NetworkFailure.fromJson(Map<String, dynamic> json) =>
      _$$NetworkFailureFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.network()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NetworkFailure);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return network();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return network?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NetworkFailureToJson(
      this,
    );
  }
}

abstract class NetworkFailure extends Failure {
  const factory NetworkFailure() = _$NetworkFailure;
  const NetworkFailure._() : super._();

  factory NetworkFailure.fromJson(Map<String, dynamic> json) =
      _$NetworkFailure.fromJson;
}

/// @nodoc
abstract class _$$QuotaExceededFailureCopyWith<$Res> {
  factory _$$QuotaExceededFailureCopyWith(_$QuotaExceededFailure value,
          $Res Function(_$QuotaExceededFailure) then) =
      __$$QuotaExceededFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime? cooldownEndDate});
}

/// @nodoc
class __$$QuotaExceededFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$QuotaExceededFailure>
    implements _$$QuotaExceededFailureCopyWith<$Res> {
  __$$QuotaExceededFailureCopyWithImpl(_$QuotaExceededFailure _value,
      $Res Function(_$QuotaExceededFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cooldownEndDate = freezed,
  }) {
    return _then(_$QuotaExceededFailure(
      cooldownEndDate: freezed == cooldownEndDate
          ? _value.cooldownEndDate
          : cooldownEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuotaExceededFailure extends QuotaExceededFailure {
  const _$QuotaExceededFailure({this.cooldownEndDate, final String? $type})
      : $type = $type ?? 'quotaExceeded',
        super._();

  factory _$QuotaExceededFailure.fromJson(Map<String, dynamic> json) =>
      _$$QuotaExceededFailureFromJson(json);

  @override
  final DateTime? cooldownEndDate;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.quotaExceeded(cooldownEndDate: $cooldownEndDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuotaExceededFailure &&
            (identical(other.cooldownEndDate, cooldownEndDate) ||
                other.cooldownEndDate == cooldownEndDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cooldownEndDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuotaExceededFailureCopyWith<_$QuotaExceededFailure> get copyWith =>
      __$$QuotaExceededFailureCopyWithImpl<_$QuotaExceededFailure>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return quotaExceeded(cooldownEndDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return quotaExceeded?.call(cooldownEndDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (quotaExceeded != null) {
      return quotaExceeded(cooldownEndDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return quotaExceeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return quotaExceeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (quotaExceeded != null) {
      return quotaExceeded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$QuotaExceededFailureToJson(
      this,
    );
  }
}

abstract class QuotaExceededFailure extends Failure {
  const factory QuotaExceededFailure({final DateTime? cooldownEndDate}) =
      _$QuotaExceededFailure;
  const QuotaExceededFailure._() : super._();

  factory QuotaExceededFailure.fromJson(Map<String, dynamic> json) =
      _$QuotaExceededFailure.fromJson;

  DateTime? get cooldownEndDate;
  @JsonKey(ignore: true)
  _$$QuotaExceededFailureCopyWith<_$QuotaExceededFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServiceNotFoundCopyWith<$Res> {
  factory _$$ServiceNotFoundCopyWith(
          _$ServiceNotFound value, $Res Function(_$ServiceNotFound) then) =
      __$$ServiceNotFoundCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ServiceNotFoundCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServiceNotFound>
    implements _$$ServiceNotFoundCopyWith<$Res> {
  __$$ServiceNotFoundCopyWithImpl(
      _$ServiceNotFound _value, $Res Function(_$ServiceNotFound) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ServiceNotFound extends ServiceNotFound {
  const _$ServiceNotFound({final String? $type})
      : $type = $type ?? 'serviceNotFound',
        super._();

  factory _$ServiceNotFound.fromJson(Map<String, dynamic> json) =>
      _$$ServiceNotFoundFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.serviceNotFound()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ServiceNotFound);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return serviceNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return serviceNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (serviceNotFound != null) {
      return serviceNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return serviceNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return serviceNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (serviceNotFound != null) {
      return serviceNotFound(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceNotFoundToJson(
      this,
    );
  }
}

abstract class ServiceNotFound extends Failure {
  const factory ServiceNotFound() = _$ServiceNotFound;
  const ServiceNotFound._() : super._();

  factory ServiceNotFound.fromJson(Map<String, dynamic> json) =
      _$ServiceNotFound.fromJson;
}

/// @nodoc
abstract class _$$ServiceAlreadyExistsCopyWith<$Res> {
  factory _$$ServiceAlreadyExistsCopyWith(_$ServiceAlreadyExists value,
          $Res Function(_$ServiceAlreadyExists) then) =
      __$$ServiceAlreadyExistsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ServiceAlreadyExistsCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServiceAlreadyExists>
    implements _$$ServiceAlreadyExistsCopyWith<$Res> {
  __$$ServiceAlreadyExistsCopyWithImpl(_$ServiceAlreadyExists _value,
      $Res Function(_$ServiceAlreadyExists) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ServiceAlreadyExists extends ServiceAlreadyExists {
  const _$ServiceAlreadyExists({final String? $type})
      : $type = $type ?? 'serviceAlreadyExists',
        super._();

  factory _$ServiceAlreadyExists.fromJson(Map<String, dynamic> json) =>
      _$$ServiceAlreadyExistsFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.serviceAlreadyExists()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ServiceAlreadyExists);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return serviceAlreadyExists();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return serviceAlreadyExists?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (serviceAlreadyExists != null) {
      return serviceAlreadyExists();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return serviceAlreadyExists(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return serviceAlreadyExists?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (serviceAlreadyExists != null) {
      return serviceAlreadyExists(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceAlreadyExistsToJson(
      this,
    );
  }
}

abstract class ServiceAlreadyExists extends Failure {
  const factory ServiceAlreadyExists() = _$ServiceAlreadyExists;
  const ServiceAlreadyExists._() : super._();

  factory ServiceAlreadyExists.fromJson(Map<String, dynamic> json) =
      _$ServiceAlreadyExists.fromJson;
}

/// @nodoc
abstract class _$$InsuffientFundsCopyWith<$Res> {
  factory _$$InsuffientFundsCopyWith(
          _$InsuffientFunds value, $Res Function(_$InsuffientFunds) then) =
      __$$InsuffientFundsCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InsuffientFundsCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$InsuffientFunds>
    implements _$$InsuffientFundsCopyWith<$Res> {
  __$$InsuffientFundsCopyWithImpl(
      _$InsuffientFunds _value, $Res Function(_$InsuffientFunds) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$InsuffientFunds extends InsuffientFunds {
  const _$InsuffientFunds({final String? $type})
      : $type = $type ?? 'insufficientFunds',
        super._();

  factory _$InsuffientFunds.fromJson(Map<String, dynamic> json) =>
      _$$InsuffientFundsFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.insufficientFunds()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InsuffientFunds);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return insufficientFunds();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return insufficientFunds?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (insufficientFunds != null) {
      return insufficientFunds();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return insufficientFunds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return insufficientFunds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (insufficientFunds != null) {
      return insufficientFunds(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InsuffientFundsToJson(
      this,
    );
  }
}

abstract class InsuffientFunds extends Failure {
  const factory InsuffientFunds() = _$InsuffientFunds;
  const InsuffientFunds._() : super._();

  factory InsuffientFunds.fromJson(Map<String, dynamic> json) =
      _$InsuffientFunds.fromJson;
}

/// @nodoc
abstract class _$$InauthorizedCopyWith<$Res> {
  factory _$$InauthorizedCopyWith(
          _$Inauthorized value, $Res Function(_$Inauthorized) then) =
      __$$InauthorizedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InauthorizedCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$Inauthorized>
    implements _$$InauthorizedCopyWith<$Res> {
  __$$InauthorizedCopyWithImpl(
      _$Inauthorized _value, $Res Function(_$Inauthorized) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$Inauthorized extends Inauthorized {
  const _$Inauthorized({final String? $type})
      : $type = $type ?? 'unauthorized',
        super._();

  factory _$Inauthorized.fromJson(Map<String, dynamic> json) =>
      _$$InauthorizedFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.unauthorized()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Inauthorized);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return unauthorized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return unauthorized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InauthorizedToJson(
      this,
    );
  }
}

abstract class Inauthorized extends Failure {
  const factory Inauthorized() = _$Inauthorized;
  const Inauthorized._() : super._();

  factory Inauthorized.fromJson(Map<String, dynamic> json) =
      _$Inauthorized.fromJson;
}

/// @nodoc
abstract class _$$InvalidValueCopyWith<$Res> {
  factory _$$InvalidValueCopyWith(
          _$InvalidValue value, $Res Function(_$InvalidValue) then) =
      __$$InvalidValueCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidValueCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$InvalidValue>
    implements _$$InvalidValueCopyWith<$Res> {
  __$$InvalidValueCopyWithImpl(
      _$InvalidValue _value, $Res Function(_$InvalidValue) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$InvalidValue extends InvalidValue {
  const _$InvalidValue({final String? $type})
      : $type = $type ?? 'invalidValue',
        super._();

  factory _$InvalidValue.fromJson(Map<String, dynamic> json) =>
      _$$InvalidValueFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.invalidValue()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvalidValue);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return invalidValue();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return invalidValue?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (invalidValue != null) {
      return invalidValue();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return invalidValue(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return invalidValue?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (invalidValue != null) {
      return invalidValue(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InvalidValueToJson(
      this,
    );
  }
}

abstract class InvalidValue extends Failure {
  const factory InvalidValue() = _$InvalidValue;
  const InvalidValue._() : super._();

  factory InvalidValue.fromJson(Map<String, dynamic> json) =
      _$InvalidValue.fromJson;
}

/// @nodoc
abstract class _$$UserRejectedCopyWith<$Res> {
  factory _$$UserRejectedCopyWith(
          _$UserRejected value, $Res Function(_$UserRejected) then) =
      __$$UserRejectedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserRejectedCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UserRejected>
    implements _$$UserRejectedCopyWith<$Res> {
  __$$UserRejectedCopyWithImpl(
      _$UserRejected _value, $Res Function(_$UserRejected) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$UserRejected extends UserRejected {
  const _$UserRejected({final String? $type})
      : $type = $type ?? 'userRejected',
        super._();

  factory _$UserRejected.fromJson(Map<String, dynamic> json) =>
      _$$UserRejectedFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.userRejected()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserRejected);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return userRejected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return userRejected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (userRejected != null) {
      return userRejected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return userRejected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return userRejected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (userRejected != null) {
      return userRejected(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UserRejectedToJson(
      this,
    );
  }
}

abstract class UserRejected extends Failure {
  const factory UserRejected() = _$UserRejected;
  const UserRejected._() : super._();

  factory UserRejected.fromJson(Map<String, dynamic> json) =
      _$UserRejected.fromJson;
}

/// @nodoc
abstract class _$$ConnectivityArchethicCopyWith<$Res> {
  factory _$$ConnectivityArchethicCopyWith(_$ConnectivityArchethic value,
          $Res Function(_$ConnectivityArchethic) then) =
      __$$ConnectivityArchethicCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectivityArchethicCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ConnectivityArchethic>
    implements _$$ConnectivityArchethicCopyWith<$Res> {
  __$$ConnectivityArchethicCopyWithImpl(_$ConnectivityArchethic _value,
      $Res Function(_$ConnectivityArchethic) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ConnectivityArchethic extends ConnectivityArchethic {
  const _$ConnectivityArchethic({final String? $type})
      : $type = $type ?? 'connectivityArchethic',
        super._();

  factory _$ConnectivityArchethic.fromJson(Map<String, dynamic> json) =>
      _$$ConnectivityArchethicFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.connectivityArchethic()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectivityArchethic);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return connectivityArchethic();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return connectivityArchethic?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (connectivityArchethic != null) {
      return connectivityArchethic();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return connectivityArchethic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return connectivityArchethic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (connectivityArchethic != null) {
      return connectivityArchethic(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectivityArchethicToJson(
      this,
    );
  }
}

abstract class ConnectivityArchethic extends Failure {
  const factory ConnectivityArchethic() = _$ConnectivityArchethic;
  const ConnectivityArchethic._() : super._();

  factory ConnectivityArchethic.fromJson(Map<String, dynamic> json) =
      _$ConnectivityArchethic.fromJson;
}

/// @nodoc
abstract class _$$ConnectivityEVMCopyWith<$Res> {
  factory _$$ConnectivityEVMCopyWith(
          _$ConnectivityEVM value, $Res Function(_$ConnectivityEVM) then) =
      __$$ConnectivityEVMCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectivityEVMCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ConnectivityEVM>
    implements _$$ConnectivityEVMCopyWith<$Res> {
  __$$ConnectivityEVMCopyWithImpl(
      _$ConnectivityEVM _value, $Res Function(_$ConnectivityEVM) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ConnectivityEVM extends ConnectivityEVM {
  const _$ConnectivityEVM({final String? $type})
      : $type = $type ?? 'connectivityEVM',
        super._();

  factory _$ConnectivityEVM.fromJson(Map<String, dynamic> json) =>
      _$$ConnectivityEVMFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.connectivityEVM()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectivityEVM);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return connectivityEVM();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return connectivityEVM?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (connectivityEVM != null) {
      return connectivityEVM();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return connectivityEVM(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return connectivityEVM?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (connectivityEVM != null) {
      return connectivityEVM(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectivityEVMToJson(
      this,
    );
  }
}

abstract class ConnectivityEVM extends Failure {
  const factory ConnectivityEVM() = _$ConnectivityEVM;
  const ConnectivityEVM._() : super._();

  factory ConnectivityEVM.fromJson(Map<String, dynamic> json) =
      _$ConnectivityEVM.fromJson;
}

/// @nodoc
abstract class _$$RPCErrorEVMCopyWith<$Res> {
  factory _$$RPCErrorEVMCopyWith(
          _$RPCErrorEVM value, $Res Function(_$RPCErrorEVM) then) =
      __$$RPCErrorEVMCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, RPCErrorEVMData>? data, String? stack, String? name});
}

/// @nodoc
class __$$RPCErrorEVMCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$RPCErrorEVM>
    implements _$$RPCErrorEVMCopyWith<$Res> {
  __$$RPCErrorEVMCopyWithImpl(
      _$RPCErrorEVM _value, $Res Function(_$RPCErrorEVM) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? stack = freezed,
    Object? name = freezed,
  }) {
    return _then(_$RPCErrorEVM(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, RPCErrorEVMData>?,
      stack: freezed == stack
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RPCErrorEVM extends RPCErrorEVM {
  const _$RPCErrorEVM(
      {final Map<String, RPCErrorEVMData>? data,
      this.stack,
      this.name,
      final String? $type})
      : _data = data,
        $type = $type ?? 'rpcErrorEVM',
        super._();

  factory _$RPCErrorEVM.fromJson(Map<String, dynamic> json) =>
      _$$RPCErrorEVMFromJson(json);

  final Map<String, RPCErrorEVMData>? _data;
  @override
  Map<String, RPCErrorEVMData>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? stack;
  @override
  final String? name;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.rpcErrorEVM(data: $data, stack: $stack, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCErrorEVM &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.stack, stack) || other.stack == stack) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), stack, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RPCErrorEVMCopyWith<_$RPCErrorEVM> get copyWith =>
      __$$RPCErrorEVMCopyWithImpl<_$RPCErrorEVM>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return rpcErrorEVM(data, stack, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return rpcErrorEVM?.call(data, stack, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (rpcErrorEVM != null) {
      return rpcErrorEVM(data, stack, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return rpcErrorEVM(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return rpcErrorEVM?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (rpcErrorEVM != null) {
      return rpcErrorEVM(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RPCErrorEVMToJson(
      this,
    );
  }
}

abstract class RPCErrorEVM extends Failure {
  const factory RPCErrorEVM(
      {final Map<String, RPCErrorEVMData>? data,
      final String? stack,
      final String? name}) = _$RPCErrorEVM;
  const RPCErrorEVM._() : super._();

  factory RPCErrorEVM.fromJson(Map<String, dynamic> json) =
      _$RPCErrorEVM.fromJson;

  Map<String, RPCErrorEVMData>? get data;
  String? get stack;
  String? get name;
  @JsonKey(ignore: true)
  _$$RPCErrorEVMCopyWith<_$RPCErrorEVM> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtherFailureCopyWith<$Res> {
  factory _$$OtherFailureCopyWith(
          _$OtherFailure value, $Res Function(_$OtherFailure) then) =
      __$$OtherFailureCopyWithImpl<$Res>;
  @useResult
  $Res call({Object? cause, String? stack});
}

/// @nodoc
class __$$OtherFailureCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$OtherFailure>
    implements _$$OtherFailureCopyWith<$Res> {
  __$$OtherFailureCopyWithImpl(
      _$OtherFailure _value, $Res Function(_$OtherFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(_$OtherFailure(
      cause: freezed == cause ? _value.cause : cause,
      stack: freezed == stack
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtherFailure extends OtherFailure {
  const _$OtherFailure({this.cause, this.stack, final String? $type})
      : $type = $type ?? 'other',
        super._();

  factory _$OtherFailure.fromJson(Map<String, dynamic> json) =>
      _$$OtherFailureFromJson(json);

  @override
  final Object? cause;
  @override
  final String? stack;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.other(cause: $cause, stack: $stack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtherFailure &&
            const DeepCollectionEquality().equals(other.cause, cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(cause), stack);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtherFailureCopyWith<_$OtherFailure> get copyWith =>
      __$$OtherFailureCopyWithImpl<_$OtherFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)
        rpcErrorEVM,
    required TResult Function(Object? cause, String? stack) other,
  }) {
    return other(cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loggedOut,
    TResult? Function()? network,
    TResult? Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult? Function()? serviceNotFound,
    TResult? Function()? serviceAlreadyExists,
    TResult? Function()? insufficientFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult? Function(Object? cause, String? stack)? other,
  }) {
    return other?.call(cause, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loggedOut,
    TResult Function()? network,
    TResult Function(DateTime? cooldownEndDate)? quotaExceeded,
    TResult Function()? serviceNotFound,
    TResult Function()? serviceAlreadyExists,
    TResult Function()? insufficientFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function(
            Map<String, RPCErrorEVMData>? data, String? stack, String? name)?
        rpcErrorEVM,
    TResult Function(Object? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(cause, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoggedOut value) loggedOut,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(QuotaExceededFailure value) quotaExceeded,
    required TResult Function(ServiceNotFound value) serviceNotFound,
    required TResult Function(ServiceAlreadyExists value) serviceAlreadyExists,
    required TResult Function(InsuffientFunds value) insufficientFunds,
    required TResult Function(Inauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsuffientFunds value)? insufficientFunds,
    TResult? Function(Inauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsuffientFunds value)? insufficientFunds,
    TResult Function(Inauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$OtherFailureToJson(
      this,
    );
  }
}

abstract class OtherFailure extends Failure {
  const factory OtherFailure({final Object? cause, final String? stack}) =
      _$OtherFailure;
  const OtherFailure._() : super._();

  factory OtherFailure.fromJson(Map<String, dynamic> json) =
      _$OtherFailure.fromJson;

  Object? get cause;
  String? get stack;
  @JsonKey(ignore: true)
  _$$OtherFailureCopyWith<_$OtherFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

RPCErrorEVMData _$RPCErrorEVMDataFromJson(Map<String, dynamic> json) {
  return _RPCErrorEVMData.fromJson(json);
}

/// @nodoc
mixin _$RPCErrorEVMData {
  String get error =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  int get program_counter =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'return')
  String get returnValue => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RPCErrorEVMDataCopyWith<RPCErrorEVMData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCErrorEVMDataCopyWith<$Res> {
  factory $RPCErrorEVMDataCopyWith(
          RPCErrorEVMData value, $Res Function(RPCErrorEVMData) then) =
      _$RPCErrorEVMDataCopyWithImpl<$Res, RPCErrorEVMData>;
  @useResult
  $Res call(
      {String error,
      int program_counter,
      @JsonKey(name: 'return') String returnValue,
      String reason});
}

/// @nodoc
class _$RPCErrorEVMDataCopyWithImpl<$Res, $Val extends RPCErrorEVMData>
    implements $RPCErrorEVMDataCopyWith<$Res> {
  _$RPCErrorEVMDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? program_counter = null,
    Object? returnValue = null,
    Object? reason = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      program_counter: null == program_counter
          ? _value.program_counter
          : program_counter // ignore: cast_nullable_to_non_nullable
              as int,
      returnValue: null == returnValue
          ? _value.returnValue
          : returnValue // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCErrorEVMDataCopyWith<$Res>
    implements $RPCErrorEVMDataCopyWith<$Res> {
  factory _$$_RPCErrorEVMDataCopyWith(
          _$_RPCErrorEVMData value, $Res Function(_$_RPCErrorEVMData) then) =
      __$$_RPCErrorEVMDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String error,
      int program_counter,
      @JsonKey(name: 'return') String returnValue,
      String reason});
}

/// @nodoc
class __$$_RPCErrorEVMDataCopyWithImpl<$Res>
    extends _$RPCErrorEVMDataCopyWithImpl<$Res, _$_RPCErrorEVMData>
    implements _$$_RPCErrorEVMDataCopyWith<$Res> {
  __$$_RPCErrorEVMDataCopyWithImpl(
      _$_RPCErrorEVMData _value, $Res Function(_$_RPCErrorEVMData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? program_counter = null,
    Object? returnValue = null,
    Object? reason = null,
  }) {
    return _then(_$_RPCErrorEVMData(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      program_counter: null == program_counter
          ? _value.program_counter
          : program_counter // ignore: cast_nullable_to_non_nullable
              as int,
      returnValue: null == returnValue
          ? _value.returnValue
          : returnValue // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RPCErrorEVMData implements _RPCErrorEVMData {
  const _$_RPCErrorEVMData(
      {required this.error,
      required this.program_counter,
      @JsonKey(name: 'return') required this.returnValue,
      required this.reason});

  factory _$_RPCErrorEVMData.fromJson(Map<String, dynamic> json) =>
      _$$_RPCErrorEVMDataFromJson(json);

  @override
  final String error;
// ignore: non_constant_identifier_names
  @override
  final int program_counter;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'return')
  final String returnValue;
  @override
  final String reason;

  @override
  String toString() {
    return 'RPCErrorEVMData(error: $error, program_counter: $program_counter, returnValue: $returnValue, reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCErrorEVMData &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.program_counter, program_counter) ||
                other.program_counter == program_counter) &&
            (identical(other.returnValue, returnValue) ||
                other.returnValue == returnValue) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, error, program_counter, returnValue, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCErrorEVMDataCopyWith<_$_RPCErrorEVMData> get copyWith =>
      __$$_RPCErrorEVMDataCopyWithImpl<_$_RPCErrorEVMData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RPCErrorEVMDataToJson(
      this,
    );
  }
}

abstract class _RPCErrorEVMData implements RPCErrorEVMData {
  const factory _RPCErrorEVMData(
      {required final String error,
      required final int program_counter,
      @JsonKey(name: 'return') required final String returnValue,
      required final String reason}) = _$_RPCErrorEVMData;

  factory _RPCErrorEVMData.fromJson(Map<String, dynamic> json) =
      _$_RPCErrorEVMData.fromJson;

  @override
  String get error;
  @override // ignore: non_constant_identifier_names
  int get program_counter;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'return')
  String get returnValue;
  @override
  String get reason;
  @override
  @JsonKey(ignore: true)
  _$$_RPCErrorEVMDataCopyWith<_$_RPCErrorEVMData> get copyWith =>
      throw _privateConstructorUsedError;
}

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
      return InsufficientFunds.fromJson(json);
    case 'insufficientPoolFunds':
      return InsufficientPoolFunds.fromJson(json);
    case 'unauthorized':
      return Unauthorized.fromJson(json);
    case 'invalidValue':
      return InvalidValue.fromJson(json);
    case 'htlcWithoutFunds':
      return HTLCWithoutFunds.fromJson(json);
    case 'notHTLC':
      return NotHTLC.fromJson(json);
    case 'wrongNetwork':
      return WrongNetwork.fromJson(json);
    case 'userRejected':
      return UserRejected.fromJson(json);
    case 'connectivityArchethic':
      return ConnectivityArchethic.fromJson(json);
    case 'connectivityEVM':
      return ConnectivityEVM.fromJson(json);
    case 'paramEVMChain':
      return ParamEVMChain.fromJson(json);
    case 'timeout':
      return Timeout.fromJson(json);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
abstract class _$$LoggedOutImplCopyWith<$Res> {
  factory _$$LoggedOutImplCopyWith(
          _$LoggedOutImpl value, $Res Function(_$LoggedOutImpl) then) =
      __$$LoggedOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoggedOutImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$LoggedOutImpl>
    implements _$$LoggedOutImplCopyWith<$Res> {
  __$$LoggedOutImplCopyWithImpl(
      _$LoggedOutImpl _value, $Res Function(_$LoggedOutImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$LoggedOutImpl extends LoggedOut {
  const _$LoggedOutImpl({final String? $type})
      : $type = $type ?? 'loggedOut',
        super._();

  factory _$LoggedOutImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoggedOutImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.loggedOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoggedOutImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$LoggedOutImplToJson(
      this,
    );
  }
}

abstract class LoggedOut extends Failure {
  const factory LoggedOut() = _$LoggedOutImpl;
  const LoggedOut._() : super._();

  factory LoggedOut.fromJson(Map<String, dynamic> json) =
      _$LoggedOutImpl.fromJson;
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(_$NetworkFailureImpl value,
          $Res Function(_$NetworkFailureImpl) then) =
      __$$NetworkFailureImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
      _$NetworkFailureImpl _value, $Res Function(_$NetworkFailureImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$NetworkFailureImpl extends NetworkFailure {
  const _$NetworkFailureImpl({final String? $type})
      : $type = $type ?? 'network',
        super._();

  factory _$NetworkFailureImpl.fromJson(Map<String, dynamic> json) =>
      _$$NetworkFailureImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.network()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NetworkFailureImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$NetworkFailureImplToJson(
      this,
    );
  }
}

abstract class NetworkFailure extends Failure {
  const factory NetworkFailure() = _$NetworkFailureImpl;
  const NetworkFailure._() : super._();

  factory NetworkFailure.fromJson(Map<String, dynamic> json) =
      _$NetworkFailureImpl.fromJson;
}

/// @nodoc
abstract class _$$QuotaExceededFailureImplCopyWith<$Res> {
  factory _$$QuotaExceededFailureImplCopyWith(_$QuotaExceededFailureImpl value,
          $Res Function(_$QuotaExceededFailureImpl) then) =
      __$$QuotaExceededFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime? cooldownEndDate});
}

/// @nodoc
class __$$QuotaExceededFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$QuotaExceededFailureImpl>
    implements _$$QuotaExceededFailureImplCopyWith<$Res> {
  __$$QuotaExceededFailureImplCopyWithImpl(_$QuotaExceededFailureImpl _value,
      $Res Function(_$QuotaExceededFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cooldownEndDate = freezed,
  }) {
    return _then(_$QuotaExceededFailureImpl(
      cooldownEndDate: freezed == cooldownEndDate
          ? _value.cooldownEndDate
          : cooldownEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuotaExceededFailureImpl extends QuotaExceededFailure {
  const _$QuotaExceededFailureImpl({this.cooldownEndDate, final String? $type})
      : $type = $type ?? 'quotaExceeded',
        super._();

  factory _$QuotaExceededFailureImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuotaExceededFailureImplFromJson(json);

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
            other is _$QuotaExceededFailureImpl &&
            (identical(other.cooldownEndDate, cooldownEndDate) ||
                other.cooldownEndDate == cooldownEndDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cooldownEndDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuotaExceededFailureImplCopyWith<_$QuotaExceededFailureImpl>
      get copyWith =>
          __$$QuotaExceededFailureImplCopyWithImpl<_$QuotaExceededFailureImpl>(
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$QuotaExceededFailureImplToJson(
      this,
    );
  }
}

abstract class QuotaExceededFailure extends Failure {
  const factory QuotaExceededFailure({final DateTime? cooldownEndDate}) =
      _$QuotaExceededFailureImpl;
  const QuotaExceededFailure._() : super._();

  factory QuotaExceededFailure.fromJson(Map<String, dynamic> json) =
      _$QuotaExceededFailureImpl.fromJson;

  DateTime? get cooldownEndDate;
  @JsonKey(ignore: true)
  _$$QuotaExceededFailureImplCopyWith<_$QuotaExceededFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServiceNotFoundImplCopyWith<$Res> {
  factory _$$ServiceNotFoundImplCopyWith(_$ServiceNotFoundImpl value,
          $Res Function(_$ServiceNotFoundImpl) then) =
      __$$ServiceNotFoundImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ServiceNotFoundImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServiceNotFoundImpl>
    implements _$$ServiceNotFoundImplCopyWith<$Res> {
  __$$ServiceNotFoundImplCopyWithImpl(
      _$ServiceNotFoundImpl _value, $Res Function(_$ServiceNotFoundImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ServiceNotFoundImpl extends ServiceNotFound {
  const _$ServiceNotFoundImpl({final String? $type})
      : $type = $type ?? 'serviceNotFound',
        super._();

  factory _$ServiceNotFoundImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceNotFoundImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.serviceNotFound()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ServiceNotFoundImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$ServiceNotFoundImplToJson(
      this,
    );
  }
}

abstract class ServiceNotFound extends Failure {
  const factory ServiceNotFound() = _$ServiceNotFoundImpl;
  const ServiceNotFound._() : super._();

  factory ServiceNotFound.fromJson(Map<String, dynamic> json) =
      _$ServiceNotFoundImpl.fromJson;
}

/// @nodoc
abstract class _$$ServiceAlreadyExistsImplCopyWith<$Res> {
  factory _$$ServiceAlreadyExistsImplCopyWith(_$ServiceAlreadyExistsImpl value,
          $Res Function(_$ServiceAlreadyExistsImpl) then) =
      __$$ServiceAlreadyExistsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ServiceAlreadyExistsImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServiceAlreadyExistsImpl>
    implements _$$ServiceAlreadyExistsImplCopyWith<$Res> {
  __$$ServiceAlreadyExistsImplCopyWithImpl(_$ServiceAlreadyExistsImpl _value,
      $Res Function(_$ServiceAlreadyExistsImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ServiceAlreadyExistsImpl extends ServiceAlreadyExists {
  const _$ServiceAlreadyExistsImpl({final String? $type})
      : $type = $type ?? 'serviceAlreadyExists',
        super._();

  factory _$ServiceAlreadyExistsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceAlreadyExistsImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.serviceAlreadyExists()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceAlreadyExistsImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$ServiceAlreadyExistsImplToJson(
      this,
    );
  }
}

abstract class ServiceAlreadyExists extends Failure {
  const factory ServiceAlreadyExists() = _$ServiceAlreadyExistsImpl;
  const ServiceAlreadyExists._() : super._();

  factory ServiceAlreadyExists.fromJson(Map<String, dynamic> json) =
      _$ServiceAlreadyExistsImpl.fromJson;
}

/// @nodoc
abstract class _$$InsufficientFundsImplCopyWith<$Res> {
  factory _$$InsufficientFundsImplCopyWith(_$InsufficientFundsImpl value,
          $Res Function(_$InsufficientFundsImpl) then) =
      __$$InsufficientFundsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InsufficientFundsImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$InsufficientFundsImpl>
    implements _$$InsufficientFundsImplCopyWith<$Res> {
  __$$InsufficientFundsImplCopyWithImpl(_$InsufficientFundsImpl _value,
      $Res Function(_$InsufficientFundsImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$InsufficientFundsImpl extends InsufficientFunds {
  const _$InsufficientFundsImpl({final String? $type})
      : $type = $type ?? 'insufficientFunds',
        super._();

  factory _$InsufficientFundsImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsufficientFundsImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.insufficientFunds()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InsufficientFundsImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$InsufficientFundsImplToJson(
      this,
    );
  }
}

abstract class InsufficientFunds extends Failure {
  const factory InsufficientFunds() = _$InsufficientFundsImpl;
  const InsufficientFunds._() : super._();

  factory InsufficientFunds.fromJson(Map<String, dynamic> json) =
      _$InsufficientFundsImpl.fromJson;
}

/// @nodoc
abstract class _$$InsufficientPoolFundsImplCopyWith<$Res> {
  factory _$$InsufficientPoolFundsImplCopyWith(
          _$InsufficientPoolFundsImpl value,
          $Res Function(_$InsufficientPoolFundsImpl) then) =
      __$$InsufficientPoolFundsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InsufficientPoolFundsImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$InsufficientPoolFundsImpl>
    implements _$$InsufficientPoolFundsImplCopyWith<$Res> {
  __$$InsufficientPoolFundsImplCopyWithImpl(_$InsufficientPoolFundsImpl _value,
      $Res Function(_$InsufficientPoolFundsImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$InsufficientPoolFundsImpl extends InsufficientPoolFunds {
  const _$InsufficientPoolFundsImpl({final String? $type})
      : $type = $type ?? 'insufficientPoolFunds',
        super._();

  factory _$InsufficientPoolFundsImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsufficientPoolFundsImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.insufficientPoolFunds()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsufficientPoolFundsImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
  }) {
    return insufficientPoolFunds();
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
  }) {
    return insufficientPoolFunds?.call();
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (insufficientPoolFunds != null) {
      return insufficientPoolFunds();
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return insufficientPoolFunds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return insufficientPoolFunds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (insufficientPoolFunds != null) {
      return insufficientPoolFunds(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InsufficientPoolFundsImplToJson(
      this,
    );
  }
}

abstract class InsufficientPoolFunds extends Failure {
  const factory InsufficientPoolFunds() = _$InsufficientPoolFundsImpl;
  const InsufficientPoolFunds._() : super._();

  factory InsufficientPoolFunds.fromJson(Map<String, dynamic> json) =
      _$InsufficientPoolFundsImpl.fromJson;
}

/// @nodoc
abstract class _$$UnauthorizedImplCopyWith<$Res> {
  factory _$$UnauthorizedImplCopyWith(
          _$UnauthorizedImpl value, $Res Function(_$UnauthorizedImpl) then) =
      __$$UnauthorizedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthorizedImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnauthorizedImpl>
    implements _$$UnauthorizedImplCopyWith<$Res> {
  __$$UnauthorizedImplCopyWithImpl(
      _$UnauthorizedImpl _value, $Res Function(_$UnauthorizedImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$UnauthorizedImpl extends Unauthorized {
  const _$UnauthorizedImpl({final String? $type})
      : $type = $type ?? 'unauthorized',
        super._();

  factory _$UnauthorizedImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnauthorizedImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.unauthorized()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthorizedImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$UnauthorizedImplToJson(
      this,
    );
  }
}

abstract class Unauthorized extends Failure {
  const factory Unauthorized() = _$UnauthorizedImpl;
  const Unauthorized._() : super._();

  factory Unauthorized.fromJson(Map<String, dynamic> json) =
      _$UnauthorizedImpl.fromJson;
}

/// @nodoc
abstract class _$$InvalidValueImplCopyWith<$Res> {
  factory _$$InvalidValueImplCopyWith(
          _$InvalidValueImpl value, $Res Function(_$InvalidValueImpl) then) =
      __$$InvalidValueImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidValueImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$InvalidValueImpl>
    implements _$$InvalidValueImplCopyWith<$Res> {
  __$$InvalidValueImplCopyWithImpl(
      _$InvalidValueImpl _value, $Res Function(_$InvalidValueImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$InvalidValueImpl extends InvalidValue {
  const _$InvalidValueImpl({final String? $type})
      : $type = $type ?? 'invalidValue',
        super._();

  factory _$InvalidValueImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvalidValueImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.invalidValue()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvalidValueImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$InvalidValueImplToJson(
      this,
    );
  }
}

abstract class InvalidValue extends Failure {
  const factory InvalidValue() = _$InvalidValueImpl;
  const InvalidValue._() : super._();

  factory InvalidValue.fromJson(Map<String, dynamic> json) =
      _$InvalidValueImpl.fromJson;
}

/// @nodoc
abstract class _$$HTLCWithoutFundsImplCopyWith<$Res> {
  factory _$$HTLCWithoutFundsImplCopyWith(_$HTLCWithoutFundsImpl value,
          $Res Function(_$HTLCWithoutFundsImpl) then) =
      __$$HTLCWithoutFundsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HTLCWithoutFundsImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$HTLCWithoutFundsImpl>
    implements _$$HTLCWithoutFundsImplCopyWith<$Res> {
  __$$HTLCWithoutFundsImplCopyWithImpl(_$HTLCWithoutFundsImpl _value,
      $Res Function(_$HTLCWithoutFundsImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$HTLCWithoutFundsImpl extends HTLCWithoutFunds {
  const _$HTLCWithoutFundsImpl({final String? $type})
      : $type = $type ?? 'htlcWithoutFunds',
        super._();

  factory _$HTLCWithoutFundsImpl.fromJson(Map<String, dynamic> json) =>
      _$$HTLCWithoutFundsImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.htlcWithoutFunds()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HTLCWithoutFundsImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
  }) {
    return htlcWithoutFunds();
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
  }) {
    return htlcWithoutFunds?.call();
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (htlcWithoutFunds != null) {
      return htlcWithoutFunds();
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return htlcWithoutFunds(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return htlcWithoutFunds?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (htlcWithoutFunds != null) {
      return htlcWithoutFunds(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$HTLCWithoutFundsImplToJson(
      this,
    );
  }
}

abstract class HTLCWithoutFunds extends Failure {
  const factory HTLCWithoutFunds() = _$HTLCWithoutFundsImpl;
  const HTLCWithoutFunds._() : super._();

  factory HTLCWithoutFunds.fromJson(Map<String, dynamic> json) =
      _$HTLCWithoutFundsImpl.fromJson;
}

/// @nodoc
abstract class _$$NotHTLCImplCopyWith<$Res> {
  factory _$$NotHTLCImplCopyWith(
          _$NotHTLCImpl value, $Res Function(_$NotHTLCImpl) then) =
      __$$NotHTLCImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotHTLCImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NotHTLCImpl>
    implements _$$NotHTLCImplCopyWith<$Res> {
  __$$NotHTLCImplCopyWithImpl(
      _$NotHTLCImpl _value, $Res Function(_$NotHTLCImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$NotHTLCImpl extends NotHTLC {
  const _$NotHTLCImpl({final String? $type})
      : $type = $type ?? 'notHTLC',
        super._();

  factory _$NotHTLCImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotHTLCImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.notHTLC()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NotHTLCImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
  }) {
    return notHTLC();
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
  }) {
    return notHTLC?.call();
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (notHTLC != null) {
      return notHTLC();
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return notHTLC(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return notHTLC?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (notHTLC != null) {
      return notHTLC(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NotHTLCImplToJson(
      this,
    );
  }
}

abstract class NotHTLC extends Failure {
  const factory NotHTLC() = _$NotHTLCImpl;
  const NotHTLC._() : super._();

  factory NotHTLC.fromJson(Map<String, dynamic> json) = _$NotHTLCImpl.fromJson;
}

/// @nodoc
abstract class _$$WrongNetworkImplCopyWith<$Res> {
  factory _$$WrongNetworkImplCopyWith(
          _$WrongNetworkImpl value, $Res Function(_$WrongNetworkImpl) then) =
      __$$WrongNetworkImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String cause});
}

/// @nodoc
class __$$WrongNetworkImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$WrongNetworkImpl>
    implements _$$WrongNetworkImplCopyWith<$Res> {
  __$$WrongNetworkImplCopyWithImpl(
      _$WrongNetworkImpl _value, $Res Function(_$WrongNetworkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cause = null,
  }) {
    return _then(_$WrongNetworkImpl(
      null == cause
          ? _value.cause
          : cause // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WrongNetworkImpl extends WrongNetwork {
  const _$WrongNetworkImpl(this.cause, {final String? $type})
      : $type = $type ?? 'wrongNetwork',
        super._();

  factory _$WrongNetworkImpl.fromJson(Map<String, dynamic> json) =>
      _$$WrongNetworkImplFromJson(json);

  @override
  final String cause;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.wrongNetwork(cause: $cause)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WrongNetworkImpl &&
            (identical(other.cause, cause) || other.cause == cause));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cause);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WrongNetworkImplCopyWith<_$WrongNetworkImpl> get copyWith =>
      __$$WrongNetworkImplCopyWithImpl<_$WrongNetworkImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
  }) {
    return wrongNetwork(cause);
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
  }) {
    return wrongNetwork?.call(cause);
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (wrongNetwork != null) {
      return wrongNetwork(cause);
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return wrongNetwork(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return wrongNetwork?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (wrongNetwork != null) {
      return wrongNetwork(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WrongNetworkImplToJson(
      this,
    );
  }
}

abstract class WrongNetwork extends Failure {
  const factory WrongNetwork(final String cause) = _$WrongNetworkImpl;
  const WrongNetwork._() : super._();

  factory WrongNetwork.fromJson(Map<String, dynamic> json) =
      _$WrongNetworkImpl.fromJson;

  String get cause;
  @JsonKey(ignore: true)
  _$$WrongNetworkImplCopyWith<_$WrongNetworkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserRejectedImplCopyWith<$Res> {
  factory _$$UserRejectedImplCopyWith(
          _$UserRejectedImpl value, $Res Function(_$UserRejectedImpl) then) =
      __$$UserRejectedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserRejectedImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UserRejectedImpl>
    implements _$$UserRejectedImplCopyWith<$Res> {
  __$$UserRejectedImplCopyWithImpl(
      _$UserRejectedImpl _value, $Res Function(_$UserRejectedImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$UserRejectedImpl extends UserRejected {
  const _$UserRejectedImpl({final String? $type})
      : $type = $type ?? 'userRejected',
        super._();

  factory _$UserRejectedImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserRejectedImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.userRejected()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserRejectedImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$UserRejectedImplToJson(
      this,
    );
  }
}

abstract class UserRejected extends Failure {
  const factory UserRejected() = _$UserRejectedImpl;
  const UserRejected._() : super._();

  factory UserRejected.fromJson(Map<String, dynamic> json) =
      _$UserRejectedImpl.fromJson;
}

/// @nodoc
abstract class _$$ConnectivityArchethicImplCopyWith<$Res> {
  factory _$$ConnectivityArchethicImplCopyWith(
          _$ConnectivityArchethicImpl value,
          $Res Function(_$ConnectivityArchethicImpl) then) =
      __$$ConnectivityArchethicImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectivityArchethicImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ConnectivityArchethicImpl>
    implements _$$ConnectivityArchethicImplCopyWith<$Res> {
  __$$ConnectivityArchethicImplCopyWithImpl(_$ConnectivityArchethicImpl _value,
      $Res Function(_$ConnectivityArchethicImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ConnectivityArchethicImpl extends ConnectivityArchethic {
  const _$ConnectivityArchethicImpl({final String? $type})
      : $type = $type ?? 'connectivityArchethic',
        super._();

  factory _$ConnectivityArchethicImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectivityArchethicImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.connectivityArchethic()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectivityArchethicImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$ConnectivityArchethicImplToJson(
      this,
    );
  }
}

abstract class ConnectivityArchethic extends Failure {
  const factory ConnectivityArchethic() = _$ConnectivityArchethicImpl;
  const ConnectivityArchethic._() : super._();

  factory ConnectivityArchethic.fromJson(Map<String, dynamic> json) =
      _$ConnectivityArchethicImpl.fromJson;
}

/// @nodoc
abstract class _$$ConnectivityEVMImplCopyWith<$Res> {
  factory _$$ConnectivityEVMImplCopyWith(_$ConnectivityEVMImpl value,
          $Res Function(_$ConnectivityEVMImpl) then) =
      __$$ConnectivityEVMImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectivityEVMImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ConnectivityEVMImpl>
    implements _$$ConnectivityEVMImplCopyWith<$Res> {
  __$$ConnectivityEVMImplCopyWithImpl(
      _$ConnectivityEVMImpl _value, $Res Function(_$ConnectivityEVMImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ConnectivityEVMImpl extends ConnectivityEVM {
  const _$ConnectivityEVMImpl({final String? $type})
      : $type = $type ?? 'connectivityEVM',
        super._();

  factory _$ConnectivityEVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectivityEVMImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.connectivityEVM()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectivityEVMImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$ConnectivityEVMImplToJson(
      this,
    );
  }
}

abstract class ConnectivityEVM extends Failure {
  const factory ConnectivityEVM() = _$ConnectivityEVMImpl;
  const ConnectivityEVM._() : super._();

  factory ConnectivityEVM.fromJson(Map<String, dynamic> json) =
      _$ConnectivityEVMImpl.fromJson;
}

/// @nodoc
abstract class _$$ParamEVMChainImplCopyWith<$Res> {
  factory _$$ParamEVMChainImplCopyWith(
          _$ParamEVMChainImpl value, $Res Function(_$ParamEVMChainImpl) then) =
      __$$ParamEVMChainImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ParamEVMChainImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ParamEVMChainImpl>
    implements _$$ParamEVMChainImplCopyWith<$Res> {
  __$$ParamEVMChainImplCopyWithImpl(
      _$ParamEVMChainImpl _value, $Res Function(_$ParamEVMChainImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ParamEVMChainImpl extends ParamEVMChain {
  const _$ParamEVMChainImpl({final String? $type})
      : $type = $type ?? 'paramEVMChain',
        super._();

  factory _$ParamEVMChainImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParamEVMChainImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.paramEVMChain()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ParamEVMChainImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
  }) {
    return paramEVMChain();
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
  }) {
    return paramEVMChain?.call();
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (paramEVMChain != null) {
      return paramEVMChain();
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return paramEVMChain(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return paramEVMChain?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (paramEVMChain != null) {
      return paramEVMChain(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ParamEVMChainImplToJson(
      this,
    );
  }
}

abstract class ParamEVMChain extends Failure {
  const factory ParamEVMChain() = _$ParamEVMChainImpl;
  const ParamEVMChain._() : super._();

  factory ParamEVMChain.fromJson(Map<String, dynamic> json) =
      _$ParamEVMChainImpl.fromJson;
}

/// @nodoc
abstract class _$$TimeoutImplCopyWith<$Res> {
  factory _$$TimeoutImplCopyWith(
          _$TimeoutImpl value, $Res Function(_$TimeoutImpl) then) =
      __$$TimeoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TimeoutImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$TimeoutImpl>
    implements _$$TimeoutImplCopyWith<$Res> {
  __$$TimeoutImplCopyWithImpl(
      _$TimeoutImpl _value, $Res Function(_$TimeoutImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$TimeoutImpl extends Timeout {
  const _$TimeoutImpl({final String? $type})
      : $type = $type ?? 'timeout',
        super._();

  factory _$TimeoutImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeoutImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.timeout()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TimeoutImpl);
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
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
  }) {
    return timeout();
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
  }) {
    return timeout?.call();
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout();
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
    required TResult Function(RPCErrorEVM value) rpcErrorEVM,
    required TResult Function(OtherFailure value) other,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoggedOut value)? loggedOut,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(QuotaExceededFailure value)? quotaExceeded,
    TResult? Function(ServiceNotFound value)? serviceNotFound,
    TResult? Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
    TResult? Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult? Function(OtherFailure value)? other,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoggedOut value)? loggedOut,
    TResult Function(NetworkFailure value)? network,
    TResult Function(QuotaExceededFailure value)? quotaExceeded,
    TResult Function(ServiceNotFound value)? serviceNotFound,
    TResult Function(ServiceAlreadyExists value)? serviceAlreadyExists,
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
    TResult Function(RPCErrorEVM value)? rpcErrorEVM,
    TResult Function(OtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeoutImplToJson(
      this,
    );
  }
}

abstract class Timeout extends Failure {
  const factory Timeout() = _$TimeoutImpl;
  const Timeout._() : super._();

  factory Timeout.fromJson(Map<String, dynamic> json) = _$TimeoutImpl.fromJson;
}

/// @nodoc
abstract class _$$RPCErrorEVMImplCopyWith<$Res> {
  factory _$$RPCErrorEVMImplCopyWith(
          _$RPCErrorEVMImpl value, $Res Function(_$RPCErrorEVMImpl) then) =
      __$$RPCErrorEVMImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? cause});
}

/// @nodoc
class __$$RPCErrorEVMImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$RPCErrorEVMImpl>
    implements _$$RPCErrorEVMImplCopyWith<$Res> {
  __$$RPCErrorEVMImplCopyWithImpl(
      _$RPCErrorEVMImpl _value, $Res Function(_$RPCErrorEVMImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cause = freezed,
  }) {
    return _then(_$RPCErrorEVMImpl(
      freezed == cause
          ? _value.cause
          : cause // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RPCErrorEVMImpl extends RPCErrorEVM {
  const _$RPCErrorEVMImpl(this.cause, {final String? $type})
      : $type = $type ?? 'rpcErrorEVM',
        super._();

  factory _$RPCErrorEVMImpl.fromJson(Map<String, dynamic> json) =>
      _$$RPCErrorEVMImplFromJson(json);

  @override
  final String? cause;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Failure.rpcErrorEVM(cause: $cause)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCErrorEVMImpl &&
            (identical(other.cause, cause) || other.cause == cause));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cause);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RPCErrorEVMImplCopyWith<_$RPCErrorEVMImpl> get copyWith =>
      __$$RPCErrorEVMImplCopyWithImpl<_$RPCErrorEVMImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
  }) {
    return rpcErrorEVM(cause);
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
  }) {
    return rpcErrorEVM?.call(cause);
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
    required TResult orElse(),
  }) {
    if (rpcErrorEVM != null) {
      return rpcErrorEVM(cause);
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$RPCErrorEVMImplToJson(
      this,
    );
  }
}

abstract class RPCErrorEVM extends Failure {
  const factory RPCErrorEVM(final String? cause) = _$RPCErrorEVMImpl;
  const RPCErrorEVM._() : super._();

  factory RPCErrorEVM.fromJson(Map<String, dynamic> json) =
      _$RPCErrorEVMImpl.fromJson;

  String? get cause;
  @JsonKey(ignore: true)
  _$$RPCErrorEVMImplCopyWith<_$RPCErrorEVMImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OtherFailureImplCopyWith<$Res> {
  factory _$$OtherFailureImplCopyWith(
          _$OtherFailureImpl value, $Res Function(_$OtherFailureImpl) then) =
      __$$OtherFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? cause, String? stack});
}

/// @nodoc
class __$$OtherFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$OtherFailureImpl>
    implements _$$OtherFailureImplCopyWith<$Res> {
  __$$OtherFailureImplCopyWithImpl(
      _$OtherFailureImpl _value, $Res Function(_$OtherFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cause = freezed,
    Object? stack = freezed,
  }) {
    return _then(_$OtherFailureImpl(
      cause: freezed == cause
          ? _value.cause
          : cause // ignore: cast_nullable_to_non_nullable
              as String?,
      stack: freezed == stack
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtherFailureImpl extends OtherFailure {
  const _$OtherFailureImpl({this.cause, this.stack, final String? $type})
      : $type = $type ?? 'other',
        super._();

  factory _$OtherFailureImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtherFailureImplFromJson(json);

  @override
  final String? cause;
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
            other is _$OtherFailureImpl &&
            (identical(other.cause, cause) || other.cause == cause) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cause, stack);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtherFailureImplCopyWith<_$OtherFailureImpl> get copyWith =>
      __$$OtherFailureImplCopyWithImpl<_$OtherFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loggedOut,
    required TResult Function() network,
    required TResult Function(DateTime? cooldownEndDate) quotaExceeded,
    required TResult Function() serviceNotFound,
    required TResult Function() serviceAlreadyExists,
    required TResult Function() insufficientFunds,
    required TResult Function() insufficientPoolFunds,
    required TResult Function() unauthorized,
    required TResult Function() invalidValue,
    required TResult Function() htlcWithoutFunds,
    required TResult Function() notHTLC,
    required TResult Function(String cause) wrongNetwork,
    required TResult Function() userRejected,
    required TResult Function() connectivityArchethic,
    required TResult Function() connectivityEVM,
    required TResult Function() paramEVMChain,
    required TResult Function() timeout,
    required TResult Function(String? cause) rpcErrorEVM,
    required TResult Function(String? cause, String? stack) other,
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
    TResult? Function()? insufficientPoolFunds,
    TResult? Function()? unauthorized,
    TResult? Function()? invalidValue,
    TResult? Function()? htlcWithoutFunds,
    TResult? Function()? notHTLC,
    TResult? Function(String cause)? wrongNetwork,
    TResult? Function()? userRejected,
    TResult? Function()? connectivityArchethic,
    TResult? Function()? connectivityEVM,
    TResult? Function()? paramEVMChain,
    TResult? Function()? timeout,
    TResult? Function(String? cause)? rpcErrorEVM,
    TResult? Function(String? cause, String? stack)? other,
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
    TResult Function()? insufficientPoolFunds,
    TResult Function()? unauthorized,
    TResult Function()? invalidValue,
    TResult Function()? htlcWithoutFunds,
    TResult Function()? notHTLC,
    TResult Function(String cause)? wrongNetwork,
    TResult Function()? userRejected,
    TResult Function()? connectivityArchethic,
    TResult Function()? connectivityEVM,
    TResult Function()? paramEVMChain,
    TResult Function()? timeout,
    TResult Function(String? cause)? rpcErrorEVM,
    TResult Function(String? cause, String? stack)? other,
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
    required TResult Function(InsufficientFunds value) insufficientFunds,
    required TResult Function(InsufficientPoolFunds value)
        insufficientPoolFunds,
    required TResult Function(Unauthorized value) unauthorized,
    required TResult Function(InvalidValue value) invalidValue,
    required TResult Function(HTLCWithoutFunds value) htlcWithoutFunds,
    required TResult Function(NotHTLC value) notHTLC,
    required TResult Function(WrongNetwork value) wrongNetwork,
    required TResult Function(UserRejected value) userRejected,
    required TResult Function(ConnectivityArchethic value)
        connectivityArchethic,
    required TResult Function(ConnectivityEVM value) connectivityEVM,
    required TResult Function(ParamEVMChain value) paramEVMChain,
    required TResult Function(Timeout value) timeout,
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
    TResult? Function(InsufficientFunds value)? insufficientFunds,
    TResult? Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult? Function(Unauthorized value)? unauthorized,
    TResult? Function(InvalidValue value)? invalidValue,
    TResult? Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult? Function(NotHTLC value)? notHTLC,
    TResult? Function(WrongNetwork value)? wrongNetwork,
    TResult? Function(UserRejected value)? userRejected,
    TResult? Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult? Function(ConnectivityEVM value)? connectivityEVM,
    TResult? Function(ParamEVMChain value)? paramEVMChain,
    TResult? Function(Timeout value)? timeout,
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
    TResult Function(InsufficientFunds value)? insufficientFunds,
    TResult Function(InsufficientPoolFunds value)? insufficientPoolFunds,
    TResult Function(Unauthorized value)? unauthorized,
    TResult Function(InvalidValue value)? invalidValue,
    TResult Function(HTLCWithoutFunds value)? htlcWithoutFunds,
    TResult Function(NotHTLC value)? notHTLC,
    TResult Function(WrongNetwork value)? wrongNetwork,
    TResult Function(UserRejected value)? userRejected,
    TResult Function(ConnectivityArchethic value)? connectivityArchethic,
    TResult Function(ConnectivityEVM value)? connectivityEVM,
    TResult Function(ParamEVMChain value)? paramEVMChain,
    TResult Function(Timeout value)? timeout,
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
    return _$$OtherFailureImplToJson(
      this,
    );
  }
}

abstract class OtherFailure extends Failure {
  const factory OtherFailure({final String? cause, final String? stack}) =
      _$OtherFailureImpl;
  const OtherFailure._() : super._();

  factory OtherFailure.fromJson(Map<String, dynamic> json) =
      _$OtherFailureImpl.fromJson;

  String? get cause;
  String? get stack;
  @JsonKey(ignore: true)
  _$$OtherFailureImplCopyWith<_$OtherFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

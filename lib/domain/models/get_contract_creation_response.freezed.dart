// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_contract_creation_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetContractCreationResponse _$GetContractCreationResponseFromJson(
    Map<String, dynamic> json) {
  return _GetContractCreationResponse.fromJson(json);
}

/// @nodoc
mixin _$GetContractCreationResponse {
  String get status => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<GetContractCreationResponseResult> get result =>
      throw _privateConstructorUsedError;

  /// Serializes this GetContractCreationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetContractCreationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetContractCreationResponseCopyWith<GetContractCreationResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetContractCreationResponseCopyWith<$Res> {
  factory $GetContractCreationResponseCopyWith(
          GetContractCreationResponse value,
          $Res Function(GetContractCreationResponse) then) =
      _$GetContractCreationResponseCopyWithImpl<$Res,
          GetContractCreationResponse>;
  @useResult
  $Res call(
      {String status,
      String message,
      List<GetContractCreationResponseResult> result});
}

/// @nodoc
class _$GetContractCreationResponseCopyWithImpl<$Res,
        $Val extends GetContractCreationResponse>
    implements $GetContractCreationResponseCopyWith<$Res> {
  _$GetContractCreationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetContractCreationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? result = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as List<GetContractCreationResponseResult>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetContractCreationResponseImplCopyWith<$Res>
    implements $GetContractCreationResponseCopyWith<$Res> {
  factory _$$GetContractCreationResponseImplCopyWith(
          _$GetContractCreationResponseImpl value,
          $Res Function(_$GetContractCreationResponseImpl) then) =
      __$$GetContractCreationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String status,
      String message,
      List<GetContractCreationResponseResult> result});
}

/// @nodoc
class __$$GetContractCreationResponseImplCopyWithImpl<$Res>
    extends _$GetContractCreationResponseCopyWithImpl<$Res,
        _$GetContractCreationResponseImpl>
    implements _$$GetContractCreationResponseImplCopyWith<$Res> {
  __$$GetContractCreationResponseImplCopyWithImpl(
      _$GetContractCreationResponseImpl _value,
      $Res Function(_$GetContractCreationResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetContractCreationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? result = null,
  }) {
    return _then(_$GetContractCreationResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as List<GetContractCreationResponseResult>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetContractCreationResponseImpl
    implements _GetContractCreationResponse {
  const _$GetContractCreationResponseImpl(
      {required this.status,
      required this.message,
      required final List<GetContractCreationResponseResult> result})
      : _result = result;

  factory _$GetContractCreationResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetContractCreationResponseImplFromJson(json);

  @override
  final String status;
  @override
  final String message;
  final List<GetContractCreationResponseResult> _result;
  @override
  List<GetContractCreationResponseResult> get result {
    if (_result is EqualUnmodifiableListView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_result);
  }

  @override
  String toString() {
    return 'GetContractCreationResponse(status: $status, message: $message, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetContractCreationResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._result, _result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message,
      const DeepCollectionEquality().hash(_result));

  /// Create a copy of GetContractCreationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetContractCreationResponseImplCopyWith<_$GetContractCreationResponseImpl>
      get copyWith => __$$GetContractCreationResponseImplCopyWithImpl<
          _$GetContractCreationResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetContractCreationResponseImplToJson(
      this,
    );
  }
}

abstract class _GetContractCreationResponse
    implements GetContractCreationResponse {
  const factory _GetContractCreationResponse(
          {required final String status,
          required final String message,
          required final List<GetContractCreationResponseResult> result}) =
      _$GetContractCreationResponseImpl;

  factory _GetContractCreationResponse.fromJson(Map<String, dynamic> json) =
      _$GetContractCreationResponseImpl.fromJson;

  @override
  String get status;
  @override
  String get message;
  @override
  List<GetContractCreationResponseResult> get result;

  /// Create a copy of GetContractCreationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetContractCreationResponseImplCopyWith<_$GetContractCreationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

GetContractCreationResponseResult _$GetContractCreationResponseResultFromJson(
    Map<String, dynamic> json) {
  return _GetContractCreationResponseResult.fromJson(json);
}

/// @nodoc
mixin _$GetContractCreationResponseResult {
  String get contractAddress => throw _privateConstructorUsedError;
  String get contractCreator => throw _privateConstructorUsedError;
  String get txHash => throw _privateConstructorUsedError;

  /// Serializes this GetContractCreationResponseResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetContractCreationResponseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetContractCreationResponseResultCopyWith<GetContractCreationResponseResult>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetContractCreationResponseResultCopyWith<$Res> {
  factory $GetContractCreationResponseResultCopyWith(
          GetContractCreationResponseResult value,
          $Res Function(GetContractCreationResponseResult) then) =
      _$GetContractCreationResponseResultCopyWithImpl<$Res,
          GetContractCreationResponseResult>;
  @useResult
  $Res call({String contractAddress, String contractCreator, String txHash});
}

/// @nodoc
class _$GetContractCreationResponseResultCopyWithImpl<$Res,
        $Val extends GetContractCreationResponseResult>
    implements $GetContractCreationResponseResultCopyWith<$Res> {
  _$GetContractCreationResponseResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetContractCreationResponseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contractAddress = null,
    Object? contractCreator = null,
    Object? txHash = null,
  }) {
    return _then(_value.copyWith(
      contractAddress: null == contractAddress
          ? _value.contractAddress
          : contractAddress // ignore: cast_nullable_to_non_nullable
              as String,
      contractCreator: null == contractCreator
          ? _value.contractCreator
          : contractCreator // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: null == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetContractCreationResponseResultImplCopyWith<$Res>
    implements $GetContractCreationResponseResultCopyWith<$Res> {
  factory _$$GetContractCreationResponseResultImplCopyWith(
          _$GetContractCreationResponseResultImpl value,
          $Res Function(_$GetContractCreationResponseResultImpl) then) =
      __$$GetContractCreationResponseResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String contractAddress, String contractCreator, String txHash});
}

/// @nodoc
class __$$GetContractCreationResponseResultImplCopyWithImpl<$Res>
    extends _$GetContractCreationResponseResultCopyWithImpl<$Res,
        _$GetContractCreationResponseResultImpl>
    implements _$$GetContractCreationResponseResultImplCopyWith<$Res> {
  __$$GetContractCreationResponseResultImplCopyWithImpl(
      _$GetContractCreationResponseResultImpl _value,
      $Res Function(_$GetContractCreationResponseResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetContractCreationResponseResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contractAddress = null,
    Object? contractCreator = null,
    Object? txHash = null,
  }) {
    return _then(_$GetContractCreationResponseResultImpl(
      contractAddress: null == contractAddress
          ? _value.contractAddress
          : contractAddress // ignore: cast_nullable_to_non_nullable
              as String,
      contractCreator: null == contractCreator
          ? _value.contractCreator
          : contractCreator // ignore: cast_nullable_to_non_nullable
              as String,
      txHash: null == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetContractCreationResponseResultImpl
    implements _GetContractCreationResponseResult {
  const _$GetContractCreationResponseResultImpl(
      {required this.contractAddress,
      required this.contractCreator,
      required this.txHash});

  factory _$GetContractCreationResponseResultImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetContractCreationResponseResultImplFromJson(json);

  @override
  final String contractAddress;
  @override
  final String contractCreator;
  @override
  final String txHash;

  @override
  String toString() {
    return 'GetContractCreationResponseResult(contractAddress: $contractAddress, contractCreator: $contractCreator, txHash: $txHash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetContractCreationResponseResultImpl &&
            (identical(other.contractAddress, contractAddress) ||
                other.contractAddress == contractAddress) &&
            (identical(other.contractCreator, contractCreator) ||
                other.contractCreator == contractCreator) &&
            (identical(other.txHash, txHash) || other.txHash == txHash));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, contractAddress, contractCreator, txHash);

  /// Create a copy of GetContractCreationResponseResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetContractCreationResponseResultImplCopyWith<
          _$GetContractCreationResponseResultImpl>
      get copyWith => __$$GetContractCreationResponseResultImplCopyWithImpl<
          _$GetContractCreationResponseResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetContractCreationResponseResultImplToJson(
      this,
    );
  }
}

abstract class _GetContractCreationResponseResult
    implements GetContractCreationResponseResult {
  const factory _GetContractCreationResponseResult(
      {required final String contractAddress,
      required final String contractCreator,
      required final String txHash}) = _$GetContractCreationResponseResultImpl;

  factory _GetContractCreationResponseResult.fromJson(
          Map<String, dynamic> json) =
      _$GetContractCreationResponseResultImpl.fromJson;

  @override
  String get contractAddress;
  @override
  String get contractCreator;
  @override
  String get txHash;

  /// Create a copy of GetContractCreationResponseResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetContractCreationResponseResultImplCopyWith<
          _$GetContractCreationResponseResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

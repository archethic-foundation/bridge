// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'secret.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Secret _$SecretFromJson(Map<String, dynamic> json) {
  return _Secret.fromJson(json);
}

/// @nodoc
mixin _$Secret {
  String? get secret => throw _privateConstructorUsedError;
  SecretSignature? get secretSignature => throw _privateConstructorUsedError;

  /// Serializes this Secret to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Secret
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecretCopyWith<Secret> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecretCopyWith<$Res> {
  factory $SecretCopyWith(Secret value, $Res Function(Secret) then) =
      _$SecretCopyWithImpl<$Res, Secret>;
  @useResult
  $Res call({String? secret, SecretSignature? secretSignature});

  $SecretSignatureCopyWith<$Res>? get secretSignature;
}

/// @nodoc
class _$SecretCopyWithImpl<$Res, $Val extends Secret>
    implements $SecretCopyWith<$Res> {
  _$SecretCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Secret
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? secret = freezed,
    Object? secretSignature = freezed,
  }) {
    return _then(_value.copyWith(
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
      secretSignature: freezed == secretSignature
          ? _value.secretSignature
          : secretSignature // ignore: cast_nullable_to_non_nullable
              as SecretSignature?,
    ) as $Val);
  }

  /// Create a copy of Secret
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SecretSignatureCopyWith<$Res>? get secretSignature {
    if (_value.secretSignature == null) {
      return null;
    }

    return $SecretSignatureCopyWith<$Res>(_value.secretSignature!, (value) {
      return _then(_value.copyWith(secretSignature: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SecretImplCopyWith<$Res> implements $SecretCopyWith<$Res> {
  factory _$$SecretImplCopyWith(
          _$SecretImpl value, $Res Function(_$SecretImpl) then) =
      __$$SecretImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? secret, SecretSignature? secretSignature});

  @override
  $SecretSignatureCopyWith<$Res>? get secretSignature;
}

/// @nodoc
class __$$SecretImplCopyWithImpl<$Res>
    extends _$SecretCopyWithImpl<$Res, _$SecretImpl>
    implements _$$SecretImplCopyWith<$Res> {
  __$$SecretImplCopyWithImpl(
      _$SecretImpl _value, $Res Function(_$SecretImpl) _then)
      : super(_value, _then);

  /// Create a copy of Secret
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? secret = freezed,
    Object? secretSignature = freezed,
  }) {
    return _then(_$SecretImpl(
      secret: freezed == secret
          ? _value.secret
          : secret // ignore: cast_nullable_to_non_nullable
              as String?,
      secretSignature: freezed == secretSignature
          ? _value.secretSignature
          : secretSignature // ignore: cast_nullable_to_non_nullable
              as SecretSignature?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SecretImpl implements _Secret {
  _$SecretImpl({this.secret, this.secretSignature});

  factory _$SecretImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecretImplFromJson(json);

  @override
  final String? secret;
  @override
  final SecretSignature? secretSignature;

  @override
  String toString() {
    return 'Secret(secret: $secret, secretSignature: $secretSignature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecretImpl &&
            (identical(other.secret, secret) || other.secret == secret) &&
            (identical(other.secretSignature, secretSignature) ||
                other.secretSignature == secretSignature));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, secret, secretSignature);

  /// Create a copy of Secret
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecretImplCopyWith<_$SecretImpl> get copyWith =>
      __$$SecretImplCopyWithImpl<_$SecretImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecretImplToJson(
      this,
    );
  }
}

abstract class _Secret implements Secret {
  factory _Secret(
      {final String? secret,
      final SecretSignature? secretSignature}) = _$SecretImpl;

  factory _Secret.fromJson(Map<String, dynamic> json) = _$SecretImpl.fromJson;

  @override
  String? get secret;
  @override
  SecretSignature? get secretSignature;

  /// Create a copy of Secret
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecretImplCopyWith<_$SecretImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SecretSignature _$SecretSignatureFromJson(Map<String, dynamic> json) {
  return _SecretSignature.fromJson(json);
}

/// @nodoc
mixin _$SecretSignature {
  String? get r => throw _privateConstructorUsedError;
  String? get s => throw _privateConstructorUsedError;
  int? get v => throw _privateConstructorUsedError;

  /// Serializes this SecretSignature to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecretSignature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecretSignatureCopyWith<SecretSignature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecretSignatureCopyWith<$Res> {
  factory $SecretSignatureCopyWith(
          SecretSignature value, $Res Function(SecretSignature) then) =
      _$SecretSignatureCopyWithImpl<$Res, SecretSignature>;
  @useResult
  $Res call({String? r, String? s, int? v});
}

/// @nodoc
class _$SecretSignatureCopyWithImpl<$Res, $Val extends SecretSignature>
    implements $SecretSignatureCopyWith<$Res> {
  _$SecretSignatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecretSignature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? r = freezed,
    Object? s = freezed,
    Object? v = freezed,
  }) {
    return _then(_value.copyWith(
      r: freezed == r
          ? _value.r
          : r // ignore: cast_nullable_to_non_nullable
              as String?,
      s: freezed == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SecretSignatureImplCopyWith<$Res>
    implements $SecretSignatureCopyWith<$Res> {
  factory _$$SecretSignatureImplCopyWith(_$SecretSignatureImpl value,
          $Res Function(_$SecretSignatureImpl) then) =
      __$$SecretSignatureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? r, String? s, int? v});
}

/// @nodoc
class __$$SecretSignatureImplCopyWithImpl<$Res>
    extends _$SecretSignatureCopyWithImpl<$Res, _$SecretSignatureImpl>
    implements _$$SecretSignatureImplCopyWith<$Res> {
  __$$SecretSignatureImplCopyWithImpl(
      _$SecretSignatureImpl _value, $Res Function(_$SecretSignatureImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecretSignature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? r = freezed,
    Object? s = freezed,
    Object? v = freezed,
  }) {
    return _then(_$SecretSignatureImpl(
      r: freezed == r
          ? _value.r
          : r // ignore: cast_nullable_to_non_nullable
              as String?,
      s: freezed == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SecretSignatureImpl implements _SecretSignature {
  _$SecretSignatureImpl({this.r, this.s, this.v});

  factory _$SecretSignatureImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecretSignatureImplFromJson(json);

  @override
  final String? r;
  @override
  final String? s;
  @override
  final int? v;

  @override
  String toString() {
    return 'SecretSignature(r: $r, s: $s, v: $v)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecretSignatureImpl &&
            (identical(other.r, r) || other.r == r) &&
            (identical(other.s, s) || other.s == s) &&
            (identical(other.v, v) || other.v == v));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, r, s, v);

  /// Create a copy of SecretSignature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecretSignatureImplCopyWith<_$SecretSignatureImpl> get copyWith =>
      __$$SecretSignatureImplCopyWithImpl<_$SecretSignatureImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecretSignatureImplToJson(
      this,
    );
  }
}

abstract class _SecretSignature implements SecretSignature {
  factory _SecretSignature({final String? r, final String? s, final int? v}) =
      _$SecretSignatureImpl;

  factory _SecretSignature.fromJson(Map<String, dynamic> json) =
      _$SecretSignatureImpl.fromJson;

  @override
  String? get r;
  @override
  String? get s;
  @override
  int? get v;

  /// Create a copy of SecretSignature
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecretSignatureImplCopyWith<_$SecretSignatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SecretHash _$SecretHashFromJson(Map<String, dynamic> json) {
  return _SecretHash.fromJson(json);
}

/// @nodoc
mixin _$SecretHash {
  String? get secretHash => throw _privateConstructorUsedError;
  SecretHashSignature? get secretHashSignature =>
      throw _privateConstructorUsedError;

  /// Serializes this SecretHash to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecretHash
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecretHashCopyWith<SecretHash> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecretHashCopyWith<$Res> {
  factory $SecretHashCopyWith(
          SecretHash value, $Res Function(SecretHash) then) =
      _$SecretHashCopyWithImpl<$Res, SecretHash>;
  @useResult
  $Res call({String? secretHash, SecretHashSignature? secretHashSignature});

  $SecretHashSignatureCopyWith<$Res>? get secretHashSignature;
}

/// @nodoc
class _$SecretHashCopyWithImpl<$Res, $Val extends SecretHash>
    implements $SecretHashCopyWith<$Res> {
  _$SecretHashCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecretHash
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? secretHash = freezed,
    Object? secretHashSignature = freezed,
  }) {
    return _then(_value.copyWith(
      secretHash: freezed == secretHash
          ? _value.secretHash
          : secretHash // ignore: cast_nullable_to_non_nullable
              as String?,
      secretHashSignature: freezed == secretHashSignature
          ? _value.secretHashSignature
          : secretHashSignature // ignore: cast_nullable_to_non_nullable
              as SecretHashSignature?,
    ) as $Val);
  }

  /// Create a copy of SecretHash
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SecretHashSignatureCopyWith<$Res>? get secretHashSignature {
    if (_value.secretHashSignature == null) {
      return null;
    }

    return $SecretHashSignatureCopyWith<$Res>(_value.secretHashSignature!,
        (value) {
      return _then(_value.copyWith(secretHashSignature: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SecretHashImplCopyWith<$Res>
    implements $SecretHashCopyWith<$Res> {
  factory _$$SecretHashImplCopyWith(
          _$SecretHashImpl value, $Res Function(_$SecretHashImpl) then) =
      __$$SecretHashImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? secretHash, SecretHashSignature? secretHashSignature});

  @override
  $SecretHashSignatureCopyWith<$Res>? get secretHashSignature;
}

/// @nodoc
class __$$SecretHashImplCopyWithImpl<$Res>
    extends _$SecretHashCopyWithImpl<$Res, _$SecretHashImpl>
    implements _$$SecretHashImplCopyWith<$Res> {
  __$$SecretHashImplCopyWithImpl(
      _$SecretHashImpl _value, $Res Function(_$SecretHashImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecretHash
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? secretHash = freezed,
    Object? secretHashSignature = freezed,
  }) {
    return _then(_$SecretHashImpl(
      secretHash: freezed == secretHash
          ? _value.secretHash
          : secretHash // ignore: cast_nullable_to_non_nullable
              as String?,
      secretHashSignature: freezed == secretHashSignature
          ? _value.secretHashSignature
          : secretHashSignature // ignore: cast_nullable_to_non_nullable
              as SecretHashSignature?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SecretHashImpl implements _SecretHash {
  _$SecretHashImpl({this.secretHash, this.secretHashSignature});

  factory _$SecretHashImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecretHashImplFromJson(json);

  @override
  final String? secretHash;
  @override
  final SecretHashSignature? secretHashSignature;

  @override
  String toString() {
    return 'SecretHash(secretHash: $secretHash, secretHashSignature: $secretHashSignature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecretHashImpl &&
            (identical(other.secretHash, secretHash) ||
                other.secretHash == secretHash) &&
            (identical(other.secretHashSignature, secretHashSignature) ||
                other.secretHashSignature == secretHashSignature));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, secretHash, secretHashSignature);

  /// Create a copy of SecretHash
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecretHashImplCopyWith<_$SecretHashImpl> get copyWith =>
      __$$SecretHashImplCopyWithImpl<_$SecretHashImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecretHashImplToJson(
      this,
    );
  }
}

abstract class _SecretHash implements SecretHash {
  factory _SecretHash(
      {final String? secretHash,
      final SecretHashSignature? secretHashSignature}) = _$SecretHashImpl;

  factory _SecretHash.fromJson(Map<String, dynamic> json) =
      _$SecretHashImpl.fromJson;

  @override
  String? get secretHash;
  @override
  SecretHashSignature? get secretHashSignature;

  /// Create a copy of SecretHash
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecretHashImplCopyWith<_$SecretHashImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SecretHashSignature _$SecretHashSignatureFromJson(Map<String, dynamic> json) {
  return _SecretHashSignature.fromJson(json);
}

/// @nodoc
mixin _$SecretHashSignature {
  String? get r => throw _privateConstructorUsedError;
  String? get s => throw _privateConstructorUsedError;
  int? get v => throw _privateConstructorUsedError;

  /// Serializes this SecretHashSignature to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SecretHashSignature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SecretHashSignatureCopyWith<SecretHashSignature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecretHashSignatureCopyWith<$Res> {
  factory $SecretHashSignatureCopyWith(
          SecretHashSignature value, $Res Function(SecretHashSignature) then) =
      _$SecretHashSignatureCopyWithImpl<$Res, SecretHashSignature>;
  @useResult
  $Res call({String? r, String? s, int? v});
}

/// @nodoc
class _$SecretHashSignatureCopyWithImpl<$Res, $Val extends SecretHashSignature>
    implements $SecretHashSignatureCopyWith<$Res> {
  _$SecretHashSignatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecretHashSignature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? r = freezed,
    Object? s = freezed,
    Object? v = freezed,
  }) {
    return _then(_value.copyWith(
      r: freezed == r
          ? _value.r
          : r // ignore: cast_nullable_to_non_nullable
              as String?,
      s: freezed == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SecretHashSignatureImplCopyWith<$Res>
    implements $SecretHashSignatureCopyWith<$Res> {
  factory _$$SecretHashSignatureImplCopyWith(_$SecretHashSignatureImpl value,
          $Res Function(_$SecretHashSignatureImpl) then) =
      __$$SecretHashSignatureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? r, String? s, int? v});
}

/// @nodoc
class __$$SecretHashSignatureImplCopyWithImpl<$Res>
    extends _$SecretHashSignatureCopyWithImpl<$Res, _$SecretHashSignatureImpl>
    implements _$$SecretHashSignatureImplCopyWith<$Res> {
  __$$SecretHashSignatureImplCopyWithImpl(_$SecretHashSignatureImpl _value,
      $Res Function(_$SecretHashSignatureImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecretHashSignature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? r = freezed,
    Object? s = freezed,
    Object? v = freezed,
  }) {
    return _then(_$SecretHashSignatureImpl(
      r: freezed == r
          ? _value.r
          : r // ignore: cast_nullable_to_non_nullable
              as String?,
      s: freezed == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SecretHashSignatureImpl implements _SecretHashSignature {
  _$SecretHashSignatureImpl({this.r, this.s, this.v});

  factory _$SecretHashSignatureImpl.fromJson(Map<String, dynamic> json) =>
      _$$SecretHashSignatureImplFromJson(json);

  @override
  final String? r;
  @override
  final String? s;
  @override
  final int? v;

  @override
  String toString() {
    return 'SecretHashSignature(r: $r, s: $s, v: $v)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecretHashSignatureImpl &&
            (identical(other.r, r) || other.r == r) &&
            (identical(other.s, s) || other.s == s) &&
            (identical(other.v, v) || other.v == v));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, r, s, v);

  /// Create a copy of SecretHashSignature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecretHashSignatureImplCopyWith<_$SecretHashSignatureImpl> get copyWith =>
      __$$SecretHashSignatureImplCopyWithImpl<_$SecretHashSignatureImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecretHashSignatureImplToJson(
      this,
    );
  }
}

abstract class _SecretHashSignature implements SecretHashSignature {
  factory _SecretHashSignature(
      {final String? r,
      final String? s,
      final int? v}) = _$SecretHashSignatureImpl;

  factory _SecretHashSignature.fromJson(Map<String, dynamic> json) =
      _$SecretHashSignatureImpl.fromJson;

  @override
  String? get r;
  @override
  String? get s;
  @override
  int? get v;

  /// Create a copy of SecretHashSignature
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecretHashSignatureImplCopyWith<_$SecretHashSignatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

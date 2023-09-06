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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Secret _$SecretFromJson(Map<String, dynamic> json) {
  return _Secret.fromJson(json);
}

/// @nodoc
mixin _$Secret {
  String? get secret => throw _privateConstructorUsedError;
  SecretSignature? get secretSignature => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_SecretCopyWith<$Res> implements $SecretCopyWith<$Res> {
  factory _$$_SecretCopyWith(_$_Secret value, $Res Function(_$_Secret) then) =
      __$$_SecretCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? secret, SecretSignature? secretSignature});

  @override
  $SecretSignatureCopyWith<$Res>? get secretSignature;
}

/// @nodoc
class __$$_SecretCopyWithImpl<$Res>
    extends _$SecretCopyWithImpl<$Res, _$_Secret>
    implements _$$_SecretCopyWith<$Res> {
  __$$_SecretCopyWithImpl(_$_Secret _value, $Res Function(_$_Secret) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? secret = freezed,
    Object? secretSignature = freezed,
  }) {
    return _then(_$_Secret(
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
class _$_Secret implements _Secret {
  _$_Secret({this.secret, this.secretSignature});

  factory _$_Secret.fromJson(Map<String, dynamic> json) =>
      _$$_SecretFromJson(json);

  @override
  final String? secret;
  @override
  final SecretSignature? secretSignature;

  @override
  String toString() {
    return 'Secret(secret: $secret, secretSignature: $secretSignature)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Secret &&
            (identical(other.secret, secret) || other.secret == secret) &&
            (identical(other.secretSignature, secretSignature) ||
                other.secretSignature == secretSignature));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, secret, secretSignature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SecretCopyWith<_$_Secret> get copyWith =>
      __$$_SecretCopyWithImpl<_$_Secret>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SecretToJson(
      this,
    );
  }
}

abstract class _Secret implements Secret {
  factory _Secret(
      {final String? secret,
      final SecretSignature? secretSignature}) = _$_Secret;

  factory _Secret.fromJson(Map<String, dynamic> json) = _$_Secret.fromJson;

  @override
  String? get secret;
  @override
  SecretSignature? get secretSignature;
  @override
  @JsonKey(ignore: true)
  _$$_SecretCopyWith<_$_Secret> get copyWith =>
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_SecretSignatureCopyWith<$Res>
    implements $SecretSignatureCopyWith<$Res> {
  factory _$$_SecretSignatureCopyWith(
          _$_SecretSignature value, $Res Function(_$_SecretSignature) then) =
      __$$_SecretSignatureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? r, String? s, int? v});
}

/// @nodoc
class __$$_SecretSignatureCopyWithImpl<$Res>
    extends _$SecretSignatureCopyWithImpl<$Res, _$_SecretSignature>
    implements _$$_SecretSignatureCopyWith<$Res> {
  __$$_SecretSignatureCopyWithImpl(
      _$_SecretSignature _value, $Res Function(_$_SecretSignature) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? r = freezed,
    Object? s = freezed,
    Object? v = freezed,
  }) {
    return _then(_$_SecretSignature(
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
class _$_SecretSignature implements _SecretSignature {
  _$_SecretSignature({this.r, this.s, this.v});

  factory _$_SecretSignature.fromJson(Map<String, dynamic> json) =>
      _$$_SecretSignatureFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SecretSignature &&
            (identical(other.r, r) || other.r == r) &&
            (identical(other.s, s) || other.s == s) &&
            (identical(other.v, v) || other.v == v));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, r, s, v);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SecretSignatureCopyWith<_$_SecretSignature> get copyWith =>
      __$$_SecretSignatureCopyWithImpl<_$_SecretSignature>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SecretSignatureToJson(
      this,
    );
  }
}

abstract class _SecretSignature implements SecretSignature {
  factory _SecretSignature({final String? r, final String? s, final int? v}) =
      _$_SecretSignature;

  factory _SecretSignature.fromJson(Map<String, dynamic> json) =
      _$_SecretSignature.fromJson;

  @override
  String? get r;
  @override
  String? get s;
  @override
  int? get v;
  @override
  @JsonKey(ignore: true)
  _$$_SecretSignatureCopyWith<_$_SecretSignature> get copyWith =>
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_SecretHashCopyWith<$Res>
    implements $SecretHashCopyWith<$Res> {
  factory _$$_SecretHashCopyWith(
          _$_SecretHash value, $Res Function(_$_SecretHash) then) =
      __$$_SecretHashCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? secretHash, SecretHashSignature? secretHashSignature});

  @override
  $SecretHashSignatureCopyWith<$Res>? get secretHashSignature;
}

/// @nodoc
class __$$_SecretHashCopyWithImpl<$Res>
    extends _$SecretHashCopyWithImpl<$Res, _$_SecretHash>
    implements _$$_SecretHashCopyWith<$Res> {
  __$$_SecretHashCopyWithImpl(
      _$_SecretHash _value, $Res Function(_$_SecretHash) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? secretHash = freezed,
    Object? secretHashSignature = freezed,
  }) {
    return _then(_$_SecretHash(
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
class _$_SecretHash implements _SecretHash {
  _$_SecretHash({this.secretHash, this.secretHashSignature});

  factory _$_SecretHash.fromJson(Map<String, dynamic> json) =>
      _$$_SecretHashFromJson(json);

  @override
  final String? secretHash;
  @override
  final SecretHashSignature? secretHashSignature;

  @override
  String toString() {
    return 'SecretHash(secretHash: $secretHash, secretHashSignature: $secretHashSignature)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SecretHash &&
            (identical(other.secretHash, secretHash) ||
                other.secretHash == secretHash) &&
            (identical(other.secretHashSignature, secretHashSignature) ||
                other.secretHashSignature == secretHashSignature));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, secretHash, secretHashSignature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SecretHashCopyWith<_$_SecretHash> get copyWith =>
      __$$_SecretHashCopyWithImpl<_$_SecretHash>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SecretHashToJson(
      this,
    );
  }
}

abstract class _SecretHash implements SecretHash {
  factory _SecretHash(
      {final String? secretHash,
      final SecretHashSignature? secretHashSignature}) = _$_SecretHash;

  factory _SecretHash.fromJson(Map<String, dynamic> json) =
      _$_SecretHash.fromJson;

  @override
  String? get secretHash;
  @override
  SecretHashSignature? get secretHashSignature;
  @override
  @JsonKey(ignore: true)
  _$$_SecretHashCopyWith<_$_SecretHash> get copyWith =>
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_SecretHashSignatureCopyWith<$Res>
    implements $SecretHashSignatureCopyWith<$Res> {
  factory _$$_SecretHashSignatureCopyWith(_$_SecretHashSignature value,
          $Res Function(_$_SecretHashSignature) then) =
      __$$_SecretHashSignatureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? r, String? s, int? v});
}

/// @nodoc
class __$$_SecretHashSignatureCopyWithImpl<$Res>
    extends _$SecretHashSignatureCopyWithImpl<$Res, _$_SecretHashSignature>
    implements _$$_SecretHashSignatureCopyWith<$Res> {
  __$$_SecretHashSignatureCopyWithImpl(_$_SecretHashSignature _value,
      $Res Function(_$_SecretHashSignature) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? r = freezed,
    Object? s = freezed,
    Object? v = freezed,
  }) {
    return _then(_$_SecretHashSignature(
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
class _$_SecretHashSignature implements _SecretHashSignature {
  _$_SecretHashSignature({this.r, this.s, this.v});

  factory _$_SecretHashSignature.fromJson(Map<String, dynamic> json) =>
      _$$_SecretHashSignatureFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SecretHashSignature &&
            (identical(other.r, r) || other.r == r) &&
            (identical(other.s, s) || other.s == s) &&
            (identical(other.v, v) || other.v == v));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, r, s, v);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SecretHashSignatureCopyWith<_$_SecretHashSignature> get copyWith =>
      __$$_SecretHashSignatureCopyWithImpl<_$_SecretHashSignature>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SecretHashSignatureToJson(
      this,
    );
  }
}

abstract class _SecretHashSignature implements SecretHashSignature {
  factory _SecretHashSignature(
      {final String? r,
      final String? s,
      final int? v}) = _$_SecretHashSignature;

  factory _SecretHashSignature.fromJson(Map<String, dynamic> json) =
      _$_SecretHashSignature.fromJson;

  @override
  String? get r;
  @override
  String? get s;
  @override
  int? get v;
  @override
  @JsonKey(ignore: true)
  _$$_SecretHashSignatureCopyWith<_$_SecretHashSignature> get copyWith =>
      throw _privateConstructorUsedError;
}

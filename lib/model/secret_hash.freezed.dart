// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'secret_hash.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bridge_blockchain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BridgeBlockchain _$BridgeBlockchainFromJson(Map<String, dynamic> json) {
  return _BridgeBlockchain.fromJson(json);
}

/// @nodoc
mixin _$BridgeBlockchain {
  String get name => throw _privateConstructorUsedError;
  int get chainId => throw _privateConstructorUsedError;
  String get env => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get urlExplorer => throw _privateConstructorUsedError;
  String get providerEndpoint => throw _privateConstructorUsedError;
  String? get htlcAddress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BridgeBlockchainCopyWith<BridgeBlockchain> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BridgeBlockchainCopyWith<$Res> {
  factory $BridgeBlockchainCopyWith(
          BridgeBlockchain value, $Res Function(BridgeBlockchain) then) =
      _$BridgeBlockchainCopyWithImpl<$Res, BridgeBlockchain>;
  @useResult
  $Res call(
      {String name,
      int chainId,
      String env,
      String icon,
      String urlExplorer,
      String providerEndpoint,
      String? htlcAddress});
}

/// @nodoc
class _$BridgeBlockchainCopyWithImpl<$Res, $Val extends BridgeBlockchain>
    implements $BridgeBlockchainCopyWith<$Res> {
  _$BridgeBlockchainCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? chainId = null,
    Object? env = null,
    Object? icon = null,
    Object? urlExplorer = null,
    Object? providerEndpoint = null,
    Object? htlcAddress = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      env: null == env
          ? _value.env
          : env // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      urlExplorer: null == urlExplorer
          ? _value.urlExplorer
          : urlExplorer // ignore: cast_nullable_to_non_nullable
              as String,
      providerEndpoint: null == providerEndpoint
          ? _value.providerEndpoint
          : providerEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
      htlcAddress: freezed == htlcAddress
          ? _value.htlcAddress
          : htlcAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BridgeBlockchainCopyWith<$Res>
    implements $BridgeBlockchainCopyWith<$Res> {
  factory _$$_BridgeBlockchainCopyWith(
          _$_BridgeBlockchain value, $Res Function(_$_BridgeBlockchain) then) =
      __$$_BridgeBlockchainCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int chainId,
      String env,
      String icon,
      String urlExplorer,
      String providerEndpoint,
      String? htlcAddress});
}

/// @nodoc
class __$$_BridgeBlockchainCopyWithImpl<$Res>
    extends _$BridgeBlockchainCopyWithImpl<$Res, _$_BridgeBlockchain>
    implements _$$_BridgeBlockchainCopyWith<$Res> {
  __$$_BridgeBlockchainCopyWithImpl(
      _$_BridgeBlockchain _value, $Res Function(_$_BridgeBlockchain) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? chainId = null,
    Object? env = null,
    Object? icon = null,
    Object? urlExplorer = null,
    Object? providerEndpoint = null,
    Object? htlcAddress = freezed,
  }) {
    return _then(_$_BridgeBlockchain(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      env: null == env
          ? _value.env
          : env // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      urlExplorer: null == urlExplorer
          ? _value.urlExplorer
          : urlExplorer // ignore: cast_nullable_to_non_nullable
              as String,
      providerEndpoint: null == providerEndpoint
          ? _value.providerEndpoint
          : providerEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
      htlcAddress: freezed == htlcAddress
          ? _value.htlcAddress
          : htlcAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BridgeBlockchain extends _BridgeBlockchain {
  const _$_BridgeBlockchain(
      {this.name = '',
      this.chainId = 0,
      this.env = '',
      this.icon = '',
      this.urlExplorer = '',
      this.providerEndpoint = '',
      this.htlcAddress})
      : super._();

  factory _$_BridgeBlockchain.fromJson(Map<String, dynamic> json) =>
      _$$_BridgeBlockchainFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int chainId;
  @override
  @JsonKey()
  final String env;
  @override
  @JsonKey()
  final String icon;
  @override
  @JsonKey()
  final String urlExplorer;
  @override
  @JsonKey()
  final String providerEndpoint;
  @override
  final String? htlcAddress;

  @override
  String toString() {
    return 'BridgeBlockchain(name: $name, chainId: $chainId, env: $env, icon: $icon, urlExplorer: $urlExplorer, providerEndpoint: $providerEndpoint, htlcAddress: $htlcAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BridgeBlockchain &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.env, env) || other.env == env) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.urlExplorer, urlExplorer) ||
                other.urlExplorer == urlExplorer) &&
            (identical(other.providerEndpoint, providerEndpoint) ||
                other.providerEndpoint == providerEndpoint) &&
            (identical(other.htlcAddress, htlcAddress) ||
                other.htlcAddress == htlcAddress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, chainId, env, icon,
      urlExplorer, providerEndpoint, htlcAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BridgeBlockchainCopyWith<_$_BridgeBlockchain> get copyWith =>
      __$$_BridgeBlockchainCopyWithImpl<_$_BridgeBlockchain>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BridgeBlockchainToJson(
      this,
    );
  }
}

abstract class _BridgeBlockchain extends BridgeBlockchain {
  const factory _BridgeBlockchain(
      {final String name,
      final int chainId,
      final String env,
      final String icon,
      final String urlExplorer,
      final String providerEndpoint,
      final String? htlcAddress}) = _$_BridgeBlockchain;
  const _BridgeBlockchain._() : super._();

  factory _BridgeBlockchain.fromJson(Map<String, dynamic> json) =
      _$_BridgeBlockchain.fromJson;

  @override
  String get name;
  @override
  int get chainId;
  @override
  String get env;
  @override
  String get icon;
  @override
  String get urlExplorer;
  @override
  String get providerEndpoint;
  @override
  String? get htlcAddress;
  @override
  @JsonKey(ignore: true)
  _$$_BridgeBlockchainCopyWith<_$_BridgeBlockchain> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bridge_token_per_bridge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BridgeTokensPerBridge _$BridgeTokensPerBridgeFromJson(
    Map<String, dynamic> json) {
  return _BridgeTokensPerBridge.fromJson(json);
}

/// @nodoc
mixin _$BridgeTokensPerBridge {
  Map<String, List<TokenData>>? get tokens =>
      throw _privateConstructorUsedError;

  /// Serializes this BridgeTokensPerBridge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BridgeTokensPerBridge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BridgeTokensPerBridgeCopyWith<BridgeTokensPerBridge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BridgeTokensPerBridgeCopyWith<$Res> {
  factory $BridgeTokensPerBridgeCopyWith(BridgeTokensPerBridge value,
          $Res Function(BridgeTokensPerBridge) then) =
      _$BridgeTokensPerBridgeCopyWithImpl<$Res, BridgeTokensPerBridge>;
  @useResult
  $Res call({Map<String, List<TokenData>>? tokens});
}

/// @nodoc
class _$BridgeTokensPerBridgeCopyWithImpl<$Res,
        $Val extends BridgeTokensPerBridge>
    implements $BridgeTokensPerBridgeCopyWith<$Res> {
  _$BridgeTokensPerBridgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BridgeTokensPerBridge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = freezed,
  }) {
    return _then(_value.copyWith(
      tokens: freezed == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, List<TokenData>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BridgeTokensPerBridgeImplCopyWith<$Res>
    implements $BridgeTokensPerBridgeCopyWith<$Res> {
  factory _$$BridgeTokensPerBridgeImplCopyWith(
          _$BridgeTokensPerBridgeImpl value,
          $Res Function(_$BridgeTokensPerBridgeImpl) then) =
      __$$BridgeTokensPerBridgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, List<TokenData>>? tokens});
}

/// @nodoc
class __$$BridgeTokensPerBridgeImplCopyWithImpl<$Res>
    extends _$BridgeTokensPerBridgeCopyWithImpl<$Res,
        _$BridgeTokensPerBridgeImpl>
    implements _$$BridgeTokensPerBridgeImplCopyWith<$Res> {
  __$$BridgeTokensPerBridgeImplCopyWithImpl(_$BridgeTokensPerBridgeImpl _value,
      $Res Function(_$BridgeTokensPerBridgeImpl) _then)
      : super(_value, _then);

  /// Create a copy of BridgeTokensPerBridge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = freezed,
  }) {
    return _then(_$BridgeTokensPerBridgeImpl(
      tokens: freezed == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, List<TokenData>>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BridgeTokensPerBridgeImpl implements _BridgeTokensPerBridge {
  const _$BridgeTokensPerBridgeImpl(
      {final Map<String, List<TokenData>>? tokens})
      : _tokens = tokens;

  factory _$BridgeTokensPerBridgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$BridgeTokensPerBridgeImplFromJson(json);

  final Map<String, List<TokenData>>? _tokens;
  @override
  Map<String, List<TokenData>>? get tokens {
    final value = _tokens;
    if (value == null) return null;
    if (_tokens is EqualUnmodifiableMapView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BridgeTokensPerBridge(tokens: $tokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BridgeTokensPerBridgeImpl &&
            const DeepCollectionEquality().equals(other._tokens, _tokens));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tokens));

  /// Create a copy of BridgeTokensPerBridge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BridgeTokensPerBridgeImplCopyWith<_$BridgeTokensPerBridgeImpl>
      get copyWith => __$$BridgeTokensPerBridgeImplCopyWithImpl<
          _$BridgeTokensPerBridgeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BridgeTokensPerBridgeImplToJson(
      this,
    );
  }
}

abstract class _BridgeTokensPerBridge implements BridgeTokensPerBridge {
  const factory _BridgeTokensPerBridge(
          {final Map<String, List<TokenData>>? tokens}) =
      _$BridgeTokensPerBridgeImpl;

  factory _BridgeTokensPerBridge.fromJson(Map<String, dynamic> json) =
      _$BridgeTokensPerBridgeImpl.fromJson;

  @override
  Map<String, List<TokenData>>? get tokens;

  /// Create a copy of BridgeTokensPerBridge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BridgeTokensPerBridgeImplCopyWith<_$BridgeTokensPerBridgeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TokenData _$TokenDataFromJson(Map<String, dynamic> json) {
  return _TokenData.fromJson(json);
}

/// @nodoc
mixin _$TokenData {
  String get name => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get targetTokenName => throw _privateConstructorUsedError;
  String get targetTokenSymbol => throw _privateConstructorUsedError;
  String get poolAddressFrom => throw _privateConstructorUsedError;
  String get poolAddressTo => throw _privateConstructorUsedError;
  String get typeSource => throw _privateConstructorUsedError;
  String get typeTarget => throw _privateConstructorUsedError;
  String get tokenAddressSource => throw _privateConstructorUsedError;
  String get tokenAddressTarget => throw _privateConstructorUsedError;
  String get ucoV1Address => throw _privateConstructorUsedError;
  bool? get contractToMintAndBurn => throw _privateConstructorUsedError;

  /// Serializes this TokenData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenDataCopyWith<TokenData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenDataCopyWith<$Res> {
  factory $TokenDataCopyWith(TokenData value, $Res Function(TokenData) then) =
      _$TokenDataCopyWithImpl<$Res, TokenData>;
  @useResult
  $Res call(
      {String name,
      String symbol,
      String targetTokenName,
      String targetTokenSymbol,
      String poolAddressFrom,
      String poolAddressTo,
      String typeSource,
      String typeTarget,
      String tokenAddressSource,
      String tokenAddressTarget,
      String ucoV1Address,
      bool? contractToMintAndBurn});
}

/// @nodoc
class _$TokenDataCopyWithImpl<$Res, $Val extends TokenData>
    implements $TokenDataCopyWith<$Res> {
  _$TokenDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? targetTokenName = null,
    Object? targetTokenSymbol = null,
    Object? poolAddressFrom = null,
    Object? poolAddressTo = null,
    Object? typeSource = null,
    Object? typeTarget = null,
    Object? tokenAddressSource = null,
    Object? tokenAddressTarget = null,
    Object? ucoV1Address = null,
    Object? contractToMintAndBurn = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      targetTokenName: null == targetTokenName
          ? _value.targetTokenName
          : targetTokenName // ignore: cast_nullable_to_non_nullable
              as String,
      targetTokenSymbol: null == targetTokenSymbol
          ? _value.targetTokenSymbol
          : targetTokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      poolAddressFrom: null == poolAddressFrom
          ? _value.poolAddressFrom
          : poolAddressFrom // ignore: cast_nullable_to_non_nullable
              as String,
      poolAddressTo: null == poolAddressTo
          ? _value.poolAddressTo
          : poolAddressTo // ignore: cast_nullable_to_non_nullable
              as String,
      typeSource: null == typeSource
          ? _value.typeSource
          : typeSource // ignore: cast_nullable_to_non_nullable
              as String,
      typeTarget: null == typeTarget
          ? _value.typeTarget
          : typeTarget // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddressSource: null == tokenAddressSource
          ? _value.tokenAddressSource
          : tokenAddressSource // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddressTarget: null == tokenAddressTarget
          ? _value.tokenAddressTarget
          : tokenAddressTarget // ignore: cast_nullable_to_non_nullable
              as String,
      ucoV1Address: null == ucoV1Address
          ? _value.ucoV1Address
          : ucoV1Address // ignore: cast_nullable_to_non_nullable
              as String,
      contractToMintAndBurn: freezed == contractToMintAndBurn
          ? _value.contractToMintAndBurn
          : contractToMintAndBurn // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenDataImplCopyWith<$Res>
    implements $TokenDataCopyWith<$Res> {
  factory _$$TokenDataImplCopyWith(
          _$TokenDataImpl value, $Res Function(_$TokenDataImpl) then) =
      __$$TokenDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String symbol,
      String targetTokenName,
      String targetTokenSymbol,
      String poolAddressFrom,
      String poolAddressTo,
      String typeSource,
      String typeTarget,
      String tokenAddressSource,
      String tokenAddressTarget,
      String ucoV1Address,
      bool? contractToMintAndBurn});
}

/// @nodoc
class __$$TokenDataImplCopyWithImpl<$Res>
    extends _$TokenDataCopyWithImpl<$Res, _$TokenDataImpl>
    implements _$$TokenDataImplCopyWith<$Res> {
  __$$TokenDataImplCopyWithImpl(
      _$TokenDataImpl _value, $Res Function(_$TokenDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? targetTokenName = null,
    Object? targetTokenSymbol = null,
    Object? poolAddressFrom = null,
    Object? poolAddressTo = null,
    Object? typeSource = null,
    Object? typeTarget = null,
    Object? tokenAddressSource = null,
    Object? tokenAddressTarget = null,
    Object? ucoV1Address = null,
    Object? contractToMintAndBurn = freezed,
  }) {
    return _then(_$TokenDataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      targetTokenName: null == targetTokenName
          ? _value.targetTokenName
          : targetTokenName // ignore: cast_nullable_to_non_nullable
              as String,
      targetTokenSymbol: null == targetTokenSymbol
          ? _value.targetTokenSymbol
          : targetTokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
      poolAddressFrom: null == poolAddressFrom
          ? _value.poolAddressFrom
          : poolAddressFrom // ignore: cast_nullable_to_non_nullable
              as String,
      poolAddressTo: null == poolAddressTo
          ? _value.poolAddressTo
          : poolAddressTo // ignore: cast_nullable_to_non_nullable
              as String,
      typeSource: null == typeSource
          ? _value.typeSource
          : typeSource // ignore: cast_nullable_to_non_nullable
              as String,
      typeTarget: null == typeTarget
          ? _value.typeTarget
          : typeTarget // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddressSource: null == tokenAddressSource
          ? _value.tokenAddressSource
          : tokenAddressSource // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddressTarget: null == tokenAddressTarget
          ? _value.tokenAddressTarget
          : tokenAddressTarget // ignore: cast_nullable_to_non_nullable
              as String,
      ucoV1Address: null == ucoV1Address
          ? _value.ucoV1Address
          : ucoV1Address // ignore: cast_nullable_to_non_nullable
              as String,
      contractToMintAndBurn: freezed == contractToMintAndBurn
          ? _value.contractToMintAndBurn
          : contractToMintAndBurn // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenDataImpl implements _TokenData {
  _$TokenDataImpl(
      {this.name = '',
      this.symbol = '',
      this.targetTokenName = '',
      this.targetTokenSymbol = '',
      this.poolAddressFrom = '',
      this.poolAddressTo = '',
      this.typeSource = '',
      this.typeTarget = '',
      this.tokenAddressSource = '',
      this.tokenAddressTarget = '',
      this.ucoV1Address = '',
      this.contractToMintAndBurn});

  factory _$TokenDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenDataImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String symbol;
  @override
  @JsonKey()
  final String targetTokenName;
  @override
  @JsonKey()
  final String targetTokenSymbol;
  @override
  @JsonKey()
  final String poolAddressFrom;
  @override
  @JsonKey()
  final String poolAddressTo;
  @override
  @JsonKey()
  final String typeSource;
  @override
  @JsonKey()
  final String typeTarget;
  @override
  @JsonKey()
  final String tokenAddressSource;
  @override
  @JsonKey()
  final String tokenAddressTarget;
  @override
  @JsonKey()
  final String ucoV1Address;
  @override
  final bool? contractToMintAndBurn;

  @override
  String toString() {
    return 'TokenData(name: $name, symbol: $symbol, targetTokenName: $targetTokenName, targetTokenSymbol: $targetTokenSymbol, poolAddressFrom: $poolAddressFrom, poolAddressTo: $poolAddressTo, typeSource: $typeSource, typeTarget: $typeTarget, tokenAddressSource: $tokenAddressSource, tokenAddressTarget: $tokenAddressTarget, ucoV1Address: $ucoV1Address, contractToMintAndBurn: $contractToMintAndBurn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.targetTokenName, targetTokenName) ||
                other.targetTokenName == targetTokenName) &&
            (identical(other.targetTokenSymbol, targetTokenSymbol) ||
                other.targetTokenSymbol == targetTokenSymbol) &&
            (identical(other.poolAddressFrom, poolAddressFrom) ||
                other.poolAddressFrom == poolAddressFrom) &&
            (identical(other.poolAddressTo, poolAddressTo) ||
                other.poolAddressTo == poolAddressTo) &&
            (identical(other.typeSource, typeSource) ||
                other.typeSource == typeSource) &&
            (identical(other.typeTarget, typeTarget) ||
                other.typeTarget == typeTarget) &&
            (identical(other.tokenAddressSource, tokenAddressSource) ||
                other.tokenAddressSource == tokenAddressSource) &&
            (identical(other.tokenAddressTarget, tokenAddressTarget) ||
                other.tokenAddressTarget == tokenAddressTarget) &&
            (identical(other.ucoV1Address, ucoV1Address) ||
                other.ucoV1Address == ucoV1Address) &&
            (identical(other.contractToMintAndBurn, contractToMintAndBurn) ||
                other.contractToMintAndBurn == contractToMintAndBurn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      symbol,
      targetTokenName,
      targetTokenSymbol,
      poolAddressFrom,
      poolAddressTo,
      typeSource,
      typeTarget,
      tokenAddressSource,
      tokenAddressTarget,
      ucoV1Address,
      contractToMintAndBurn);

  /// Create a copy of TokenData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenDataImplCopyWith<_$TokenDataImpl> get copyWith =>
      __$$TokenDataImplCopyWithImpl<_$TokenDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenDataImplToJson(
      this,
    );
  }
}

abstract class _TokenData implements TokenData {
  factory _TokenData(
      {final String name,
      final String symbol,
      final String targetTokenName,
      final String targetTokenSymbol,
      final String poolAddressFrom,
      final String poolAddressTo,
      final String typeSource,
      final String typeTarget,
      final String tokenAddressSource,
      final String tokenAddressTarget,
      final String ucoV1Address,
      final bool? contractToMintAndBurn}) = _$TokenDataImpl;

  factory _TokenData.fromJson(Map<String, dynamic> json) =
      _$TokenDataImpl.fromJson;

  @override
  String get name;
  @override
  String get symbol;
  @override
  String get targetTokenName;
  @override
  String get targetTokenSymbol;
  @override
  String get poolAddressFrom;
  @override
  String get poolAddressTo;
  @override
  String get typeSource;
  @override
  String get typeTarget;
  @override
  String get tokenAddressSource;
  @override
  String get tokenAddressTarget;
  @override
  String get ucoV1Address;
  @override
  bool? get contractToMintAndBurn;

  /// Create a copy of TokenData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenDataImplCopyWith<_$TokenDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tokens));

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
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
  String get type => throw _privateConstructorUsedError;
  String get tokenAddressSource => throw _privateConstructorUsedError;
  String get tokenAddressTarget => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      String type,
      String tokenAddressSource,
      String tokenAddressTarget});
}

/// @nodoc
class _$TokenDataCopyWithImpl<$Res, $Val extends TokenData>
    implements $TokenDataCopyWith<$Res> {
  _$TokenDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? targetTokenName = null,
    Object? targetTokenSymbol = null,
    Object? poolAddressFrom = null,
    Object? poolAddressTo = null,
    Object? type = null,
    Object? tokenAddressSource = null,
    Object? tokenAddressTarget = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddressSource: null == tokenAddressSource
          ? _value.tokenAddressSource
          : tokenAddressSource // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddressTarget: null == tokenAddressTarget
          ? _value.tokenAddressTarget
          : tokenAddressTarget // ignore: cast_nullable_to_non_nullable
              as String,
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
      String type,
      String tokenAddressSource,
      String tokenAddressTarget});
}

/// @nodoc
class __$$TokenDataImplCopyWithImpl<$Res>
    extends _$TokenDataCopyWithImpl<$Res, _$TokenDataImpl>
    implements _$$TokenDataImplCopyWith<$Res> {
  __$$TokenDataImplCopyWithImpl(
      _$TokenDataImpl _value, $Res Function(_$TokenDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? targetTokenName = null,
    Object? targetTokenSymbol = null,
    Object? poolAddressFrom = null,
    Object? poolAddressTo = null,
    Object? type = null,
    Object? tokenAddressSource = null,
    Object? tokenAddressTarget = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddressSource: null == tokenAddressSource
          ? _value.tokenAddressSource
          : tokenAddressSource // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddressTarget: null == tokenAddressTarget
          ? _value.tokenAddressTarget
          : tokenAddressTarget // ignore: cast_nullable_to_non_nullable
              as String,
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
      this.type = '',
      this.tokenAddressSource = '',
      this.tokenAddressTarget = ''});

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
  final String type;
  @override
  @JsonKey()
  final String tokenAddressSource;
  @override
  @JsonKey()
  final String tokenAddressTarget;

  @override
  String toString() {
    return 'TokenData(name: $name, symbol: $symbol, targetTokenName: $targetTokenName, targetTokenSymbol: $targetTokenSymbol, poolAddressFrom: $poolAddressFrom, poolAddressTo: $poolAddressTo, type: $type, tokenAddressSource: $tokenAddressSource, tokenAddressTarget: $tokenAddressTarget)';
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
            (identical(other.type, type) || other.type == type) &&
            (identical(other.tokenAddressSource, tokenAddressSource) ||
                other.tokenAddressSource == tokenAddressSource) &&
            (identical(other.tokenAddressTarget, tokenAddressTarget) ||
                other.tokenAddressTarget == tokenAddressTarget));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      symbol,
      targetTokenName,
      targetTokenSymbol,
      poolAddressFrom,
      poolAddressTo,
      type,
      tokenAddressSource,
      tokenAddressTarget);

  @JsonKey(ignore: true)
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
      final String type,
      final String tokenAddressSource,
      final String tokenAddressTarget}) = _$TokenDataImpl;

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
  String get type;
  @override
  String get tokenAddressSource;
  @override
  String get tokenAddressTarget;
  @override
  @JsonKey(ignore: true)
  _$$TokenDataImplCopyWith<_$TokenDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

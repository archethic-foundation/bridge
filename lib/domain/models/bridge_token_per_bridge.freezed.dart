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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_BridgeTokensPerBridgeCopyWith<$Res>
    implements $BridgeTokensPerBridgeCopyWith<$Res> {
  factory _$$_BridgeTokensPerBridgeCopyWith(_$_BridgeTokensPerBridge value,
          $Res Function(_$_BridgeTokensPerBridge) then) =
      __$$_BridgeTokensPerBridgeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, List<TokenData>>? tokens});
}

/// @nodoc
class __$$_BridgeTokensPerBridgeCopyWithImpl<$Res>
    extends _$BridgeTokensPerBridgeCopyWithImpl<$Res, _$_BridgeTokensPerBridge>
    implements _$$_BridgeTokensPerBridgeCopyWith<$Res> {
  __$$_BridgeTokensPerBridgeCopyWithImpl(_$_BridgeTokensPerBridge _value,
      $Res Function(_$_BridgeTokensPerBridge) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokens = freezed,
  }) {
    return _then(_$_BridgeTokensPerBridge(
      tokens: freezed == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as Map<String, List<TokenData>>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BridgeTokensPerBridge implements _BridgeTokensPerBridge {
  const _$_BridgeTokensPerBridge({final Map<String, List<TokenData>>? tokens})
      : _tokens = tokens;

  factory _$_BridgeTokensPerBridge.fromJson(Map<String, dynamic> json) =>
      _$$_BridgeTokensPerBridgeFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BridgeTokensPerBridge &&
            const DeepCollectionEquality().equals(other._tokens, _tokens));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tokens));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BridgeTokensPerBridgeCopyWith<_$_BridgeTokensPerBridge> get copyWith =>
      __$$_BridgeTokensPerBridgeCopyWithImpl<_$_BridgeTokensPerBridge>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BridgeTokensPerBridgeToJson(
      this,
    );
  }
}

abstract class _BridgeTokensPerBridge implements BridgeTokensPerBridge {
  const factory _BridgeTokensPerBridge(
      {final Map<String, List<TokenData>>? tokens}) = _$_BridgeTokensPerBridge;

  factory _BridgeTokensPerBridge.fromJson(Map<String, dynamic> json) =
      _$_BridgeTokensPerBridge.fromJson;

  @override
  Map<String, List<TokenData>>? get tokens;
  @override
  @JsonKey(ignore: true)
  _$$_BridgeTokensPerBridgeCopyWith<_$_BridgeTokensPerBridge> get copyWith =>
      throw _privateConstructorUsedError;
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
  String get tokenAddress => throw _privateConstructorUsedError;

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
      String tokenAddress});
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
    Object? tokenAddress = null,
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
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TokenDataCopyWith<$Res> implements $TokenDataCopyWith<$Res> {
  factory _$$_TokenDataCopyWith(
          _$_TokenData value, $Res Function(_$_TokenData) then) =
      __$$_TokenDataCopyWithImpl<$Res>;
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
      String tokenAddress});
}

/// @nodoc
class __$$_TokenDataCopyWithImpl<$Res>
    extends _$TokenDataCopyWithImpl<$Res, _$_TokenData>
    implements _$$_TokenDataCopyWith<$Res> {
  __$$_TokenDataCopyWithImpl(
      _$_TokenData _value, $Res Function(_$_TokenData) _then)
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
    Object? tokenAddress = null,
  }) {
    return _then(_$_TokenData(
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
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TokenData implements _TokenData {
  _$_TokenData(
      {this.name = '',
      this.symbol = '',
      this.targetTokenName = '',
      this.targetTokenSymbol = '',
      this.poolAddressFrom = '',
      this.poolAddressTo = '',
      this.type = '',
      this.tokenAddress = ''});

  factory _$_TokenData.fromJson(Map<String, dynamic> json) =>
      _$$_TokenDataFromJson(json);

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
  final String tokenAddress;

  @override
  String toString() {
    return 'TokenData(name: $name, symbol: $symbol, targetTokenName: $targetTokenName, targetTokenSymbol: $targetTokenSymbol, poolAddressFrom: $poolAddressFrom, poolAddressTo: $poolAddressTo, type: $type, tokenAddress: $tokenAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TokenData &&
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
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, symbol, targetTokenName,
      targetTokenSymbol, poolAddressFrom, poolAddressTo, type, tokenAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TokenDataCopyWith<_$_TokenData> get copyWith =>
      __$$_TokenDataCopyWithImpl<_$_TokenData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TokenDataToJson(
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
      final String tokenAddress}) = _$_TokenData;

  factory _TokenData.fromJson(Map<String, dynamic> json) =
      _$_TokenData.fromJson;

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
  String get tokenAddress;
  @override
  @JsonKey(ignore: true)
  _$$_TokenDataCopyWith<_$_TokenData> get copyWith =>
      throw _privateConstructorUsedError;
}

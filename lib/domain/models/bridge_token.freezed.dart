// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bridge_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BridgeToken _$BridgeTokenFromJson(Map<String, dynamic> json) {
  return _BridgeToken.fromJson(json);
}

/// @nodoc
mixin _$BridgeToken {
  String get name => throw _privateConstructorUsedError;
  String get tokenAddress => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get targetTokenName => throw _privateConstructorUsedError;
  String get targetTokenSymbol => throw _privateConstructorUsedError;
  String get poolAddressFrom => throw _privateConstructorUsedError;
  String get poolAddressTo => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BridgeTokenCopyWith<BridgeToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BridgeTokenCopyWith<$Res> {
  factory $BridgeTokenCopyWith(
          BridgeToken value, $Res Function(BridgeToken) then) =
      _$BridgeTokenCopyWithImpl<$Res, BridgeToken>;
  @useResult
  $Res call(
      {String name,
      String tokenAddress,
      String symbol,
      String targetTokenName,
      String targetTokenSymbol,
      String poolAddressFrom,
      String poolAddressTo,
      String type});
}

/// @nodoc
class _$BridgeTokenCopyWithImpl<$Res, $Val extends BridgeToken>
    implements $BridgeTokenCopyWith<$Res> {
  _$BridgeTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? tokenAddress = null,
    Object? symbol = null,
    Object? targetTokenName = null,
    Object? targetTokenSymbol = null,
    Object? poolAddressFrom = null,
    Object? poolAddressTo = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BridgeTokenCopyWith<$Res>
    implements $BridgeTokenCopyWith<$Res> {
  factory _$$_BridgeTokenCopyWith(
          _$_BridgeToken value, $Res Function(_$_BridgeToken) then) =
      __$$_BridgeTokenCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String tokenAddress,
      String symbol,
      String targetTokenName,
      String targetTokenSymbol,
      String poolAddressFrom,
      String poolAddressTo,
      String type});
}

/// @nodoc
class __$$_BridgeTokenCopyWithImpl<$Res>
    extends _$BridgeTokenCopyWithImpl<$Res, _$_BridgeToken>
    implements _$$_BridgeTokenCopyWith<$Res> {
  __$$_BridgeTokenCopyWithImpl(
      _$_BridgeToken _value, $Res Function(_$_BridgeToken) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? tokenAddress = null,
    Object? symbol = null,
    Object? targetTokenName = null,
    Object? targetTokenSymbol = null,
    Object? poolAddressFrom = null,
    Object? poolAddressTo = null,
    Object? type = null,
  }) {
    return _then(_$_BridgeToken(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BridgeToken implements _BridgeToken {
  const _$_BridgeToken(
      {this.name = '',
      this.tokenAddress = '',
      this.symbol = '',
      this.targetTokenName = '',
      this.targetTokenSymbol = '',
      this.poolAddressFrom = '',
      this.poolAddressTo = '',
      this.type = ''});

  factory _$_BridgeToken.fromJson(Map<String, dynamic> json) =>
      _$$_BridgeTokenFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String tokenAddress;
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
  String toString() {
    return 'BridgeToken(name: $name, tokenAddress: $tokenAddress, symbol: $symbol, targetTokenName: $targetTokenName, targetTokenSymbol: $targetTokenSymbol, poolAddressFrom: $poolAddressFrom, poolAddressTo: $poolAddressTo, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BridgeToken &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.targetTokenName, targetTokenName) ||
                other.targetTokenName == targetTokenName) &&
            (identical(other.targetTokenSymbol, targetTokenSymbol) ||
                other.targetTokenSymbol == targetTokenSymbol) &&
            (identical(other.poolAddressFrom, poolAddressFrom) ||
                other.poolAddressFrom == poolAddressFrom) &&
            (identical(other.poolAddressTo, poolAddressTo) ||
                other.poolAddressTo == poolAddressTo) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, tokenAddress, symbol,
      targetTokenName, targetTokenSymbol, poolAddressFrom, poolAddressTo, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BridgeTokenCopyWith<_$_BridgeToken> get copyWith =>
      __$$_BridgeTokenCopyWithImpl<_$_BridgeToken>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BridgeTokenToJson(
      this,
    );
  }
}

abstract class _BridgeToken implements BridgeToken {
  const factory _BridgeToken(
      {final String name,
      final String tokenAddress,
      final String symbol,
      final String targetTokenName,
      final String targetTokenSymbol,
      final String poolAddressFrom,
      final String poolAddressTo,
      final String type}) = _$_BridgeToken;

  factory _BridgeToken.fromJson(Map<String, dynamic> json) =
      _$_BridgeToken.fromJson;

  @override
  String get name;
  @override
  String get tokenAddress;
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
  @JsonKey(ignore: true)
  _$$_BridgeTokenCopyWith<_$_BridgeToken> get copyWith =>
      throw _privateConstructorUsedError;
}

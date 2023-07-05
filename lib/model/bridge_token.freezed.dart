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

/// @nodoc
mixin _$BridgeToken {
  String get name => throw _privateConstructorUsedError;
  dynamic get tokenAddress => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get targetTokenName => throw _privateConstructorUsedError;
  String get targetTokenSymbol => throw _privateConstructorUsedError;

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
      dynamic tokenAddress,
      String symbol,
      String targetTokenName,
      String targetTokenSymbol});
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
    Object? tokenAddress = freezed,
    Object? symbol = null,
    Object? targetTokenName = null,
    Object? targetTokenSymbol = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress: freezed == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as dynamic,
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
      dynamic tokenAddress,
      String symbol,
      String targetTokenName,
      String targetTokenSymbol});
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
    Object? tokenAddress = freezed,
    Object? symbol = null,
    Object? targetTokenName = null,
    Object? targetTokenSymbol = null,
  }) {
    return _then(_$_BridgeToken(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAddress:
          freezed == tokenAddress ? _value.tokenAddress! : tokenAddress,
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
    ));
  }
}

/// @nodoc

class _$_BridgeToken implements _BridgeToken {
  const _$_BridgeToken(
      {this.name = '',
      this.tokenAddress = '',
      this.symbol = '',
      this.targetTokenName = '',
      this.targetTokenSymbol = ''});

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final dynamic tokenAddress;
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
  String toString() {
    return 'BridgeToken(name: $name, tokenAddress: $tokenAddress, symbol: $symbol, targetTokenName: $targetTokenName, targetTokenSymbol: $targetTokenSymbol)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BridgeToken &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.tokenAddress, tokenAddress) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.targetTokenName, targetTokenName) ||
                other.targetTokenName == targetTokenName) &&
            (identical(other.targetTokenSymbol, targetTokenSymbol) ||
                other.targetTokenSymbol == targetTokenSymbol));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(tokenAddress),
      symbol,
      targetTokenName,
      targetTokenSymbol);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BridgeTokenCopyWith<_$_BridgeToken> get copyWith =>
      __$$_BridgeTokenCopyWithImpl<_$_BridgeToken>(this, _$identity);
}

abstract class _BridgeToken implements BridgeToken {
  const factory _BridgeToken(
      {final String name,
      final dynamic tokenAddress,
      final String symbol,
      final String targetTokenName,
      final String targetTokenSymbol}) = _$_BridgeToken;

  @override
  String get name;
  @override
  dynamic get tokenAddress;
  @override
  String get symbol;
  @override
  String get targetTokenName;
  @override
  String get targetTokenSymbol;
  @override
  @JsonKey(ignore: true)
  _$$_BridgeTokenCopyWith<_$_BridgeToken> get copyWith =>
      throw _privateConstructorUsedError;
}

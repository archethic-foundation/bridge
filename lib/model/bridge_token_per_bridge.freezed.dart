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
  Map<String, List<SymbolData>>? get tokens =>
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
  $Res call({Map<String, List<SymbolData>>? tokens});
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
              as Map<String, List<SymbolData>>?,
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
  $Res call({Map<String, List<SymbolData>>? tokens});
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
              as Map<String, List<SymbolData>>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BridgeTokensPerBridge implements _BridgeTokensPerBridge {
  const _$_BridgeTokensPerBridge({final Map<String, List<SymbolData>>? tokens})
      : _tokens = tokens;

  factory _$_BridgeTokensPerBridge.fromJson(Map<String, dynamic> json) =>
      _$$_BridgeTokensPerBridgeFromJson(json);

  final Map<String, List<SymbolData>>? _tokens;
  @override
  Map<String, List<SymbolData>>? get tokens {
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
      {final Map<String, List<SymbolData>>? tokens}) = _$_BridgeTokensPerBridge;

  factory _BridgeTokensPerBridge.fromJson(Map<String, dynamic> json) =
      _$_BridgeTokensPerBridge.fromJson;

  @override
  Map<String, List<SymbolData>>? get tokens;
  @override
  @JsonKey(ignore: true)
  _$$_BridgeTokensPerBridgeCopyWith<_$_BridgeTokensPerBridge> get copyWith =>
      throw _privateConstructorUsedError;
}

SymbolData _$SymbolDataFromJson(Map<String, dynamic> json) {
  return _SymbolData.fromJson(json);
}

/// @nodoc
mixin _$SymbolData {
  String get symbol => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SymbolDataCopyWith<SymbolData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SymbolDataCopyWith<$Res> {
  factory $SymbolDataCopyWith(
          SymbolData value, $Res Function(SymbolData) then) =
      _$SymbolDataCopyWithImpl<$Res, SymbolData>;
  @useResult
  $Res call({String symbol});
}

/// @nodoc
class _$SymbolDataCopyWithImpl<$Res, $Val extends SymbolData>
    implements $SymbolDataCopyWith<$Res> {
  _$SymbolDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SymbolDataCopyWith<$Res>
    implements $SymbolDataCopyWith<$Res> {
  factory _$$_SymbolDataCopyWith(
          _$_SymbolData value, $Res Function(_$_SymbolData) then) =
      __$$_SymbolDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String symbol});
}

/// @nodoc
class __$$_SymbolDataCopyWithImpl<$Res>
    extends _$SymbolDataCopyWithImpl<$Res, _$_SymbolData>
    implements _$$_SymbolDataCopyWith<$Res> {
  __$$_SymbolDataCopyWithImpl(
      _$_SymbolData _value, $Res Function(_$_SymbolData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
  }) {
    return _then(_$_SymbolData(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SymbolData implements _SymbolData {
  _$_SymbolData({this.symbol = ''});

  factory _$_SymbolData.fromJson(Map<String, dynamic> json) =>
      _$$_SymbolDataFromJson(json);

  @override
  @JsonKey()
  final String symbol;

  @override
  String toString() {
    return 'SymbolData(symbol: $symbol)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SymbolData &&
            (identical(other.symbol, symbol) || other.symbol == symbol));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, symbol);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SymbolDataCopyWith<_$_SymbolData> get copyWith =>
      __$$_SymbolDataCopyWithImpl<_$_SymbolData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SymbolDataToJson(
      this,
    );
  }
}

abstract class _SymbolData implements SymbolData {
  factory _SymbolData({final String symbol}) = _$_SymbolData;

  factory _SymbolData.fromJson(Map<String, dynamic> json) =
      _$_SymbolData.fromJson;

  @override
  String get symbol;
  @override
  @JsonKey(ignore: true)
  _$$_SymbolDataCopyWith<_$_SymbolData> get copyWith =>
      throw _privateConstructorUsedError;
}

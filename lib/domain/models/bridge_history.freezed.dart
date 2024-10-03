// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bridge_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BridgeHistory {
  List<Map<String, dynamic>>? get bridgeList =>
      throw _privateConstructorUsedError;

  /// Create a copy of BridgeHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BridgeHistoryCopyWith<BridgeHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BridgeHistoryCopyWith<$Res> {
  factory $BridgeHistoryCopyWith(
          BridgeHistory value, $Res Function(BridgeHistory) then) =
      _$BridgeHistoryCopyWithImpl<$Res, BridgeHistory>;
  @useResult
  $Res call({List<Map<String, dynamic>>? bridgeList});
}

/// @nodoc
class _$BridgeHistoryCopyWithImpl<$Res, $Val extends BridgeHistory>
    implements $BridgeHistoryCopyWith<$Res> {
  _$BridgeHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BridgeHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bridgeList = freezed,
  }) {
    return _then(_value.copyWith(
      bridgeList: freezed == bridgeList
          ? _value.bridgeList
          : bridgeList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BridgeHistoryImplCopyWith<$Res>
    implements $BridgeHistoryCopyWith<$Res> {
  factory _$$BridgeHistoryImplCopyWith(
          _$BridgeHistoryImpl value, $Res Function(_$BridgeHistoryImpl) then) =
      __$$BridgeHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Map<String, dynamic>>? bridgeList});
}

/// @nodoc
class __$$BridgeHistoryImplCopyWithImpl<$Res>
    extends _$BridgeHistoryCopyWithImpl<$Res, _$BridgeHistoryImpl>
    implements _$$BridgeHistoryImplCopyWith<$Res> {
  __$$BridgeHistoryImplCopyWithImpl(
      _$BridgeHistoryImpl _value, $Res Function(_$BridgeHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of BridgeHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bridgeList = freezed,
  }) {
    return _then(_$BridgeHistoryImpl(
      bridgeList: freezed == bridgeList
          ? _value._bridgeList
          : bridgeList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ));
  }
}

/// @nodoc

class _$BridgeHistoryImpl extends _BridgeHistory {
  const _$BridgeHistoryImpl({final List<Map<String, dynamic>>? bridgeList})
      : _bridgeList = bridgeList,
        super._();

  final List<Map<String, dynamic>>? _bridgeList;
  @override
  List<Map<String, dynamic>>? get bridgeList {
    final value = _bridgeList;
    if (value == null) return null;
    if (_bridgeList is EqualUnmodifiableListView) return _bridgeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BridgeHistory(bridgeList: $bridgeList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BridgeHistoryImpl &&
            const DeepCollectionEquality()
                .equals(other._bridgeList, _bridgeList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_bridgeList));

  /// Create a copy of BridgeHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BridgeHistoryImplCopyWith<_$BridgeHistoryImpl> get copyWith =>
      __$$BridgeHistoryImplCopyWithImpl<_$BridgeHistoryImpl>(this, _$identity);
}

abstract class _BridgeHistory extends BridgeHistory {
  const factory _BridgeHistory({final List<Map<String, dynamic>>? bridgeList}) =
      _$BridgeHistoryImpl;
  const _BridgeHistory._() : super._();

  @override
  List<Map<String, dynamic>>? get bridgeList;

  /// Create a copy of BridgeHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BridgeHistoryImplCopyWith<_$BridgeHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

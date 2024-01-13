// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bridge_history.hive.dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BridgeHistoryHiveDTO {
  @HiveField(0)
  List<Map<String, dynamic>>? get bridgeList =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BridgeHistoryHiveDTOCopyWith<BridgeHistoryHiveDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BridgeHistoryHiveDTOCopyWith<$Res> {
  factory $BridgeHistoryHiveDTOCopyWith(BridgeHistoryHiveDTO value,
          $Res Function(BridgeHistoryHiveDTO) then) =
      _$BridgeHistoryHiveDTOCopyWithImpl<$Res, BridgeHistoryHiveDTO>;
  @useResult
  $Res call({@HiveField(0) List<Map<String, dynamic>>? bridgeList});
}

/// @nodoc
class _$BridgeHistoryHiveDTOCopyWithImpl<$Res,
        $Val extends BridgeHistoryHiveDTO>
    implements $BridgeHistoryHiveDTOCopyWith<$Res> {
  _$BridgeHistoryHiveDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$BridgeHistoryHiveDTOImplCopyWith<$Res>
    implements $BridgeHistoryHiveDTOCopyWith<$Res> {
  factory _$$BridgeHistoryHiveDTOImplCopyWith(_$BridgeHistoryHiveDTOImpl value,
          $Res Function(_$BridgeHistoryHiveDTOImpl) then) =
      __$$BridgeHistoryHiveDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) List<Map<String, dynamic>>? bridgeList});
}

/// @nodoc
class __$$BridgeHistoryHiveDTOImplCopyWithImpl<$Res>
    extends _$BridgeHistoryHiveDTOCopyWithImpl<$Res, _$BridgeHistoryHiveDTOImpl>
    implements _$$BridgeHistoryHiveDTOImplCopyWith<$Res> {
  __$$BridgeHistoryHiveDTOImplCopyWithImpl(_$BridgeHistoryHiveDTOImpl _value,
      $Res Function(_$BridgeHistoryHiveDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bridgeList = freezed,
  }) {
    return _then(_$BridgeHistoryHiveDTOImpl(
      bridgeList: freezed == bridgeList
          ? _value._bridgeList
          : bridgeList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: HiveTypeIds.bridgeHistory)
class _$BridgeHistoryHiveDTOImpl extends _BridgeHistoryHiveDTO {
  const _$BridgeHistoryHiveDTOImpl(
      {@HiveField(0) final List<Map<String, dynamic>>? bridgeList})
      : _bridgeList = bridgeList,
        super._();

  final List<Map<String, dynamic>>? _bridgeList;
  @override
  @HiveField(0)
  List<Map<String, dynamic>>? get bridgeList {
    final value = _bridgeList;
    if (value == null) return null;
    if (_bridgeList is EqualUnmodifiableListView) return _bridgeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BridgeHistoryHiveDTO(bridgeList: $bridgeList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BridgeHistoryHiveDTOImpl &&
            const DeepCollectionEquality()
                .equals(other._bridgeList, _bridgeList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_bridgeList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BridgeHistoryHiveDTOImplCopyWith<_$BridgeHistoryHiveDTOImpl>
      get copyWith =>
          __$$BridgeHistoryHiveDTOImplCopyWithImpl<_$BridgeHistoryHiveDTOImpl>(
              this, _$identity);
}

abstract class _BridgeHistoryHiveDTO extends BridgeHistoryHiveDTO {
  const factory _BridgeHistoryHiveDTO(
          {@HiveField(0) final List<Map<String, dynamic>>? bridgeList}) =
      _$BridgeHistoryHiveDTOImpl;
  const _BridgeHistoryHiveDTO._() : super._();

  @override
  @HiveField(0)
  List<Map<String, dynamic>>? get bridgeList;
  @override
  @JsonKey(ignore: true)
  _$$BridgeHistoryHiveDTOImplCopyWith<_$BridgeHistoryHiveDTOImpl>
      get copyWith => throw _privateConstructorUsedError;
}

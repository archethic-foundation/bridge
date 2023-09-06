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
abstract class _$$_BridgeHistoryHiveDTOCopyWith<$Res>
    implements $BridgeHistoryHiveDTOCopyWith<$Res> {
  factory _$$_BridgeHistoryHiveDTOCopyWith(_$_BridgeHistoryHiveDTO value,
          $Res Function(_$_BridgeHistoryHiveDTO) then) =
      __$$_BridgeHistoryHiveDTOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) List<Map<String, dynamic>>? bridgeList});
}

/// @nodoc
class __$$_BridgeHistoryHiveDTOCopyWithImpl<$Res>
    extends _$BridgeHistoryHiveDTOCopyWithImpl<$Res, _$_BridgeHistoryHiveDTO>
    implements _$$_BridgeHistoryHiveDTOCopyWith<$Res> {
  __$$_BridgeHistoryHiveDTOCopyWithImpl(_$_BridgeHistoryHiveDTO _value,
      $Res Function(_$_BridgeHistoryHiveDTO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bridgeList = freezed,
  }) {
    return _then(_$_BridgeHistoryHiveDTO(
      bridgeList: freezed == bridgeList
          ? _value._bridgeList
          : bridgeList // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: HiveTypeIds.bridgeHistory)
class _$_BridgeHistoryHiveDTO extends _BridgeHistoryHiveDTO {
  const _$_BridgeHistoryHiveDTO(
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BridgeHistoryHiveDTO &&
            const DeepCollectionEquality()
                .equals(other._bridgeList, _bridgeList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_bridgeList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BridgeHistoryHiveDTOCopyWith<_$_BridgeHistoryHiveDTO> get copyWith =>
      __$$_BridgeHistoryHiveDTOCopyWithImpl<_$_BridgeHistoryHiveDTO>(
          this, _$identity);
}

abstract class _BridgeHistoryHiveDTO extends BridgeHistoryHiveDTO {
  const factory _BridgeHistoryHiveDTO(
          {@HiveField(0) final List<Map<String, dynamic>>? bridgeList}) =
      _$_BridgeHistoryHiveDTO;
  const _BridgeHistoryHiveDTO._() : super._();

  @override
  @HiveField(0)
  List<Map<String, dynamic>>? get bridgeList;
  @override
  @JsonKey(ignore: true)
  _$$_BridgeHistoryHiveDTOCopyWith<_$_BridgeHistoryHiveDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

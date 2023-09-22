// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LocalHistoryFormState {
  bool get processCompletedIncluded => throw _privateConstructorUsedError;
  DateTime? get filterPeriodStart => throw _privateConstructorUsedError;
  DateTime? get filterPeriodEnd => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalHistoryFormStateCopyWith<LocalHistoryFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalHistoryFormStateCopyWith<$Res> {
  factory $LocalHistoryFormStateCopyWith(LocalHistoryFormState value,
          $Res Function(LocalHistoryFormState) then) =
      _$LocalHistoryFormStateCopyWithImpl<$Res, LocalHistoryFormState>;
  @useResult
  $Res call(
      {bool processCompletedIncluded,
      DateTime? filterPeriodStart,
      DateTime? filterPeriodEnd});
}

/// @nodoc
class _$LocalHistoryFormStateCopyWithImpl<$Res,
        $Val extends LocalHistoryFormState>
    implements $LocalHistoryFormStateCopyWith<$Res> {
  _$LocalHistoryFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processCompletedIncluded = null,
    Object? filterPeriodStart = freezed,
    Object? filterPeriodEnd = freezed,
  }) {
    return _then(_value.copyWith(
      processCompletedIncluded: null == processCompletedIncluded
          ? _value.processCompletedIncluded
          : processCompletedIncluded // ignore: cast_nullable_to_non_nullable
              as bool,
      filterPeriodStart: freezed == filterPeriodStart
          ? _value.filterPeriodStart
          : filterPeriodStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      filterPeriodEnd: freezed == filterPeriodEnd
          ? _value.filterPeriodEnd
          : filterPeriodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocalHistoryFormStateCopyWith<$Res>
    implements $LocalHistoryFormStateCopyWith<$Res> {
  factory _$$_LocalHistoryFormStateCopyWith(_$_LocalHistoryFormState value,
          $Res Function(_$_LocalHistoryFormState) then) =
      __$$_LocalHistoryFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool processCompletedIncluded,
      DateTime? filterPeriodStart,
      DateTime? filterPeriodEnd});
}

/// @nodoc
class __$$_LocalHistoryFormStateCopyWithImpl<$Res>
    extends _$LocalHistoryFormStateCopyWithImpl<$Res, _$_LocalHistoryFormState>
    implements _$$_LocalHistoryFormStateCopyWith<$Res> {
  __$$_LocalHistoryFormStateCopyWithImpl(_$_LocalHistoryFormState _value,
      $Res Function(_$_LocalHistoryFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processCompletedIncluded = null,
    Object? filterPeriodStart = freezed,
    Object? filterPeriodEnd = freezed,
  }) {
    return _then(_$_LocalHistoryFormState(
      processCompletedIncluded: null == processCompletedIncluded
          ? _value.processCompletedIncluded
          : processCompletedIncluded // ignore: cast_nullable_to_non_nullable
              as bool,
      filterPeriodStart: freezed == filterPeriodStart
          ? _value.filterPeriodStart
          : filterPeriodStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      filterPeriodEnd: freezed == filterPeriodEnd
          ? _value.filterPeriodEnd
          : filterPeriodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_LocalHistoryFormState extends _LocalHistoryFormState {
  const _$_LocalHistoryFormState(
      {this.processCompletedIncluded = false,
      this.filterPeriodStart,
      this.filterPeriodEnd})
      : super._();

  @override
  @JsonKey()
  final bool processCompletedIncluded;
  @override
  final DateTime? filterPeriodStart;
  @override
  final DateTime? filterPeriodEnd;

  @override
  String toString() {
    return 'LocalHistoryFormState(processCompletedIncluded: $processCompletedIncluded, filterPeriodStart: $filterPeriodStart, filterPeriodEnd: $filterPeriodEnd)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalHistoryFormState &&
            (identical(
                    other.processCompletedIncluded, processCompletedIncluded) ||
                other.processCompletedIncluded == processCompletedIncluded) &&
            (identical(other.filterPeriodStart, filterPeriodStart) ||
                other.filterPeriodStart == filterPeriodStart) &&
            (identical(other.filterPeriodEnd, filterPeriodEnd) ||
                other.filterPeriodEnd == filterPeriodEnd));
  }

  @override
  int get hashCode => Object.hash(runtimeType, processCompletedIncluded,
      filterPeriodStart, filterPeriodEnd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocalHistoryFormStateCopyWith<_$_LocalHistoryFormState> get copyWith =>
      __$$_LocalHistoryFormStateCopyWithImpl<_$_LocalHistoryFormState>(
          this, _$identity);
}

abstract class _LocalHistoryFormState extends LocalHistoryFormState {
  const factory _LocalHistoryFormState(
      {final bool processCompletedIncluded,
      final DateTime? filterPeriodStart,
      final DateTime? filterPeriodEnd}) = _$_LocalHistoryFormState;
  const _LocalHistoryFormState._() : super._();

  @override
  bool get processCompletedIncluded;
  @override
  DateTime? get filterPeriodStart;
  @override
  DateTime? get filterPeriodEnd;
  @override
  @JsonKey(ignore: true)
  _$$_LocalHistoryFormStateCopyWith<_$_LocalHistoryFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

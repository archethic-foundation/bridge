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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocalHistoryFormState {
  bool get processCompletedIncluded => throw _privateConstructorUsedError;
  DateTime? get filterPeriodStart => throw _privateConstructorUsedError;
  DateTime? get filterPeriodEnd => throw _privateConstructorUsedError;

  /// Create a copy of LocalHistoryFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of LocalHistoryFormState
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$LocalHistoryFormStateImplCopyWith<$Res>
    implements $LocalHistoryFormStateCopyWith<$Res> {
  factory _$$LocalHistoryFormStateImplCopyWith(
          _$LocalHistoryFormStateImpl value,
          $Res Function(_$LocalHistoryFormStateImpl) then) =
      __$$LocalHistoryFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool processCompletedIncluded,
      DateTime? filterPeriodStart,
      DateTime? filterPeriodEnd});
}

/// @nodoc
class __$$LocalHistoryFormStateImplCopyWithImpl<$Res>
    extends _$LocalHistoryFormStateCopyWithImpl<$Res,
        _$LocalHistoryFormStateImpl>
    implements _$$LocalHistoryFormStateImplCopyWith<$Res> {
  __$$LocalHistoryFormStateImplCopyWithImpl(_$LocalHistoryFormStateImpl _value,
      $Res Function(_$LocalHistoryFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocalHistoryFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processCompletedIncluded = null,
    Object? filterPeriodStart = freezed,
    Object? filterPeriodEnd = freezed,
  }) {
    return _then(_$LocalHistoryFormStateImpl(
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

class _$LocalHistoryFormStateImpl extends _LocalHistoryFormState {
  const _$LocalHistoryFormStateImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalHistoryFormStateImpl &&
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

  /// Create a copy of LocalHistoryFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalHistoryFormStateImplCopyWith<_$LocalHistoryFormStateImpl>
      get copyWith => __$$LocalHistoryFormStateImplCopyWithImpl<
          _$LocalHistoryFormStateImpl>(this, _$identity);
}

abstract class _LocalHistoryFormState extends LocalHistoryFormState {
  const factory _LocalHistoryFormState(
      {final bool processCompletedIncluded,
      final DateTime? filterPeriodStart,
      final DateTime? filterPeriodEnd}) = _$LocalHistoryFormStateImpl;
  const _LocalHistoryFormState._() : super._();

  @override
  bool get processCompletedIncluded;
  @override
  DateTime? get filterPeriodStart;
  @override
  DateTime? get filterPeriodEnd;

  /// Create a copy of LocalHistoryFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalHistoryFormStateImplCopyWith<_$LocalHistoryFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

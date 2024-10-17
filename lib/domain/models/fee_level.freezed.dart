// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fee_level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FeeLevel _$FeeLevelFromJson(Map<String, dynamic> json) {
  return _FeeLevel.fromJson(json);
}

/// @nodoc
mixin _$FeeLevel {
  String get suggestedMaxPriorityFeePerGas =>
      throw _privateConstructorUsedError;
  String get suggestedMaxFeePerGas => throw _privateConstructorUsedError;
  int get minWaitTimeEstimate => throw _privateConstructorUsedError;
  int get maxWaitTimeEstimate => throw _privateConstructorUsedError;

  /// Serializes this FeeLevel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeeLevel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeeLevelCopyWith<FeeLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeeLevelCopyWith<$Res> {
  factory $FeeLevelCopyWith(FeeLevel value, $Res Function(FeeLevel) then) =
      _$FeeLevelCopyWithImpl<$Res, FeeLevel>;
  @useResult
  $Res call(
      {String suggestedMaxPriorityFeePerGas,
      String suggestedMaxFeePerGas,
      int minWaitTimeEstimate,
      int maxWaitTimeEstimate});
}

/// @nodoc
class _$FeeLevelCopyWithImpl<$Res, $Val extends FeeLevel>
    implements $FeeLevelCopyWith<$Res> {
  _$FeeLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeeLevel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestedMaxPriorityFeePerGas = null,
    Object? suggestedMaxFeePerGas = null,
    Object? minWaitTimeEstimate = null,
    Object? maxWaitTimeEstimate = null,
  }) {
    return _then(_value.copyWith(
      suggestedMaxPriorityFeePerGas: null == suggestedMaxPriorityFeePerGas
          ? _value.suggestedMaxPriorityFeePerGas
          : suggestedMaxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedMaxFeePerGas: null == suggestedMaxFeePerGas
          ? _value.suggestedMaxFeePerGas
          : suggestedMaxFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      minWaitTimeEstimate: null == minWaitTimeEstimate
          ? _value.minWaitTimeEstimate
          : minWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
              as int,
      maxWaitTimeEstimate: null == maxWaitTimeEstimate
          ? _value.maxWaitTimeEstimate
          : maxWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeeLevelImplCopyWith<$Res>
    implements $FeeLevelCopyWith<$Res> {
  factory _$$FeeLevelImplCopyWith(
          _$FeeLevelImpl value, $Res Function(_$FeeLevelImpl) then) =
      __$$FeeLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String suggestedMaxPriorityFeePerGas,
      String suggestedMaxFeePerGas,
      int minWaitTimeEstimate,
      int maxWaitTimeEstimate});
}

/// @nodoc
class __$$FeeLevelImplCopyWithImpl<$Res>
    extends _$FeeLevelCopyWithImpl<$Res, _$FeeLevelImpl>
    implements _$$FeeLevelImplCopyWith<$Res> {
  __$$FeeLevelImplCopyWithImpl(
      _$FeeLevelImpl _value, $Res Function(_$FeeLevelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeeLevel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? suggestedMaxPriorityFeePerGas = null,
    Object? suggestedMaxFeePerGas = null,
    Object? minWaitTimeEstimate = null,
    Object? maxWaitTimeEstimate = null,
  }) {
    return _then(_$FeeLevelImpl(
      suggestedMaxPriorityFeePerGas: null == suggestedMaxPriorityFeePerGas
          ? _value.suggestedMaxPriorityFeePerGas
          : suggestedMaxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      suggestedMaxFeePerGas: null == suggestedMaxFeePerGas
          ? _value.suggestedMaxFeePerGas
          : suggestedMaxFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      minWaitTimeEstimate: null == minWaitTimeEstimate
          ? _value.minWaitTimeEstimate
          : minWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
              as int,
      maxWaitTimeEstimate: null == maxWaitTimeEstimate
          ? _value.maxWaitTimeEstimate
          : maxWaitTimeEstimate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeeLevelImpl implements _FeeLevel {
  const _$FeeLevelImpl(
      {required this.suggestedMaxPriorityFeePerGas,
      required this.suggestedMaxFeePerGas,
      required this.minWaitTimeEstimate,
      required this.maxWaitTimeEstimate});

  factory _$FeeLevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeeLevelImplFromJson(json);

  @override
  final String suggestedMaxPriorityFeePerGas;
  @override
  final String suggestedMaxFeePerGas;
  @override
  final int minWaitTimeEstimate;
  @override
  final int maxWaitTimeEstimate;

  @override
  String toString() {
    return 'FeeLevel(suggestedMaxPriorityFeePerGas: $suggestedMaxPriorityFeePerGas, suggestedMaxFeePerGas: $suggestedMaxFeePerGas, minWaitTimeEstimate: $minWaitTimeEstimate, maxWaitTimeEstimate: $maxWaitTimeEstimate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeeLevelImpl &&
            (identical(other.suggestedMaxPriorityFeePerGas,
                    suggestedMaxPriorityFeePerGas) ||
                other.suggestedMaxPriorityFeePerGas ==
                    suggestedMaxPriorityFeePerGas) &&
            (identical(other.suggestedMaxFeePerGas, suggestedMaxFeePerGas) ||
                other.suggestedMaxFeePerGas == suggestedMaxFeePerGas) &&
            (identical(other.minWaitTimeEstimate, minWaitTimeEstimate) ||
                other.minWaitTimeEstimate == minWaitTimeEstimate) &&
            (identical(other.maxWaitTimeEstimate, maxWaitTimeEstimate) ||
                other.maxWaitTimeEstimate == maxWaitTimeEstimate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, suggestedMaxPriorityFeePerGas,
      suggestedMaxFeePerGas, minWaitTimeEstimate, maxWaitTimeEstimate);

  /// Create a copy of FeeLevel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeeLevelImplCopyWith<_$FeeLevelImpl> get copyWith =>
      __$$FeeLevelImplCopyWithImpl<_$FeeLevelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeeLevelImplToJson(
      this,
    );
  }
}

abstract class _FeeLevel implements FeeLevel {
  const factory _FeeLevel(
      {required final String suggestedMaxPriorityFeePerGas,
      required final String suggestedMaxFeePerGas,
      required final int minWaitTimeEstimate,
      required final int maxWaitTimeEstimate}) = _$FeeLevelImpl;

  factory _FeeLevel.fromJson(Map<String, dynamic> json) =
      _$FeeLevelImpl.fromJson;

  @override
  String get suggestedMaxPriorityFeePerGas;
  @override
  String get suggestedMaxFeePerGas;
  @override
  int get minWaitTimeEstimate;
  @override
  int get maxWaitTimeEstimate;

  /// Create a copy of FeeLevel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeeLevelImplCopyWith<_$FeeLevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gas_fee_estimation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GasFeeEstimation _$GasFeeEstimationFromJson(Map<String, dynamic> json) {
  return _GasFeeEstimation.fromJson(json);
}

/// @nodoc
mixin _$GasFeeEstimation {
  DateTime? get timestamp => throw _privateConstructorUsedError;
  @FeeLevelJsonConverter()
  FeeLevel get low => throw _privateConstructorUsedError;
  @FeeLevelJsonConverter()
  FeeLevel get medium => throw _privateConstructorUsedError;
  @FeeLevelJsonConverter()
  FeeLevel get high => throw _privateConstructorUsedError;
  String get estimatedBaseFee => throw _privateConstructorUsedError;
  double get networkCongestion => throw _privateConstructorUsedError;
  List<String> get latestPriorityFeeRange => throw _privateConstructorUsedError;
  List<String> get historicalPriorityFeeRange =>
      throw _privateConstructorUsedError;
  List<String> get historicalBaseFeeRange => throw _privateConstructorUsedError;
  String get priorityFeeTrend => throw _privateConstructorUsedError;
  String get baseFeeTrend => throw _privateConstructorUsedError;

  /// Serializes this GasFeeEstimation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GasFeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GasFeeEstimationCopyWith<GasFeeEstimation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GasFeeEstimationCopyWith<$Res> {
  factory $GasFeeEstimationCopyWith(
          GasFeeEstimation value, $Res Function(GasFeeEstimation) then) =
      _$GasFeeEstimationCopyWithImpl<$Res, GasFeeEstimation>;
  @useResult
  $Res call(
      {DateTime? timestamp,
      @FeeLevelJsonConverter() FeeLevel low,
      @FeeLevelJsonConverter() FeeLevel medium,
      @FeeLevelJsonConverter() FeeLevel high,
      String estimatedBaseFee,
      double networkCongestion,
      List<String> latestPriorityFeeRange,
      List<String> historicalPriorityFeeRange,
      List<String> historicalBaseFeeRange,
      String priorityFeeTrend,
      String baseFeeTrend});

  $FeeLevelCopyWith<$Res> get low;
  $FeeLevelCopyWith<$Res> get medium;
  $FeeLevelCopyWith<$Res> get high;
}

/// @nodoc
class _$GasFeeEstimationCopyWithImpl<$Res, $Val extends GasFeeEstimation>
    implements $GasFeeEstimationCopyWith<$Res> {
  _$GasFeeEstimationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GasFeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = freezed,
    Object? low = null,
    Object? medium = null,
    Object? high = null,
    Object? estimatedBaseFee = null,
    Object? networkCongestion = null,
    Object? latestPriorityFeeRange = null,
    Object? historicalPriorityFeeRange = null,
    Object? historicalBaseFeeRange = null,
    Object? priorityFeeTrend = null,
    Object? baseFeeTrend = null,
  }) {
    return _then(_value.copyWith(
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as FeeLevel,
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as FeeLevel,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as FeeLevel,
      estimatedBaseFee: null == estimatedBaseFee
          ? _value.estimatedBaseFee
          : estimatedBaseFee // ignore: cast_nullable_to_non_nullable
              as String,
      networkCongestion: null == networkCongestion
          ? _value.networkCongestion
          : networkCongestion // ignore: cast_nullable_to_non_nullable
              as double,
      latestPriorityFeeRange: null == latestPriorityFeeRange
          ? _value.latestPriorityFeeRange
          : latestPriorityFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      historicalPriorityFeeRange: null == historicalPriorityFeeRange
          ? _value.historicalPriorityFeeRange
          : historicalPriorityFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      historicalBaseFeeRange: null == historicalBaseFeeRange
          ? _value.historicalBaseFeeRange
          : historicalBaseFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      priorityFeeTrend: null == priorityFeeTrend
          ? _value.priorityFeeTrend
          : priorityFeeTrend // ignore: cast_nullable_to_non_nullable
              as String,
      baseFeeTrend: null == baseFeeTrend
          ? _value.baseFeeTrend
          : baseFeeTrend // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of GasFeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeeLevelCopyWith<$Res> get low {
    return $FeeLevelCopyWith<$Res>(_value.low, (value) {
      return _then(_value.copyWith(low: value) as $Val);
    });
  }

  /// Create a copy of GasFeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeeLevelCopyWith<$Res> get medium {
    return $FeeLevelCopyWith<$Res>(_value.medium, (value) {
      return _then(_value.copyWith(medium: value) as $Val);
    });
  }

  /// Create a copy of GasFeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeeLevelCopyWith<$Res> get high {
    return $FeeLevelCopyWith<$Res>(_value.high, (value) {
      return _then(_value.copyWith(high: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GasFeeEstimationImplCopyWith<$Res>
    implements $GasFeeEstimationCopyWith<$Res> {
  factory _$$GasFeeEstimationImplCopyWith(_$GasFeeEstimationImpl value,
          $Res Function(_$GasFeeEstimationImpl) then) =
      __$$GasFeeEstimationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? timestamp,
      @FeeLevelJsonConverter() FeeLevel low,
      @FeeLevelJsonConverter() FeeLevel medium,
      @FeeLevelJsonConverter() FeeLevel high,
      String estimatedBaseFee,
      double networkCongestion,
      List<String> latestPriorityFeeRange,
      List<String> historicalPriorityFeeRange,
      List<String> historicalBaseFeeRange,
      String priorityFeeTrend,
      String baseFeeTrend});

  @override
  $FeeLevelCopyWith<$Res> get low;
  @override
  $FeeLevelCopyWith<$Res> get medium;
  @override
  $FeeLevelCopyWith<$Res> get high;
}

/// @nodoc
class __$$GasFeeEstimationImplCopyWithImpl<$Res>
    extends _$GasFeeEstimationCopyWithImpl<$Res, _$GasFeeEstimationImpl>
    implements _$$GasFeeEstimationImplCopyWith<$Res> {
  __$$GasFeeEstimationImplCopyWithImpl(_$GasFeeEstimationImpl _value,
      $Res Function(_$GasFeeEstimationImpl) _then)
      : super(_value, _then);

  /// Create a copy of GasFeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = freezed,
    Object? low = null,
    Object? medium = null,
    Object? high = null,
    Object? estimatedBaseFee = null,
    Object? networkCongestion = null,
    Object? latestPriorityFeeRange = null,
    Object? historicalPriorityFeeRange = null,
    Object? historicalBaseFeeRange = null,
    Object? priorityFeeTrend = null,
    Object? baseFeeTrend = null,
  }) {
    return _then(_$GasFeeEstimationImpl(
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      low: null == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as FeeLevel,
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as FeeLevel,
      high: null == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as FeeLevel,
      estimatedBaseFee: null == estimatedBaseFee
          ? _value.estimatedBaseFee
          : estimatedBaseFee // ignore: cast_nullable_to_non_nullable
              as String,
      networkCongestion: null == networkCongestion
          ? _value.networkCongestion
          : networkCongestion // ignore: cast_nullable_to_non_nullable
              as double,
      latestPriorityFeeRange: null == latestPriorityFeeRange
          ? _value._latestPriorityFeeRange
          : latestPriorityFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      historicalPriorityFeeRange: null == historicalPriorityFeeRange
          ? _value._historicalPriorityFeeRange
          : historicalPriorityFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      historicalBaseFeeRange: null == historicalBaseFeeRange
          ? _value._historicalBaseFeeRange
          : historicalBaseFeeRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      priorityFeeTrend: null == priorityFeeTrend
          ? _value.priorityFeeTrend
          : priorityFeeTrend // ignore: cast_nullable_to_non_nullable
              as String,
      baseFeeTrend: null == baseFeeTrend
          ? _value.baseFeeTrend
          : baseFeeTrend // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GasFeeEstimationImpl implements _GasFeeEstimation {
  const _$GasFeeEstimationImpl(
      {this.timestamp,
      @FeeLevelJsonConverter() required this.low,
      @FeeLevelJsonConverter() required this.medium,
      @FeeLevelJsonConverter() required this.high,
      required this.estimatedBaseFee,
      required this.networkCongestion,
      required final List<String> latestPriorityFeeRange,
      required final List<String> historicalPriorityFeeRange,
      required final List<String> historicalBaseFeeRange,
      required this.priorityFeeTrend,
      required this.baseFeeTrend})
      : _latestPriorityFeeRange = latestPriorityFeeRange,
        _historicalPriorityFeeRange = historicalPriorityFeeRange,
        _historicalBaseFeeRange = historicalBaseFeeRange;

  factory _$GasFeeEstimationImpl.fromJson(Map<String, dynamic> json) =>
      _$$GasFeeEstimationImplFromJson(json);

  @override
  final DateTime? timestamp;
  @override
  @FeeLevelJsonConverter()
  final FeeLevel low;
  @override
  @FeeLevelJsonConverter()
  final FeeLevel medium;
  @override
  @FeeLevelJsonConverter()
  final FeeLevel high;
  @override
  final String estimatedBaseFee;
  @override
  final double networkCongestion;
  final List<String> _latestPriorityFeeRange;
  @override
  List<String> get latestPriorityFeeRange {
    if (_latestPriorityFeeRange is EqualUnmodifiableListView)
      return _latestPriorityFeeRange;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_latestPriorityFeeRange);
  }

  final List<String> _historicalPriorityFeeRange;
  @override
  List<String> get historicalPriorityFeeRange {
    if (_historicalPriorityFeeRange is EqualUnmodifiableListView)
      return _historicalPriorityFeeRange;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historicalPriorityFeeRange);
  }

  final List<String> _historicalBaseFeeRange;
  @override
  List<String> get historicalBaseFeeRange {
    if (_historicalBaseFeeRange is EqualUnmodifiableListView)
      return _historicalBaseFeeRange;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historicalBaseFeeRange);
  }

  @override
  final String priorityFeeTrend;
  @override
  final String baseFeeTrend;

  @override
  String toString() {
    return 'GasFeeEstimation(timestamp: $timestamp, low: $low, medium: $medium, high: $high, estimatedBaseFee: $estimatedBaseFee, networkCongestion: $networkCongestion, latestPriorityFeeRange: $latestPriorityFeeRange, historicalPriorityFeeRange: $historicalPriorityFeeRange, historicalBaseFeeRange: $historicalBaseFeeRange, priorityFeeTrend: $priorityFeeTrend, baseFeeTrend: $baseFeeTrend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GasFeeEstimationImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.low, low) || other.low == low) &&
            (identical(other.medium, medium) || other.medium == medium) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.estimatedBaseFee, estimatedBaseFee) ||
                other.estimatedBaseFee == estimatedBaseFee) &&
            (identical(other.networkCongestion, networkCongestion) ||
                other.networkCongestion == networkCongestion) &&
            const DeepCollectionEquality().equals(
                other._latestPriorityFeeRange, _latestPriorityFeeRange) &&
            const DeepCollectionEquality().equals(
                other._historicalPriorityFeeRange,
                _historicalPriorityFeeRange) &&
            const DeepCollectionEquality().equals(
                other._historicalBaseFeeRange, _historicalBaseFeeRange) &&
            (identical(other.priorityFeeTrend, priorityFeeTrend) ||
                other.priorityFeeTrend == priorityFeeTrend) &&
            (identical(other.baseFeeTrend, baseFeeTrend) ||
                other.baseFeeTrend == baseFeeTrend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      timestamp,
      low,
      medium,
      high,
      estimatedBaseFee,
      networkCongestion,
      const DeepCollectionEquality().hash(_latestPriorityFeeRange),
      const DeepCollectionEquality().hash(_historicalPriorityFeeRange),
      const DeepCollectionEquality().hash(_historicalBaseFeeRange),
      priorityFeeTrend,
      baseFeeTrend);

  /// Create a copy of GasFeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GasFeeEstimationImplCopyWith<_$GasFeeEstimationImpl> get copyWith =>
      __$$GasFeeEstimationImplCopyWithImpl<_$GasFeeEstimationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GasFeeEstimationImplToJson(
      this,
    );
  }
}

abstract class _GasFeeEstimation implements GasFeeEstimation {
  const factory _GasFeeEstimation(
      {final DateTime? timestamp,
      @FeeLevelJsonConverter() required final FeeLevel low,
      @FeeLevelJsonConverter() required final FeeLevel medium,
      @FeeLevelJsonConverter() required final FeeLevel high,
      required final String estimatedBaseFee,
      required final double networkCongestion,
      required final List<String> latestPriorityFeeRange,
      required final List<String> historicalPriorityFeeRange,
      required final List<String> historicalBaseFeeRange,
      required final String priorityFeeTrend,
      required final String baseFeeTrend}) = _$GasFeeEstimationImpl;

  factory _GasFeeEstimation.fromJson(Map<String, dynamic> json) =
      _$GasFeeEstimationImpl.fromJson;

  @override
  DateTime? get timestamp;
  @override
  @FeeLevelJsonConverter()
  FeeLevel get low;
  @override
  @FeeLevelJsonConverter()
  FeeLevel get medium;
  @override
  @FeeLevelJsonConverter()
  FeeLevel get high;
  @override
  String get estimatedBaseFee;
  @override
  double get networkCongestion;
  @override
  List<String> get latestPriorityFeeRange;
  @override
  List<String> get historicalPriorityFeeRange;
  @override
  List<String> get historicalBaseFeeRange;
  @override
  String get priorityFeeTrend;
  @override
  String get baseFeeTrend;

  /// Create a copy of GasFeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GasFeeEstimationImplCopyWith<_$GasFeeEstimationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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
mixin _$BlockchainSelectionFormState {
  bool get testnetIncluded => throw _privateConstructorUsedError;

  /// Create a copy of BlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlockchainSelectionFormStateCopyWith<BlockchainSelectionFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockchainSelectionFormStateCopyWith<$Res> {
  factory $BlockchainSelectionFormStateCopyWith(
          BlockchainSelectionFormState value,
          $Res Function(BlockchainSelectionFormState) then) =
      _$BlockchainSelectionFormStateCopyWithImpl<$Res,
          BlockchainSelectionFormState>;
  @useResult
  $Res call({bool testnetIncluded});
}

/// @nodoc
class _$BlockchainSelectionFormStateCopyWithImpl<$Res,
        $Val extends BlockchainSelectionFormState>
    implements $BlockchainSelectionFormStateCopyWith<$Res> {
  _$BlockchainSelectionFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testnetIncluded = null,
  }) {
    return _then(_value.copyWith(
      testnetIncluded: null == testnetIncluded
          ? _value.testnetIncluded
          : testnetIncluded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BlockchainSelectionFormStateImplCopyWith<$Res>
    implements $BlockchainSelectionFormStateCopyWith<$Res> {
  factory _$$BlockchainSelectionFormStateImplCopyWith(
          _$BlockchainSelectionFormStateImpl value,
          $Res Function(_$BlockchainSelectionFormStateImpl) then) =
      __$$BlockchainSelectionFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool testnetIncluded});
}

/// @nodoc
class __$$BlockchainSelectionFormStateImplCopyWithImpl<$Res>
    extends _$BlockchainSelectionFormStateCopyWithImpl<$Res,
        _$BlockchainSelectionFormStateImpl>
    implements _$$BlockchainSelectionFormStateImplCopyWith<$Res> {
  __$$BlockchainSelectionFormStateImplCopyWithImpl(
      _$BlockchainSelectionFormStateImpl _value,
      $Res Function(_$BlockchainSelectionFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testnetIncluded = null,
  }) {
    return _then(_$BlockchainSelectionFormStateImpl(
      testnetIncluded: null == testnetIncluded
          ? _value.testnetIncluded
          : testnetIncluded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BlockchainSelectionFormStateImpl extends _BlockchainSelectionFormState {
  const _$BlockchainSelectionFormStateImpl({this.testnetIncluded = false})
      : super._();

  @override
  @JsonKey()
  final bool testnetIncluded;

  @override
  String toString() {
    return 'BlockchainSelectionFormState(testnetIncluded: $testnetIncluded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockchainSelectionFormStateImpl &&
            (identical(other.testnetIncluded, testnetIncluded) ||
                other.testnetIncluded == testnetIncluded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, testnetIncluded);

  /// Create a copy of BlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockchainSelectionFormStateImplCopyWith<
          _$BlockchainSelectionFormStateImpl>
      get copyWith => __$$BlockchainSelectionFormStateImplCopyWithImpl<
          _$BlockchainSelectionFormStateImpl>(this, _$identity);
}

abstract class _BlockchainSelectionFormState
    extends BlockchainSelectionFormState {
  const factory _BlockchainSelectionFormState({final bool testnetIncluded}) =
      _$BlockchainSelectionFormStateImpl;
  const _BlockchainSelectionFormState._() : super._();

  @override
  bool get testnetIncluded;

  /// Create a copy of BlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlockchainSelectionFormStateImplCopyWith<
          _$BlockchainSelectionFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

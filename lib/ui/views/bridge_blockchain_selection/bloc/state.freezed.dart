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
mixin _$BridgeBlockchainSelectionFormState {
  bool get testnetIncluded => throw _privateConstructorUsedError;

  /// Create a copy of BridgeBlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BridgeBlockchainSelectionFormStateCopyWith<
          BridgeBlockchainSelectionFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BridgeBlockchainSelectionFormStateCopyWith<$Res> {
  factory $BridgeBlockchainSelectionFormStateCopyWith(
          BridgeBlockchainSelectionFormState value,
          $Res Function(BridgeBlockchainSelectionFormState) then) =
      _$BridgeBlockchainSelectionFormStateCopyWithImpl<$Res,
          BridgeBlockchainSelectionFormState>;
  @useResult
  $Res call({bool testnetIncluded});
}

/// @nodoc
class _$BridgeBlockchainSelectionFormStateCopyWithImpl<$Res,
        $Val extends BridgeBlockchainSelectionFormState>
    implements $BridgeBlockchainSelectionFormStateCopyWith<$Res> {
  _$BridgeBlockchainSelectionFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BridgeBlockchainSelectionFormState
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
abstract class _$$BridgeBlockchainSelectionFormStateImplCopyWith<$Res>
    implements $BridgeBlockchainSelectionFormStateCopyWith<$Res> {
  factory _$$BridgeBlockchainSelectionFormStateImplCopyWith(
          _$BridgeBlockchainSelectionFormStateImpl value,
          $Res Function(_$BridgeBlockchainSelectionFormStateImpl) then) =
      __$$BridgeBlockchainSelectionFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool testnetIncluded});
}

/// @nodoc
class __$$BridgeBlockchainSelectionFormStateImplCopyWithImpl<$Res>
    extends _$BridgeBlockchainSelectionFormStateCopyWithImpl<$Res,
        _$BridgeBlockchainSelectionFormStateImpl>
    implements _$$BridgeBlockchainSelectionFormStateImplCopyWith<$Res> {
  __$$BridgeBlockchainSelectionFormStateImplCopyWithImpl(
      _$BridgeBlockchainSelectionFormStateImpl _value,
      $Res Function(_$BridgeBlockchainSelectionFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BridgeBlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testnetIncluded = null,
  }) {
    return _then(_$BridgeBlockchainSelectionFormStateImpl(
      testnetIncluded: null == testnetIncluded
          ? _value.testnetIncluded
          : testnetIncluded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BridgeBlockchainSelectionFormStateImpl
    extends _BridgeBlockchainSelectionFormState {
  const _$BridgeBlockchainSelectionFormStateImpl({this.testnetIncluded = false})
      : super._();

  @override
  @JsonKey()
  final bool testnetIncluded;

  @override
  String toString() {
    return 'BridgeBlockchainSelectionFormState(testnetIncluded: $testnetIncluded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BridgeBlockchainSelectionFormStateImpl &&
            (identical(other.testnetIncluded, testnetIncluded) ||
                other.testnetIncluded == testnetIncluded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, testnetIncluded);

  /// Create a copy of BridgeBlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BridgeBlockchainSelectionFormStateImplCopyWith<
          _$BridgeBlockchainSelectionFormStateImpl>
      get copyWith => __$$BridgeBlockchainSelectionFormStateImplCopyWithImpl<
          _$BridgeBlockchainSelectionFormStateImpl>(this, _$identity);
}

abstract class _BridgeBlockchainSelectionFormState
    extends BridgeBlockchainSelectionFormState {
  const factory _BridgeBlockchainSelectionFormState(
      {final bool testnetIncluded}) = _$BridgeBlockchainSelectionFormStateImpl;
  const _BridgeBlockchainSelectionFormState._() : super._();

  @override
  bool get testnetIncluded;

  /// Create a copy of BridgeBlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BridgeBlockchainSelectionFormStateImplCopyWith<
          _$BridgeBlockchainSelectionFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

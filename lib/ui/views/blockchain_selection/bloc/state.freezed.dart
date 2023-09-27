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
mixin _$BlockchainSelectionFormState {
  bool get testnetIncluded => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
abstract class _$$_BlockchainSelectionFormStateCopyWith<$Res>
    implements $BlockchainSelectionFormStateCopyWith<$Res> {
  factory _$$_BlockchainSelectionFormStateCopyWith(
          _$_BlockchainSelectionFormState value,
          $Res Function(_$_BlockchainSelectionFormState) then) =
      __$$_BlockchainSelectionFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool testnetIncluded});
}

/// @nodoc
class __$$_BlockchainSelectionFormStateCopyWithImpl<$Res>
    extends _$BlockchainSelectionFormStateCopyWithImpl<$Res,
        _$_BlockchainSelectionFormState>
    implements _$$_BlockchainSelectionFormStateCopyWith<$Res> {
  __$$_BlockchainSelectionFormStateCopyWithImpl(
      _$_BlockchainSelectionFormState _value,
      $Res Function(_$_BlockchainSelectionFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testnetIncluded = null,
  }) {
    return _then(_$_BlockchainSelectionFormState(
      testnetIncluded: null == testnetIncluded
          ? _value.testnetIncluded
          : testnetIncluded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_BlockchainSelectionFormState extends _BlockchainSelectionFormState {
  const _$_BlockchainSelectionFormState({this.testnetIncluded = true})
      : super._();

  @override
  @JsonKey()
  final bool testnetIncluded;

  @override
  String toString() {
    return 'BlockchainSelectionFormState(testnetIncluded: $testnetIncluded)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BlockchainSelectionFormState &&
            (identical(other.testnetIncluded, testnetIncluded) ||
                other.testnetIncluded == testnetIncluded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, testnetIncluded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BlockchainSelectionFormStateCopyWith<_$_BlockchainSelectionFormState>
      get copyWith => __$$_BlockchainSelectionFormStateCopyWithImpl<
          _$_BlockchainSelectionFormState>(this, _$identity);
}

abstract class _BlockchainSelectionFormState
    extends BlockchainSelectionFormState {
  const factory _BlockchainSelectionFormState({final bool testnetIncluded}) =
      _$_BlockchainSelectionFormState;
  const _BlockchainSelectionFormState._() : super._();

  @override
  bool get testnetIncluded;
  @override
  @JsonKey(ignore: true)
  _$$_BlockchainSelectionFormStateCopyWith<_$_BlockchainSelectionFormState>
      get copyWith => throw _privateConstructorUsedError;
}

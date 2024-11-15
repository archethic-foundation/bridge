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
mixin _$RefundBlockchainSelectionFormState {
  bool get isTestnetSelected => throw _privateConstructorUsedError;

  /// Create a copy of RefundBlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RefundBlockchainSelectionFormStateCopyWith<
          RefundBlockchainSelectionFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefundBlockchainSelectionFormStateCopyWith<$Res> {
  factory $RefundBlockchainSelectionFormStateCopyWith(
          RefundBlockchainSelectionFormState value,
          $Res Function(RefundBlockchainSelectionFormState) then) =
      _$RefundBlockchainSelectionFormStateCopyWithImpl<$Res,
          RefundBlockchainSelectionFormState>;
  @useResult
  $Res call({bool isTestnetSelected});
}

/// @nodoc
class _$RefundBlockchainSelectionFormStateCopyWithImpl<$Res,
        $Val extends RefundBlockchainSelectionFormState>
    implements $RefundBlockchainSelectionFormStateCopyWith<$Res> {
  _$RefundBlockchainSelectionFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RefundBlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTestnetSelected = null,
  }) {
    return _then(_value.copyWith(
      isTestnetSelected: null == isTestnetSelected
          ? _value.isTestnetSelected
          : isTestnetSelected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RefundBlockchainSelectionFormStateImplCopyWith<$Res>
    implements $RefundBlockchainSelectionFormStateCopyWith<$Res> {
  factory _$$RefundBlockchainSelectionFormStateImplCopyWith(
          _$RefundBlockchainSelectionFormStateImpl value,
          $Res Function(_$RefundBlockchainSelectionFormStateImpl) then) =
      __$$RefundBlockchainSelectionFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isTestnetSelected});
}

/// @nodoc
class __$$RefundBlockchainSelectionFormStateImplCopyWithImpl<$Res>
    extends _$RefundBlockchainSelectionFormStateCopyWithImpl<$Res,
        _$RefundBlockchainSelectionFormStateImpl>
    implements _$$RefundBlockchainSelectionFormStateImplCopyWith<$Res> {
  __$$RefundBlockchainSelectionFormStateImplCopyWithImpl(
      _$RefundBlockchainSelectionFormStateImpl _value,
      $Res Function(_$RefundBlockchainSelectionFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RefundBlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTestnetSelected = null,
  }) {
    return _then(_$RefundBlockchainSelectionFormStateImpl(
      isTestnetSelected: null == isTestnetSelected
          ? _value.isTestnetSelected
          : isTestnetSelected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RefundBlockchainSelectionFormStateImpl
    extends _RefundBlockchainSelectionFormState {
  const _$RefundBlockchainSelectionFormStateImpl(
      {this.isTestnetSelected = false})
      : super._();

  @override
  @JsonKey()
  final bool isTestnetSelected;

  @override
  String toString() {
    return 'RefundBlockchainSelectionFormState(isTestnetSelected: $isTestnetSelected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefundBlockchainSelectionFormStateImpl &&
            (identical(other.isTestnetSelected, isTestnetSelected) ||
                other.isTestnetSelected == isTestnetSelected));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isTestnetSelected);

  /// Create a copy of RefundBlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefundBlockchainSelectionFormStateImplCopyWith<
          _$RefundBlockchainSelectionFormStateImpl>
      get copyWith => __$$RefundBlockchainSelectionFormStateImplCopyWithImpl<
          _$RefundBlockchainSelectionFormStateImpl>(this, _$identity);
}

abstract class _RefundBlockchainSelectionFormState
    extends RefundBlockchainSelectionFormState {
  const factory _RefundBlockchainSelectionFormState(
          {final bool isTestnetSelected}) =
      _$RefundBlockchainSelectionFormStateImpl;
  const _RefundBlockchainSelectionFormState._() : super._();

  @override
  bool get isTestnetSelected;

  /// Create a copy of RefundBlockchainSelectionFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefundBlockchainSelectionFormStateImplCopyWith<
          _$RefundBlockchainSelectionFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

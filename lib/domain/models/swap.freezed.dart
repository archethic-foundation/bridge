// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'swap.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Swap {
  String? get htlcContractAddressEVM => throw _privateConstructorUsedError;
  String? get htlcContractAddressAE => throw _privateConstructorUsedError;
  SwapProcess? get swapProcess => throw _privateConstructorUsedError;

  /// Create a copy of Swap
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SwapCopyWith<Swap> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapCopyWith<$Res> {
  factory $SwapCopyWith(Swap value, $Res Function(Swap) then) =
      _$SwapCopyWithImpl<$Res, Swap>;
  @useResult
  $Res call(
      {String? htlcContractAddressEVM,
      String? htlcContractAddressAE,
      SwapProcess? swapProcess});
}

/// @nodoc
class _$SwapCopyWithImpl<$Res, $Val extends Swap>
    implements $SwapCopyWith<$Res> {
  _$SwapCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Swap
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? htlcContractAddressEVM = freezed,
    Object? htlcContractAddressAE = freezed,
    Object? swapProcess = freezed,
  }) {
    return _then(_value.copyWith(
      htlcContractAddressEVM: freezed == htlcContractAddressEVM
          ? _value.htlcContractAddressEVM
          : htlcContractAddressEVM // ignore: cast_nullable_to_non_nullable
              as String?,
      htlcContractAddressAE: freezed == htlcContractAddressAE
          ? _value.htlcContractAddressAE
          : htlcContractAddressAE // ignore: cast_nullable_to_non_nullable
              as String?,
      swapProcess: freezed == swapProcess
          ? _value.swapProcess
          : swapProcess // ignore: cast_nullable_to_non_nullable
              as SwapProcess?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SwapImplCopyWith<$Res> implements $SwapCopyWith<$Res> {
  factory _$$SwapImplCopyWith(
          _$SwapImpl value, $Res Function(_$SwapImpl) then) =
      __$$SwapImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? htlcContractAddressEVM,
      String? htlcContractAddressAE,
      SwapProcess? swapProcess});
}

/// @nodoc
class __$$SwapImplCopyWithImpl<$Res>
    extends _$SwapCopyWithImpl<$Res, _$SwapImpl>
    implements _$$SwapImplCopyWith<$Res> {
  __$$SwapImplCopyWithImpl(_$SwapImpl _value, $Res Function(_$SwapImpl) _then)
      : super(_value, _then);

  /// Create a copy of Swap
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? htlcContractAddressEVM = freezed,
    Object? htlcContractAddressAE = freezed,
    Object? swapProcess = freezed,
  }) {
    return _then(_$SwapImpl(
      htlcContractAddressEVM: freezed == htlcContractAddressEVM
          ? _value.htlcContractAddressEVM
          : htlcContractAddressEVM // ignore: cast_nullable_to_non_nullable
              as String?,
      htlcContractAddressAE: freezed == htlcContractAddressAE
          ? _value.htlcContractAddressAE
          : htlcContractAddressAE // ignore: cast_nullable_to_non_nullable
              as String?,
      swapProcess: freezed == swapProcess
          ? _value.swapProcess
          : swapProcess // ignore: cast_nullable_to_non_nullable
              as SwapProcess?,
    ));
  }
}

/// @nodoc

class _$SwapImpl extends _Swap {
  const _$SwapImpl(
      {this.htlcContractAddressEVM,
      this.htlcContractAddressAE,
      this.swapProcess})
      : super._();

  @override
  final String? htlcContractAddressEVM;
  @override
  final String? htlcContractAddressAE;
  @override
  final SwapProcess? swapProcess;

  @override
  String toString() {
    return 'Swap(htlcContractAddressEVM: $htlcContractAddressEVM, htlcContractAddressAE: $htlcContractAddressAE, swapProcess: $swapProcess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwapImpl &&
            (identical(other.htlcContractAddressEVM, htlcContractAddressEVM) ||
                other.htlcContractAddressEVM == htlcContractAddressEVM) &&
            (identical(other.htlcContractAddressAE, htlcContractAddressAE) ||
                other.htlcContractAddressAE == htlcContractAddressAE) &&
            (identical(other.swapProcess, swapProcess) ||
                other.swapProcess == swapProcess));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, htlcContractAddressEVM, htlcContractAddressAE, swapProcess);

  /// Create a copy of Swap
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SwapImplCopyWith<_$SwapImpl> get copyWith =>
      __$$SwapImplCopyWithImpl<_$SwapImpl>(this, _$identity);
}

abstract class _Swap extends Swap {
  const factory _Swap(
      {final String? htlcContractAddressEVM,
      final String? htlcContractAddressAE,
      final SwapProcess? swapProcess}) = _$SwapImpl;
  const _Swap._() : super._();

  @override
  String? get htlcContractAddressEVM;
  @override
  String? get htlcContractAddressAE;
  @override
  SwapProcess? get swapProcess;

  /// Create a copy of Swap
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SwapImplCopyWith<_$SwapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

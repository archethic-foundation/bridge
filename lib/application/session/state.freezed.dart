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
mixin _$Session {
  BridgeWallet? get walletFrom => throw _privateConstructorUsedError;
  BridgeWallet? get walletTo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SessionCopyWith<Session> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionCopyWith<$Res> {
  factory $SessionCopyWith(Session value, $Res Function(Session) then) =
      _$SessionCopyWithImpl<$Res, Session>;
  @useResult
  $Res call({BridgeWallet? walletFrom, BridgeWallet? walletTo});

  $BridgeWalletCopyWith<$Res>? get walletFrom;
  $BridgeWalletCopyWith<$Res>? get walletTo;
}

/// @nodoc
class _$SessionCopyWithImpl<$Res, $Val extends Session>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletFrom = freezed,
    Object? walletTo = freezed,
  }) {
    return _then(_value.copyWith(
      walletFrom: freezed == walletFrom
          ? _value.walletFrom
          : walletFrom // ignore: cast_nullable_to_non_nullable
              as BridgeWallet?,
      walletTo: freezed == walletTo
          ? _value.walletTo
          : walletTo // ignore: cast_nullable_to_non_nullable
              as BridgeWallet?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BridgeWalletCopyWith<$Res>? get walletFrom {
    if (_value.walletFrom == null) {
      return null;
    }

    return $BridgeWalletCopyWith<$Res>(_value.walletFrom!, (value) {
      return _then(_value.copyWith(walletFrom: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BridgeWalletCopyWith<$Res>? get walletTo {
    if (_value.walletTo == null) {
      return null;
    }

    return $BridgeWalletCopyWith<$Res>(_value.walletTo!, (value) {
      return _then(_value.copyWith(walletTo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionImplCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$$SessionImplCopyWith(
          _$SessionImpl value, $Res Function(_$SessionImpl) then) =
      __$$SessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BridgeWallet? walletFrom, BridgeWallet? walletTo});

  @override
  $BridgeWalletCopyWith<$Res>? get walletFrom;
  @override
  $BridgeWalletCopyWith<$Res>? get walletTo;
}

/// @nodoc
class __$$SessionImplCopyWithImpl<$Res>
    extends _$SessionCopyWithImpl<$Res, _$SessionImpl>
    implements _$$SessionImplCopyWith<$Res> {
  __$$SessionImplCopyWithImpl(
      _$SessionImpl _value, $Res Function(_$SessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletFrom = freezed,
    Object? walletTo = freezed,
  }) {
    return _then(_$SessionImpl(
      walletFrom: freezed == walletFrom
          ? _value.walletFrom
          : walletFrom // ignore: cast_nullable_to_non_nullable
              as BridgeWallet?,
      walletTo: freezed == walletTo
          ? _value.walletTo
          : walletTo // ignore: cast_nullable_to_non_nullable
              as BridgeWallet?,
    ));
  }
}

/// @nodoc

class _$SessionImpl extends _Session {
  const _$SessionImpl({this.walletFrom, this.walletTo}) : super._();

  @override
  final BridgeWallet? walletFrom;
  @override
  final BridgeWallet? walletTo;

  @override
  String toString() {
    return 'Session(walletFrom: $walletFrom, walletTo: $walletTo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionImpl &&
            (identical(other.walletFrom, walletFrom) ||
                other.walletFrom == walletFrom) &&
            (identical(other.walletTo, walletTo) ||
                other.walletTo == walletTo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, walletFrom, walletTo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      __$$SessionImplCopyWithImpl<_$SessionImpl>(this, _$identity);
}

abstract class _Session extends Session {
  const factory _Session(
      {final BridgeWallet? walletFrom,
      final BridgeWallet? walletTo}) = _$SessionImpl;
  const _Session._() : super._();

  @override
  BridgeWallet? get walletFrom;
  @override
  BridgeWallet? get walletTo;
  @override
  @JsonKey(ignore: true)
  _$$SessionImplCopyWith<_$SessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

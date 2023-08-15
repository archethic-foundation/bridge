// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bridge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Bridge {
  @HiveField(0)
  int? get blockchainChainIdFrom => throw _privateConstructorUsedError;
  @HiveField(1)
  int? get blockchainChainIdTo => throw _privateConstructorUsedError;
  @HiveField(2)
  BridgeToken? get tokenToBridge => throw _privateConstructorUsedError;
  @HiveField(3)
  double? get tokenToBridgeAmount => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get targetAddress => throw _privateConstructorUsedError;
  @HiveField(5)
  int? get timestampExec => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BridgeCopyWith<Bridge> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BridgeCopyWith<$Res> {
  factory $BridgeCopyWith(Bridge value, $Res Function(Bridge) then) =
      _$BridgeCopyWithImpl<$Res, Bridge>;
  @useResult
  $Res call(
      {@HiveField(0) int? blockchainChainIdFrom,
      @HiveField(1) int? blockchainChainIdTo,
      @HiveField(2) BridgeToken? tokenToBridge,
      @HiveField(3) double? tokenToBridgeAmount,
      @HiveField(4) String? targetAddress,
      @HiveField(5) int? timestampExec});

  $BridgeTokenCopyWith<$Res>? get tokenToBridge;
}

/// @nodoc
class _$BridgeCopyWithImpl<$Res, $Val extends Bridge>
    implements $BridgeCopyWith<$Res> {
  _$BridgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blockchainChainIdFrom = freezed,
    Object? blockchainChainIdTo = freezed,
    Object? tokenToBridge = freezed,
    Object? tokenToBridgeAmount = freezed,
    Object? targetAddress = freezed,
    Object? timestampExec = freezed,
  }) {
    return _then(_value.copyWith(
      blockchainChainIdFrom: freezed == blockchainChainIdFrom
          ? _value.blockchainChainIdFrom
          : blockchainChainIdFrom // ignore: cast_nullable_to_non_nullable
              as int?,
      blockchainChainIdTo: freezed == blockchainChainIdTo
          ? _value.blockchainChainIdTo
          : blockchainChainIdTo // ignore: cast_nullable_to_non_nullable
              as int?,
      tokenToBridge: freezed == tokenToBridge
          ? _value.tokenToBridge
          : tokenToBridge // ignore: cast_nullable_to_non_nullable
              as BridgeToken?,
      tokenToBridgeAmount: freezed == tokenToBridgeAmount
          ? _value.tokenToBridgeAmount
          : tokenToBridgeAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      targetAddress: freezed == targetAddress
          ? _value.targetAddress
          : targetAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      timestampExec: freezed == timestampExec
          ? _value.timestampExec
          : timestampExec // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BridgeTokenCopyWith<$Res>? get tokenToBridge {
    if (_value.tokenToBridge == null) {
      return null;
    }

    return $BridgeTokenCopyWith<$Res>(_value.tokenToBridge!, (value) {
      return _then(_value.copyWith(tokenToBridge: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BridgeCopyWith<$Res> implements $BridgeCopyWith<$Res> {
  factory _$$_BridgeCopyWith(_$_Bridge value, $Res Function(_$_Bridge) then) =
      __$$_BridgeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int? blockchainChainIdFrom,
      @HiveField(1) int? blockchainChainIdTo,
      @HiveField(2) BridgeToken? tokenToBridge,
      @HiveField(3) double? tokenToBridgeAmount,
      @HiveField(4) String? targetAddress,
      @HiveField(5) int? timestampExec});

  @override
  $BridgeTokenCopyWith<$Res>? get tokenToBridge;
}

/// @nodoc
class __$$_BridgeCopyWithImpl<$Res>
    extends _$BridgeCopyWithImpl<$Res, _$_Bridge>
    implements _$$_BridgeCopyWith<$Res> {
  __$$_BridgeCopyWithImpl(_$_Bridge _value, $Res Function(_$_Bridge) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blockchainChainIdFrom = freezed,
    Object? blockchainChainIdTo = freezed,
    Object? tokenToBridge = freezed,
    Object? tokenToBridgeAmount = freezed,
    Object? targetAddress = freezed,
    Object? timestampExec = freezed,
  }) {
    return _then(_$_Bridge(
      blockchainChainIdFrom: freezed == blockchainChainIdFrom
          ? _value.blockchainChainIdFrom
          : blockchainChainIdFrom // ignore: cast_nullable_to_non_nullable
              as int?,
      blockchainChainIdTo: freezed == blockchainChainIdTo
          ? _value.blockchainChainIdTo
          : blockchainChainIdTo // ignore: cast_nullable_to_non_nullable
              as int?,
      tokenToBridge: freezed == tokenToBridge
          ? _value.tokenToBridge
          : tokenToBridge // ignore: cast_nullable_to_non_nullable
              as BridgeToken?,
      tokenToBridgeAmount: freezed == tokenToBridgeAmount
          ? _value.tokenToBridgeAmount
          : tokenToBridgeAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      targetAddress: freezed == targetAddress
          ? _value.targetAddress
          : targetAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      timestampExec: freezed == timestampExec
          ? _value.timestampExec
          : timestampExec // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: HiveTypeIds.bridge)
class _$_Bridge extends _Bridge {
  const _$_Bridge(
      {@HiveField(0) this.blockchainChainIdFrom,
      @HiveField(1) this.blockchainChainIdTo,
      @HiveField(2) this.tokenToBridge,
      @HiveField(3) this.tokenToBridgeAmount,
      @HiveField(4) this.targetAddress,
      @HiveField(5) this.timestampExec})
      : super._();

  @override
  @HiveField(0)
  final int? blockchainChainIdFrom;
  @override
  @HiveField(1)
  final int? blockchainChainIdTo;
  @override
  @HiveField(2)
  final BridgeToken? tokenToBridge;
  @override
  @HiveField(3)
  final double? tokenToBridgeAmount;
  @override
  @HiveField(4)
  final String? targetAddress;
  @override
  @HiveField(5)
  final int? timestampExec;

  @override
  String toString() {
    return 'Bridge(blockchainChainIdFrom: $blockchainChainIdFrom, blockchainChainIdTo: $blockchainChainIdTo, tokenToBridge: $tokenToBridge, tokenToBridgeAmount: $tokenToBridgeAmount, targetAddress: $targetAddress, timestampExec: $timestampExec)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bridge &&
            (identical(other.blockchainChainIdFrom, blockchainChainIdFrom) ||
                other.blockchainChainIdFrom == blockchainChainIdFrom) &&
            (identical(other.blockchainChainIdTo, blockchainChainIdTo) ||
                other.blockchainChainIdTo == blockchainChainIdTo) &&
            (identical(other.tokenToBridge, tokenToBridge) ||
                other.tokenToBridge == tokenToBridge) &&
            (identical(other.tokenToBridgeAmount, tokenToBridgeAmount) ||
                other.tokenToBridgeAmount == tokenToBridgeAmount) &&
            (identical(other.targetAddress, targetAddress) ||
                other.targetAddress == targetAddress) &&
            (identical(other.timestampExec, timestampExec) ||
                other.timestampExec == timestampExec));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      blockchainChainIdFrom,
      blockchainChainIdTo,
      tokenToBridge,
      tokenToBridgeAmount,
      targetAddress,
      timestampExec);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BridgeCopyWith<_$_Bridge> get copyWith =>
      __$$_BridgeCopyWithImpl<_$_Bridge>(this, _$identity);
}

abstract class _Bridge extends Bridge {
  const factory _Bridge(
      {@HiveField(0) final int? blockchainChainIdFrom,
      @HiveField(1) final int? blockchainChainIdTo,
      @HiveField(2) final BridgeToken? tokenToBridge,
      @HiveField(3) final double? tokenToBridgeAmount,
      @HiveField(4) final String? targetAddress,
      @HiveField(5) final int? timestampExec}) = _$_Bridge;
  const _Bridge._() : super._();

  @override
  @HiveField(0)
  int? get blockchainChainIdFrom;
  @override
  @HiveField(1)
  int? get blockchainChainIdTo;
  @override
  @HiveField(2)
  BridgeToken? get tokenToBridge;
  @override
  @HiveField(3)
  double? get tokenToBridgeAmount;
  @override
  @HiveField(4)
  String? get targetAddress;
  @override
  @HiveField(5)
  int? get timestampExec;
  @override
  @JsonKey(ignore: true)
  _$$_BridgeCopyWith<_$_Bridge> get copyWith =>
      throw _privateConstructorUsedError;
}

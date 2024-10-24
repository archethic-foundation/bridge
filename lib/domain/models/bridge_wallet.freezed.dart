// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bridge_wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BridgeWallet {
  String get wallet => throw _privateConstructorUsedError;
  String get endpoint => throw _privateConstructorUsedError;
  String get nameAccount => throw _privateConstructorUsedError;
  String get oldNameAccount => throw _privateConstructorUsedError;
  String get genesisAddress => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  BridgeBlockchainEnvironment? get env => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  Subscription<Account>? get accountSub => throw _privateConstructorUsedError;
  StreamSubscription<Account>? get accountStreamSub =>
      throw _privateConstructorUsedError;

  /// Create a copy of BridgeWallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BridgeWalletCopyWith<BridgeWallet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BridgeWalletCopyWith<$Res> {
  factory $BridgeWalletCopyWith(
          BridgeWallet value, $Res Function(BridgeWallet) then) =
      _$BridgeWalletCopyWithImpl<$Res, BridgeWallet>;
  @useResult
  $Res call(
      {String wallet,
      String endpoint,
      String nameAccount,
      String oldNameAccount,
      String genesisAddress,
      String error,
      BridgeBlockchainEnvironment? env,
      bool isConnected,
      Subscription<Account>? accountSub,
      StreamSubscription<Account>? accountStreamSub});

  $SubscriptionCopyWith<Account, $Res>? get accountSub;
}

/// @nodoc
class _$BridgeWalletCopyWithImpl<$Res, $Val extends BridgeWallet>
    implements $BridgeWalletCopyWith<$Res> {
  _$BridgeWalletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BridgeWallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallet = null,
    Object? endpoint = null,
    Object? nameAccount = null,
    Object? oldNameAccount = null,
    Object? genesisAddress = null,
    Object? error = null,
    Object? env = freezed,
    Object? isConnected = null,
    Object? accountSub = freezed,
    Object? accountStreamSub = freezed,
  }) {
    return _then(_value.copyWith(
      wallet: null == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
      nameAccount: null == nameAccount
          ? _value.nameAccount
          : nameAccount // ignore: cast_nullable_to_non_nullable
              as String,
      oldNameAccount: null == oldNameAccount
          ? _value.oldNameAccount
          : oldNameAccount // ignore: cast_nullable_to_non_nullable
              as String,
      genesisAddress: null == genesisAddress
          ? _value.genesisAddress
          : genesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      env: freezed == env
          ? _value.env
          : env // ignore: cast_nullable_to_non_nullable
              as BridgeBlockchainEnvironment?,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      accountSub: freezed == accountSub
          ? _value.accountSub
          : accountSub // ignore: cast_nullable_to_non_nullable
              as Subscription<Account>?,
      accountStreamSub: freezed == accountStreamSub
          ? _value.accountStreamSub
          : accountStreamSub // ignore: cast_nullable_to_non_nullable
              as StreamSubscription<Account>?,
    ) as $Val);
  }

  /// Create a copy of BridgeWallet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubscriptionCopyWith<Account, $Res>? get accountSub {
    if (_value.accountSub == null) {
      return null;
    }

    return $SubscriptionCopyWith<Account, $Res>(_value.accountSub!, (value) {
      return _then(_value.copyWith(accountSub: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BridgeWalletImplCopyWith<$Res>
    implements $BridgeWalletCopyWith<$Res> {
  factory _$$BridgeWalletImplCopyWith(
          _$BridgeWalletImpl value, $Res Function(_$BridgeWalletImpl) then) =
      __$$BridgeWalletImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String wallet,
      String endpoint,
      String nameAccount,
      String oldNameAccount,
      String genesisAddress,
      String error,
      BridgeBlockchainEnvironment? env,
      bool isConnected,
      Subscription<Account>? accountSub,
      StreamSubscription<Account>? accountStreamSub});

  @override
  $SubscriptionCopyWith<Account, $Res>? get accountSub;
}

/// @nodoc
class __$$BridgeWalletImplCopyWithImpl<$Res>
    extends _$BridgeWalletCopyWithImpl<$Res, _$BridgeWalletImpl>
    implements _$$BridgeWalletImplCopyWith<$Res> {
  __$$BridgeWalletImplCopyWithImpl(
      _$BridgeWalletImpl _value, $Res Function(_$BridgeWalletImpl) _then)
      : super(_value, _then);

  /// Create a copy of BridgeWallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wallet = null,
    Object? endpoint = null,
    Object? nameAccount = null,
    Object? oldNameAccount = null,
    Object? genesisAddress = null,
    Object? error = null,
    Object? env = freezed,
    Object? isConnected = null,
    Object? accountSub = freezed,
    Object? accountStreamSub = freezed,
  }) {
    return _then(_$BridgeWalletImpl(
      wallet: null == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
      nameAccount: null == nameAccount
          ? _value.nameAccount
          : nameAccount // ignore: cast_nullable_to_non_nullable
              as String,
      oldNameAccount: null == oldNameAccount
          ? _value.oldNameAccount
          : oldNameAccount // ignore: cast_nullable_to_non_nullable
              as String,
      genesisAddress: null == genesisAddress
          ? _value.genesisAddress
          : genesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      env: freezed == env
          ? _value.env
          : env // ignore: cast_nullable_to_non_nullable
              as BridgeBlockchainEnvironment?,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      accountSub: freezed == accountSub
          ? _value.accountSub
          : accountSub // ignore: cast_nullable_to_non_nullable
              as Subscription<Account>?,
      accountStreamSub: freezed == accountStreamSub
          ? _value.accountStreamSub
          : accountStreamSub // ignore: cast_nullable_to_non_nullable
              as StreamSubscription<Account>?,
    ));
  }
}

/// @nodoc

class _$BridgeWalletImpl extends _BridgeWallet {
  const _$BridgeWalletImpl(
      {this.wallet = '',
      this.endpoint = '',
      this.nameAccount = '',
      this.oldNameAccount = '',
      this.genesisAddress = '',
      this.error = '',
      this.env,
      this.isConnected = false,
      this.accountSub,
      this.accountStreamSub})
      : super._();

  @override
  @JsonKey()
  final String wallet;
  @override
  @JsonKey()
  final String endpoint;
  @override
  @JsonKey()
  final String nameAccount;
  @override
  @JsonKey()
  final String oldNameAccount;
  @override
  @JsonKey()
  final String genesisAddress;
  @override
  @JsonKey()
  final String error;
  @override
  final BridgeBlockchainEnvironment? env;
  @override
  @JsonKey()
  final bool isConnected;
  @override
  final Subscription<Account>? accountSub;
  @override
  final StreamSubscription<Account>? accountStreamSub;

  @override
  String toString() {
    return 'BridgeWallet(wallet: $wallet, endpoint: $endpoint, nameAccount: $nameAccount, oldNameAccount: $oldNameAccount, genesisAddress: $genesisAddress, error: $error, env: $env, isConnected: $isConnected, accountSub: $accountSub, accountStreamSub: $accountStreamSub)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BridgeWalletImpl &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint) &&
            (identical(other.nameAccount, nameAccount) ||
                other.nameAccount == nameAccount) &&
            (identical(other.oldNameAccount, oldNameAccount) ||
                other.oldNameAccount == oldNameAccount) &&
            (identical(other.genesisAddress, genesisAddress) ||
                other.genesisAddress == genesisAddress) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.env, env) || other.env == env) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.accountSub, accountSub) ||
                other.accountSub == accountSub) &&
            (identical(other.accountStreamSub, accountStreamSub) ||
                other.accountStreamSub == accountStreamSub));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      wallet,
      endpoint,
      nameAccount,
      oldNameAccount,
      genesisAddress,
      error,
      env,
      isConnected,
      accountSub,
      accountStreamSub);

  /// Create a copy of BridgeWallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BridgeWalletImplCopyWith<_$BridgeWalletImpl> get copyWith =>
      __$$BridgeWalletImplCopyWithImpl<_$BridgeWalletImpl>(this, _$identity);
}

abstract class _BridgeWallet extends BridgeWallet {
  const factory _BridgeWallet(
          {final String wallet,
          final String endpoint,
          final String nameAccount,
          final String oldNameAccount,
          final String genesisAddress,
          final String error,
          final BridgeBlockchainEnvironment? env,
          final bool isConnected,
          final Subscription<Account>? accountSub,
          final StreamSubscription<Account>? accountStreamSub}) =
      _$BridgeWalletImpl;
  const _BridgeWallet._() : super._();

  @override
  String get wallet;
  @override
  String get endpoint;
  @override
  String get nameAccount;
  @override
  String get oldNameAccount;
  @override
  String get genesisAddress;
  @override
  String get error;
  @override
  BridgeBlockchainEnvironment? get env;
  @override
  bool get isConnected;
  @override
  Subscription<Account>? get accountSub;
  @override
  StreamSubscription<Account>? get accountStreamSub;

  /// Create a copy of BridgeWallet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BridgeWalletImplCopyWith<_$BridgeWalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

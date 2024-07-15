// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$balanceRepositoryHash() => r'694ad0789c371d8ff21073c2834711009024d9ae';

/// See also [_balanceRepository].
@ProviderFor(_balanceRepository)
final _balanceRepositoryProvider =
    AutoDisposeProvider<BalanceRepository>.internal(
  _balanceRepository,
  name: r'_balanceRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$balanceRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _BalanceRepositoryRef = AutoDisposeProviderRef<BalanceRepository>;
<<<<<<< HEAD
String _$getBalanceHash() => r'd29a315387d3a35a18d20e40ab033af777e8fcd1';
=======
String _$getBalanceHash() => r'c63e51ea9d4b5ed206ffcd4bcc1a96a62e2bbb9d';
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [_getBalance].
@ProviderFor(_getBalance)
const _getBalanceProvider = _GetBalanceFamily();

/// See also [_getBalance].
class _GetBalanceFamily extends Family<AsyncValue<double>> {
  /// See also [_getBalance].
  const _GetBalanceFamily();

  /// See also [_getBalance].
  _GetBalanceProvider call(
    bool isArchethic,
    String address,
    String typeToken,
    String tokenAddress,
<<<<<<< HEAD
    int decimal, {
=======
    ApiService? apiService,
    EVMWalletProvider? evmWalletProvider, {
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
    String? providerEndpoint,
  }) {
    return _GetBalanceProvider(
      isArchethic,
      address,
      typeToken,
      tokenAddress,
<<<<<<< HEAD
      decimal,
=======
      apiService,
      evmWalletProvider,
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
      providerEndpoint: providerEndpoint,
    );
  }

  @override
  _GetBalanceProvider getProviderOverride(
    covariant _GetBalanceProvider provider,
  ) {
    return call(
      provider.isArchethic,
      provider.address,
      provider.typeToken,
      provider.tokenAddress,
<<<<<<< HEAD
      provider.decimal,
=======
      provider.apiService,
      provider.evmWalletProvider,
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
      providerEndpoint: provider.providerEndpoint,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_getBalanceProvider';
}

/// See also [_getBalance].
class _GetBalanceProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_getBalance].
  _GetBalanceProvider(
    bool isArchethic,
    String address,
    String typeToken,
    String tokenAddress,
<<<<<<< HEAD
    int decimal, {
=======
    ApiService? apiService,
    EVMWalletProvider? evmWalletProvider, {
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
    String? providerEndpoint,
  }) : this._internal(
          (ref) => _getBalance(
            ref as _GetBalanceRef,
            isArchethic,
            address,
            typeToken,
            tokenAddress,
<<<<<<< HEAD
            decimal,
=======
            apiService,
            evmWalletProvider,
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
            providerEndpoint: providerEndpoint,
          ),
          from: _getBalanceProvider,
          name: r'_getBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBalanceHash,
          dependencies: _GetBalanceFamily._dependencies,
          allTransitiveDependencies:
              _GetBalanceFamily._allTransitiveDependencies,
          isArchethic: isArchethic,
          address: address,
          typeToken: typeToken,
          tokenAddress: tokenAddress,
<<<<<<< HEAD
          decimal: decimal,
=======
          apiService: apiService,
          evmWalletProvider: evmWalletProvider,
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
          providerEndpoint: providerEndpoint,
        );

  _GetBalanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.isArchethic,
    required this.address,
    required this.typeToken,
    required this.tokenAddress,
<<<<<<< HEAD
    required this.decimal,
=======
    required this.apiService,
    required this.evmWalletProvider,
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
    required this.providerEndpoint,
  }) : super.internal();

  final bool isArchethic;
  final String address;
  final String typeToken;
  final String tokenAddress;
<<<<<<< HEAD
  final int decimal;
=======
  final ApiService? apiService;
  final EVMWalletProvider? evmWalletProvider;
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
  final String? providerEndpoint;

  @override
  Override overrideWith(
    FutureOr<double> Function(_GetBalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetBalanceProvider._internal(
        (ref) => create(ref as _GetBalanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        isArchethic: isArchethic,
        address: address,
        typeToken: typeToken,
        tokenAddress: tokenAddress,
<<<<<<< HEAD
        decimal: decimal,
=======
        apiService: apiService,
        evmWalletProvider: evmWalletProvider,
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
        providerEndpoint: providerEndpoint,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _GetBalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetBalanceProvider &&
        other.isArchethic == isArchethic &&
        other.address == address &&
        other.typeToken == typeToken &&
        other.tokenAddress == tokenAddress &&
<<<<<<< HEAD
        other.decimal == decimal &&
=======
        other.apiService == apiService &&
        other.evmWalletProvider == evmWalletProvider &&
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
        other.providerEndpoint == providerEndpoint;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isArchethic.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, typeToken.hashCode);
    hash = _SystemHash.combine(hash, tokenAddress.hashCode);
<<<<<<< HEAD
    hash = _SystemHash.combine(hash, decimal.hashCode);
=======
    hash = _SystemHash.combine(hash, apiService.hashCode);
    hash = _SystemHash.combine(hash, evmWalletProvider.hashCode);
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
    hash = _SystemHash.combine(hash, providerEndpoint.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetBalanceRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `isArchethic` of this provider.
  bool get isArchethic;

  /// The parameter `address` of this provider.
  String get address;

  /// The parameter `typeToken` of this provider.
  String get typeToken;

  /// The parameter `tokenAddress` of this provider.
  String get tokenAddress;

<<<<<<< HEAD
  /// The parameter `decimal` of this provider.
  int get decimal;
=======
  /// The parameter `apiService` of this provider.
  ApiService? get apiService;

  /// The parameter `evmWalletProvider` of this provider.
  EVMWalletProvider? get evmWalletProvider;
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)

  /// The parameter `providerEndpoint` of this provider.
  String? get providerEndpoint;
}

class _GetBalanceProviderElement
    extends AutoDisposeFutureProviderElement<double> with _GetBalanceRef {
  _GetBalanceProviderElement(super.provider);

  @override
  bool get isArchethic => (origin as _GetBalanceProvider).isArchethic;
  @override
  String get address => (origin as _GetBalanceProvider).address;
  @override
  String get typeToken => (origin as _GetBalanceProvider).typeToken;
  @override
  String get tokenAddress => (origin as _GetBalanceProvider).tokenAddress;
  @override
<<<<<<< HEAD
  int get decimal => (origin as _GetBalanceProvider).decimal;
=======
  ApiService? get apiService => (origin as _GetBalanceProvider).apiService;
  @override
  EVMWalletProvider? get evmWalletProvider =>
      (origin as _GetBalanceProvider).evmWalletProvider;
>>>>>>> 5fde8f3 (feat: :sparkles: Replace local history with on chain history)
  @override
  String? get providerEndpoint =>
      (origin as _GetBalanceProvider).providerEndpoint;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

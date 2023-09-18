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
String _$getBalanceHash() => r'eff86b6c2ef83cb454ccd915e2f5c0b24ba26888';

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
    String tokenAddress, {
    String? providerEndpoint,
  }) {
    return _GetBalanceProvider(
      isArchethic,
      address,
      typeToken,
      tokenAddress,
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
    String tokenAddress, {
    String? providerEndpoint,
  }) : this._internal(
          (ref) => _getBalance(
            ref as _GetBalanceRef,
            isArchethic,
            address,
            typeToken,
            tokenAddress,
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
    required this.providerEndpoint,
  }) : super.internal();

  final bool isArchethic;
  final String address;
  final String typeToken;
  final String tokenAddress;
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
        other.providerEndpoint == providerEndpoint;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isArchethic.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, typeToken.hashCode);
    hash = _SystemHash.combine(hash, tokenAddress.hashCode);
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
  String? get providerEndpoint =>
      (origin as _GetBalanceProvider).providerEndpoint;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

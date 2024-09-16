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
String _$getBalanceHash() => r'0e8f5905f8b488dcbbb5127c8c24c978b6fba657';

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

/// See also [getBalance].
@ProviderFor(getBalance)
const getBalanceProvider = GetBalanceFamily();

/// See also [getBalance].
class GetBalanceFamily extends Family<AsyncValue<double>> {
  /// See also [getBalance].
  const GetBalanceFamily();

  /// See also [getBalance].
  GetBalanceProvider call(
    bool isArchethic,
    String address,
    String typeToken,
    String tokenAddress,
    int decimal, {
    String? providerEndpoint,
  }) {
    return GetBalanceProvider(
      isArchethic,
      address,
      typeToken,
      tokenAddress,
      decimal,
      providerEndpoint: providerEndpoint,
    );
  }

  @override
  GetBalanceProvider getProviderOverride(
    covariant GetBalanceProvider provider,
  ) {
    return call(
      provider.isArchethic,
      provider.address,
      provider.typeToken,
      provider.tokenAddress,
      provider.decimal,
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
  String? get name => r'getBalanceProvider';
}

/// See also [getBalance].
class GetBalanceProvider extends AutoDisposeFutureProvider<double> {
  /// See also [getBalance].
  GetBalanceProvider(
    bool isArchethic,
    String address,
    String typeToken,
    String tokenAddress,
    int decimal, {
    String? providerEndpoint,
  }) : this._internal(
          (ref) => getBalance(
            ref as GetBalanceRef,
            isArchethic,
            address,
            typeToken,
            tokenAddress,
            decimal,
            providerEndpoint: providerEndpoint,
          ),
          from: getBalanceProvider,
          name: r'getBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBalanceHash,
          dependencies: GetBalanceFamily._dependencies,
          allTransitiveDependencies:
              GetBalanceFamily._allTransitiveDependencies,
          isArchethic: isArchethic,
          address: address,
          typeToken: typeToken,
          tokenAddress: tokenAddress,
          decimal: decimal,
          providerEndpoint: providerEndpoint,
        );

  GetBalanceProvider._internal(
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
    required this.decimal,
    required this.providerEndpoint,
  }) : super.internal();

  final bool isArchethic;
  final String address;
  final String typeToken;
  final String tokenAddress;
  final int decimal;
  final String? providerEndpoint;

  @override
  Override overrideWith(
    FutureOr<double> Function(GetBalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetBalanceProvider._internal(
        (ref) => create(ref as GetBalanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        isArchethic: isArchethic,
        address: address,
        typeToken: typeToken,
        tokenAddress: tokenAddress,
        decimal: decimal,
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
    return other is GetBalanceProvider &&
        other.isArchethic == isArchethic &&
        other.address == address &&
        other.typeToken == typeToken &&
        other.tokenAddress == tokenAddress &&
        other.decimal == decimal &&
        other.providerEndpoint == providerEndpoint;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isArchethic.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, typeToken.hashCode);
    hash = _SystemHash.combine(hash, tokenAddress.hashCode);
    hash = _SystemHash.combine(hash, decimal.hashCode);
    hash = _SystemHash.combine(hash, providerEndpoint.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetBalanceRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `isArchethic` of this provider.
  bool get isArchethic;

  /// The parameter `address` of this provider.
  String get address;

  /// The parameter `typeToken` of this provider.
  String get typeToken;

  /// The parameter `tokenAddress` of this provider.
  String get tokenAddress;

  /// The parameter `decimal` of this provider.
  int get decimal;

  /// The parameter `providerEndpoint` of this provider.
  String? get providerEndpoint;
}

class _GetBalanceProviderElement
    extends AutoDisposeFutureProviderElement<double> with GetBalanceRef {
  _GetBalanceProviderElement(super.provider);

  @override
  bool get isArchethic => (origin as GetBalanceProvider).isArchethic;
  @override
  String get address => (origin as GetBalanceProvider).address;
  @override
  String get typeToken => (origin as GetBalanceProvider).typeToken;
  @override
  String get tokenAddress => (origin as GetBalanceProvider).tokenAddress;
  @override
  int get decimal => (origin as GetBalanceProvider).decimal;
  @override
  String? get providerEndpoint =>
      (origin as GetBalanceProvider).providerEndpoint;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

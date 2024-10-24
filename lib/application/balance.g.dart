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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef _BalanceRepositoryRef = AutoDisposeProviderRef<BalanceRepository>;
String _$getBalanceHash() => r'785f94ec308e0c4993e3fe6155995497aff527f6';

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
    int decimal,
  ) {
    return GetBalanceProvider(
      isArchethic,
      address,
      typeToken,
      tokenAddress,
      decimal,
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
    int decimal,
  ) : this._internal(
          (ref) => getBalance(
            ref as GetBalanceRef,
            isArchethic,
            address,
            typeToken,
            tokenAddress,
            decimal,
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
  }) : super.internal();

  final bool isArchethic;
  final String address;
  final String typeToken;
  final String tokenAddress;
  final int decimal;

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
        other.decimal == decimal;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isArchethic.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, typeToken.hashCode);
    hash = _SystemHash.combine(hash, tokenAddress.hashCode);
    hash = _SystemHash.combine(hash, decimal.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
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
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_blockchain.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bridgeBlockchainsRepositoryHash() =>
    r'7f7628c08ea93ed5d9c4ecff168191945cd7e726';

/// See also [bridgeBlockchainsRepository].
@ProviderFor(bridgeBlockchainsRepository)
final bridgeBlockchainsRepositoryProvider =
    Provider<BridgeBlockchainsRepository>.internal(
  bridgeBlockchainsRepository,
  name: r'bridgeBlockchainsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bridgeBlockchainsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BridgeBlockchainsRepositoryRef
    = ProviderRef<BridgeBlockchainsRepository>;
String _$getBlockchainsListHash() =>
    r'bcd386d39798e44315f7ca212817c3728ceacf1b';

/// See also [getBlockchainsList].
@ProviderFor(getBlockchainsList)
final getBlockchainsListProvider =
    AutoDisposeFutureProvider<List<BridgeBlockchain>>.internal(
  getBlockchainsList,
  name: r'getBlockchainsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getBlockchainsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetBlockchainsListRef
    = AutoDisposeFutureProviderRef<List<BridgeBlockchain>>;
String _$getBlockchainFromChainIdHash() =>
    r'818d954db8310c7b92281559ecf0beb1d6eaad1d';

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

/// See also [getBlockchainFromChainId].
@ProviderFor(getBlockchainFromChainId)
const getBlockchainFromChainIdProvider = GetBlockchainFromChainIdFamily();

/// See also [getBlockchainFromChainId].
class GetBlockchainFromChainIdFamily
    extends Family<AsyncValue<BridgeBlockchain?>> {
  /// See also [getBlockchainFromChainId].
  const GetBlockchainFromChainIdFamily();

  /// See also [getBlockchainFromChainId].
  GetBlockchainFromChainIdProvider call(
    int chainId,
  ) {
    return GetBlockchainFromChainIdProvider(
      chainId,
    );
  }

  @override
  GetBlockchainFromChainIdProvider getProviderOverride(
    covariant GetBlockchainFromChainIdProvider provider,
  ) {
    return call(
      provider.chainId,
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
  String? get name => r'getBlockchainFromChainIdProvider';
}

/// See also [getBlockchainFromChainId].
class GetBlockchainFromChainIdProvider
    extends AutoDisposeFutureProvider<BridgeBlockchain?> {
  /// See also [getBlockchainFromChainId].
  GetBlockchainFromChainIdProvider(
    int chainId,
  ) : this._internal(
          (ref) => getBlockchainFromChainId(
            ref as GetBlockchainFromChainIdRef,
            chainId,
          ),
          from: getBlockchainFromChainIdProvider,
          name: r'getBlockchainFromChainIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBlockchainFromChainIdHash,
          dependencies: GetBlockchainFromChainIdFamily._dependencies,
          allTransitiveDependencies:
              GetBlockchainFromChainIdFamily._allTransitiveDependencies,
          chainId: chainId,
        );

  GetBlockchainFromChainIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chainId,
  }) : super.internal();

  final int chainId;

  @override
  Override overrideWith(
    FutureOr<BridgeBlockchain?> Function(GetBlockchainFromChainIdRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetBlockchainFromChainIdProvider._internal(
        (ref) => create(ref as GetBlockchainFromChainIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chainId: chainId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BridgeBlockchain?> createElement() {
    return _GetBlockchainFromChainIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetBlockchainFromChainIdProvider &&
        other.chainId == chainId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chainId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetBlockchainFromChainIdRef
    on AutoDisposeFutureProviderRef<BridgeBlockchain?> {
  /// The parameter `chainId` of this provider.
  int get chainId;
}

class _GetBlockchainFromChainIdProviderElement
    extends AutoDisposeFutureProviderElement<BridgeBlockchain?>
    with GetBlockchainFromChainIdRef {
  _GetBlockchainFromChainIdProviderElement(super.provider);

  @override
  int get chainId => (origin as GetBlockchainFromChainIdProvider).chainId;
}

String _$getArchethicBlockchainFromEVMHash() =>
    r'0523c5842f197504b9591ebcebcd610557f5c075';

/// See also [getArchethicBlockchainFromEVM].
@ProviderFor(getArchethicBlockchainFromEVM)
const getArchethicBlockchainFromEVMProvider =
    GetArchethicBlockchainFromEVMFamily();

/// See also [getArchethicBlockchainFromEVM].
class GetArchethicBlockchainFromEVMFamily
    extends Family<AsyncValue<BridgeBlockchain?>> {
  /// See also [getArchethicBlockchainFromEVM].
  const GetArchethicBlockchainFromEVMFamily();

  /// See also [getArchethicBlockchainFromEVM].
  GetArchethicBlockchainFromEVMProvider call(
    BridgeBlockchain? evmBlockchain,
  ) {
    return GetArchethicBlockchainFromEVMProvider(
      evmBlockchain,
    );
  }

  @override
  GetArchethicBlockchainFromEVMProvider getProviderOverride(
    covariant GetArchethicBlockchainFromEVMProvider provider,
  ) {
    return call(
      provider.evmBlockchain,
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
  String? get name => r'getArchethicBlockchainFromEVMProvider';
}

/// See also [getArchethicBlockchainFromEVM].
class GetArchethicBlockchainFromEVMProvider
    extends AutoDisposeFutureProvider<BridgeBlockchain?> {
  /// See also [getArchethicBlockchainFromEVM].
  GetArchethicBlockchainFromEVMProvider(
    BridgeBlockchain? evmBlockchain,
  ) : this._internal(
          (ref) => getArchethicBlockchainFromEVM(
            ref as GetArchethicBlockchainFromEVMRef,
            evmBlockchain,
          ),
          from: getArchethicBlockchainFromEVMProvider,
          name: r'getArchethicBlockchainFromEVMProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getArchethicBlockchainFromEVMHash,
          dependencies: GetArchethicBlockchainFromEVMFamily._dependencies,
          allTransitiveDependencies:
              GetArchethicBlockchainFromEVMFamily._allTransitiveDependencies,
          evmBlockchain: evmBlockchain,
        );

  GetArchethicBlockchainFromEVMProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.evmBlockchain,
  }) : super.internal();

  final BridgeBlockchain? evmBlockchain;

  @override
  Override overrideWith(
    FutureOr<BridgeBlockchain?> Function(
            GetArchethicBlockchainFromEVMRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetArchethicBlockchainFromEVMProvider._internal(
        (ref) => create(ref as GetArchethicBlockchainFromEVMRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        evmBlockchain: evmBlockchain,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BridgeBlockchain?> createElement() {
    return _GetArchethicBlockchainFromEVMProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetArchethicBlockchainFromEVMProvider &&
        other.evmBlockchain == evmBlockchain;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, evmBlockchain.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetArchethicBlockchainFromEVMRef
    on AutoDisposeFutureProviderRef<BridgeBlockchain?> {
  /// The parameter `evmBlockchain` of this provider.
  BridgeBlockchain? get evmBlockchain;
}

class _GetArchethicBlockchainFromEVMProviderElement
    extends AutoDisposeFutureProviderElement<BridgeBlockchain?>
    with GetArchethicBlockchainFromEVMRef {
  _GetArchethicBlockchainFromEVMProviderElement(super.provider);

  @override
  BridgeBlockchain? get evmBlockchain =>
      (origin as GetArchethicBlockchainFromEVMProvider).evmBlockchain;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

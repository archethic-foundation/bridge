// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_blockchain.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getBlockchainsListConfHash() =>
    r'5943f901b8dd8fc5620733d52ea679ffd74c0fd5';

/// See also [_getBlockchainsListConf].
@ProviderFor(_getBlockchainsListConf)
final _getBlockchainsListConfProvider =
    AutoDisposeFutureProvider<List<BridgeBlockchain>>.internal(
  _getBlockchainsListConf,
  name: r'_getBlockchainsListConfProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getBlockchainsListConfHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetBlockchainsListConfRef
    = AutoDisposeFutureProviderRef<List<BridgeBlockchain>>;
String _$bridgeBlockchainsRepositoryHash() =>
    r'67771710151e43e7b614a1b9226730df6d753f17';

/// See also [_bridgeBlockchainsRepository].
@ProviderFor(_bridgeBlockchainsRepository)
final _bridgeBlockchainsRepositoryProvider =
    AutoDisposeProvider<BridgeBlockchainsRepository>.internal(
  _bridgeBlockchainsRepository,
  name: r'_bridgeBlockchainsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bridgeBlockchainsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _BridgeBlockchainsRepositoryRef
    = AutoDisposeProviderRef<BridgeBlockchainsRepository>;
String _$getBlockchainsListHash() =>
    r'cea64575c4ae064d7b8bfd45b3a5fe33cd2b47a8';

/// See also [_getBlockchainsList].
@ProviderFor(_getBlockchainsList)
final _getBlockchainsListProvider =
    AutoDisposeFutureProvider<List<BridgeBlockchain>>.internal(
  _getBlockchainsList,
  name: r'_getBlockchainsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getBlockchainsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetBlockchainsListRef
    = AutoDisposeFutureProviderRef<List<BridgeBlockchain>>;
String _$getBlockchainFromChainIdHash() =>
    r'08fc37cea8574434054a2fc60238cb69d5802948';

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

typedef _GetBlockchainFromChainIdRef
    = AutoDisposeFutureProviderRef<BridgeBlockchain?>;

/// See also [_getBlockchainFromChainId].
@ProviderFor(_getBlockchainFromChainId)
const _getBlockchainFromChainIdProvider = _GetBlockchainFromChainIdFamily();

/// See also [_getBlockchainFromChainId].
class _GetBlockchainFromChainIdFamily
    extends Family<AsyncValue<BridgeBlockchain?>> {
  /// See also [_getBlockchainFromChainId].
  const _GetBlockchainFromChainIdFamily();

  /// See also [_getBlockchainFromChainId].
  _GetBlockchainFromChainIdProvider call(
    int chainId,
  ) {
    return _GetBlockchainFromChainIdProvider(
      chainId,
    );
  }

  @override
  _GetBlockchainFromChainIdProvider getProviderOverride(
    covariant _GetBlockchainFromChainIdProvider provider,
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
  String? get name => r'_getBlockchainFromChainIdProvider';
}

/// See also [_getBlockchainFromChainId].
class _GetBlockchainFromChainIdProvider
    extends AutoDisposeFutureProvider<BridgeBlockchain?> {
  /// See also [_getBlockchainFromChainId].
  _GetBlockchainFromChainIdProvider(
    this.chainId,
  ) : super.internal(
          (ref) => _getBlockchainFromChainId(
            ref,
            chainId,
          ),
          from: _getBlockchainFromChainIdProvider,
          name: r'_getBlockchainFromChainIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getBlockchainFromChainIdHash,
          dependencies: _GetBlockchainFromChainIdFamily._dependencies,
          allTransitiveDependencies:
              _GetBlockchainFromChainIdFamily._allTransitiveDependencies,
        );

  final int chainId;

  @override
  bool operator ==(Object other) {
    return other is _GetBlockchainFromChainIdProvider &&
        other.chainId == chainId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chainId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getArchethicBlockchainFromEVMHash() =>
    r'16c5426f497b35f222744e0c0c13cd8f94757b82';
typedef _GetArchethicBlockchainFromEVMRef
    = AutoDisposeFutureProviderRef<BridgeBlockchain?>;

/// See also [_getArchethicBlockchainFromEVM].
@ProviderFor(_getArchethicBlockchainFromEVM)
const _getArchethicBlockchainFromEVMProvider =
    _GetArchethicBlockchainFromEVMFamily();

/// See also [_getArchethicBlockchainFromEVM].
class _GetArchethicBlockchainFromEVMFamily
    extends Family<AsyncValue<BridgeBlockchain?>> {
  /// See also [_getArchethicBlockchainFromEVM].
  const _GetArchethicBlockchainFromEVMFamily();

  /// See also [_getArchethicBlockchainFromEVM].
  _GetArchethicBlockchainFromEVMProvider call(
    BridgeBlockchain? evmBlockchain,
  ) {
    return _GetArchethicBlockchainFromEVMProvider(
      evmBlockchain,
    );
  }

  @override
  _GetArchethicBlockchainFromEVMProvider getProviderOverride(
    covariant _GetArchethicBlockchainFromEVMProvider provider,
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
  String? get name => r'_getArchethicBlockchainFromEVMProvider';
}

/// See also [_getArchethicBlockchainFromEVM].
class _GetArchethicBlockchainFromEVMProvider
    extends AutoDisposeFutureProvider<BridgeBlockchain?> {
  /// See also [_getArchethicBlockchainFromEVM].
  _GetArchethicBlockchainFromEVMProvider(
    this.evmBlockchain,
  ) : super.internal(
          (ref) => _getArchethicBlockchainFromEVM(
            ref,
            evmBlockchain,
          ),
          from: _getArchethicBlockchainFromEVMProvider,
          name: r'_getArchethicBlockchainFromEVMProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getArchethicBlockchainFromEVMHash,
          dependencies: _GetArchethicBlockchainFromEVMFamily._dependencies,
          allTransitiveDependencies:
              _GetArchethicBlockchainFromEVMFamily._allTransitiveDependencies,
        );

  final BridgeBlockchain? evmBlockchain;

  @override
  bool operator ==(Object other) {
    return other is _GetArchethicBlockchainFromEVMProvider &&
        other.evmBlockchain == evmBlockchain;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, evmBlockchain.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member

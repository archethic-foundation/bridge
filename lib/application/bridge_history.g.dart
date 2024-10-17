// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_history.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bridgeHistoryRepositoryHash() =>
    r'9996e3267164e0d5706cb9c6694a6a307168a6ec';

/// See also [bridgeHistoryRepository].
@ProviderFor(bridgeHistoryRepository)
final bridgeHistoryRepositoryProvider =
    AutoDisposeProvider<BridgeHistoryRepository>.internal(
  bridgeHistoryRepository,
  name: r'bridgeHistoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bridgeHistoryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BridgeHistoryRepositoryRef
    = AutoDisposeProviderRef<BridgeHistoryRepository>;
String _$fetchBridgeHistoryHash() =>
    r'd1dfc789e96d141e821134e64a47bea86617d23a';

/// See also [fetchBridgeHistory].
@ProviderFor(fetchBridgeHistory)
final fetchBridgeHistoryProvider =
    AutoDisposeFutureProvider<BridgeHistory?>.internal(
  fetchBridgeHistory,
  name: r'fetchBridgeHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchBridgeHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchBridgeHistoryRef = AutoDisposeFutureProviderRef<BridgeHistory?>;
String _$fetchBridgesListHash() => r'113903bc26a81de3b99e55ef4f5f3b7bb518f93f';

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

/// See also [fetchBridgesList].
@ProviderFor(fetchBridgesList)
const fetchBridgesListProvider = FetchBridgesListFamily();

/// See also [fetchBridgesList].
class FetchBridgesListFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [fetchBridgesList].
  const FetchBridgesListFamily();

  /// See also [fetchBridgesList].
  FetchBridgesListProvider call({
    bool asc = true,
  }) {
    return FetchBridgesListProvider(
      asc: asc,
    );
  }

  @override
  FetchBridgesListProvider getProviderOverride(
    covariant FetchBridgesListProvider provider,
  ) {
    return call(
      asc: provider.asc,
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
  String? get name => r'fetchBridgesListProvider';
}

/// See also [fetchBridgesList].
class FetchBridgesListProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [fetchBridgesList].
  FetchBridgesListProvider({
    bool asc = true,
  }) : this._internal(
          (ref) => fetchBridgesList(
            ref as FetchBridgesListRef,
            asc: asc,
          ),
          from: fetchBridgesListProvider,
          name: r'fetchBridgesListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchBridgesListHash,
          dependencies: FetchBridgesListFamily._dependencies,
          allTransitiveDependencies:
              FetchBridgesListFamily._allTransitiveDependencies,
          asc: asc,
        );

  FetchBridgesListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.asc,
  }) : super.internal();

  final bool asc;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(FetchBridgesListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchBridgesListProvider._internal(
        (ref) => create(ref as FetchBridgesListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        asc: asc,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _FetchBridgesListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchBridgesListProvider && other.asc == asc;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, asc.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchBridgesListRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `asc` of this provider.
  bool get asc;
}

class _FetchBridgesListProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with FetchBridgesListRef {
  _FetchBridgesListProviderElement(super.provider);

  @override
  bool get asc => (origin as FetchBridgesListProvider).asc;
}

String _$clearBridgesListHash() => r'17e04982f8498973f73f9767b827da86e6e11fee';

/// See also [clearBridgesList].
@ProviderFor(clearBridgesList)
final clearBridgesListProvider = AutoDisposeFutureProvider<void>.internal(
  clearBridgesList,
  name: r'clearBridgesListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clearBridgesListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ClearBridgesListRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

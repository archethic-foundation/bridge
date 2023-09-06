// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_history.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bridgeHistoryRepositoryHash() =>
    r'd7580b6d32e4bdc92352952502c944e6188da53b';

/// See also [_bridgeHistoryRepository].
@ProviderFor(_bridgeHistoryRepository)
final _bridgeHistoryRepositoryProvider =
    AutoDisposeProvider<BridgeHistoryRepository>.internal(
  _bridgeHistoryRepository,
  name: r'_bridgeHistoryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bridgeHistoryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _BridgeHistoryRepositoryRef
    = AutoDisposeProviderRef<BridgeHistoryRepository>;
String _$fetchBridgeHistoryHash() =>
    r'57610cc346f1f2bb1446603181f3767dcb9a8388';

/// See also [_fetchBridgeHistory].
@ProviderFor(_fetchBridgeHistory)
final _fetchBridgeHistoryProvider =
    AutoDisposeFutureProvider<BridgeHistory?>.internal(
  _fetchBridgeHistory,
  name: r'_fetchBridgeHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchBridgeHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _FetchBridgeHistoryRef = AutoDisposeFutureProviderRef<BridgeHistory?>;
String _$fetchBridgesListHash() => r'4eb43c97f3fde4f4fba38c6bf4e3cb0f07d1ed05';

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

/// See also [_fetchBridgesList].
@ProviderFor(_fetchBridgesList)
const _fetchBridgesListProvider = _FetchBridgesListFamily();

/// See also [_fetchBridgesList].
class _FetchBridgesListFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [_fetchBridgesList].
  const _FetchBridgesListFamily();

  /// See also [_fetchBridgesList].
  _FetchBridgesListProvider call({
    bool asc = true,
  }) {
    return _FetchBridgesListProvider(
      asc: asc,
    );
  }

  @override
  _FetchBridgesListProvider getProviderOverride(
    covariant _FetchBridgesListProvider provider,
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
  String? get name => r'_fetchBridgesListProvider';
}

/// See also [_fetchBridgesList].
class _FetchBridgesListProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [_fetchBridgesList].
  _FetchBridgesListProvider({
    bool asc = true,
  }) : this._internal(
          (ref) => _fetchBridgesList(
            ref as _FetchBridgesListRef,
            asc: asc,
          ),
          from: _fetchBridgesListProvider,
          name: r'_fetchBridgesListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchBridgesListHash,
          dependencies: _FetchBridgesListFamily._dependencies,
          allTransitiveDependencies:
              _FetchBridgesListFamily._allTransitiveDependencies,
          asc: asc,
        );

  _FetchBridgesListProvider._internal(
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
    FutureOr<List<Map<String, dynamic>>> Function(_FetchBridgesListRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _FetchBridgesListProvider._internal(
        (ref) => create(ref as _FetchBridgesListRef),
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
    return other is _FetchBridgesListProvider && other.asc == asc;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, asc.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _FetchBridgesListRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `asc` of this provider.
  bool get asc;
}

class _FetchBridgesListProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with _FetchBridgesListRef {
  _FetchBridgesListProviderElement(super.provider);

  @override
  bool get asc => (origin as _FetchBridgesListProvider).asc;
}

String _$clearBridgesListHash() => r'781a7283eb1f4ecfb88491460e5aace9fc66ecee';

/// See also [_clearBridgesList].
@ProviderFor(_clearBridgesList)
final _clearBridgesListProvider = AutoDisposeFutureProvider<void>.internal(
  _clearBridgesList,
  name: r'_clearBridgesListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clearBridgesListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _ClearBridgesListRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

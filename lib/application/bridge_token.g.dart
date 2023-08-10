// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_token.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bridgeTokensRepositoryHash() =>
    r'12ebc18829ad73ffa1c0bfcbc09a9d49eb219bed';

/// See also [_bridgeTokensRepository].
@ProviderFor(_bridgeTokensRepository)
final _bridgeTokensRepositoryProvider =
    AutoDisposeProvider<BridgeTokensRepository>.internal(
  _bridgeTokensRepository,
  name: r'_bridgeTokensRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bridgeTokensRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _BridgeTokensRepositoryRef
    = AutoDisposeProviderRef<BridgeTokensRepository>;
String _$getTokensListPerBridgeHash() =>
    r'918b6b0c84ea079954c007ccf241c6526808a29e';

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

typedef _GetTokensListPerBridgeRef
    = AutoDisposeFutureProviderRef<List<BridgeToken>>;

/// See also [_getTokensListPerBridge].
@ProviderFor(_getTokensListPerBridge)
const _getTokensListPerBridgeProvider = _GetTokensListPerBridgeFamily();

/// See also [_getTokensListPerBridge].
class _GetTokensListPerBridgeFamily
    extends Family<AsyncValue<List<BridgeToken>>> {
  /// See also [_getTokensListPerBridge].
  const _GetTokensListPerBridgeFamily();

  /// See also [_getTokensListPerBridge].
  _GetTokensListPerBridgeProvider call(
    String direction,
  ) {
    return _GetTokensListPerBridgeProvider(
      direction,
    );
  }

  @override
  _GetTokensListPerBridgeProvider getProviderOverride(
    covariant _GetTokensListPerBridgeProvider provider,
  ) {
    return call(
      provider.direction,
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
  String? get name => r'_getTokensListPerBridgeProvider';
}

/// See also [_getTokensListPerBridge].
class _GetTokensListPerBridgeProvider
    extends AutoDisposeFutureProvider<List<BridgeToken>> {
  /// See also [_getTokensListPerBridge].
  _GetTokensListPerBridgeProvider(
    this.direction,
  ) : super.internal(
          (ref) => _getTokensListPerBridge(
            ref,
            direction,
          ),
          from: _getTokensListPerBridgeProvider,
          name: r'_getTokensListPerBridgeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTokensListPerBridgeHash,
          dependencies: _GetTokensListPerBridgeFamily._dependencies,
          allTransitiveDependencies:
              _GetTokensListPerBridgeFamily._allTransitiveDependencies,
        );

  final String direction;

  @override
  bool operator ==(Object other) {
    return other is _GetTokensListPerBridgeProvider &&
        other.direction == direction;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, direction.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member

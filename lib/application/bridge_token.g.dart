// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_token.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bridgeTokensRepositoryHash() =>
    r'4ff92ad5bf46367fef4e336f50ce63d97cbb3c72';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef _BridgeTokensRepositoryRef
    = AutoDisposeProviderRef<BridgeTokensRepository>;
String _$getTokensListPerBridgeHash() =>
    r'ba18f310d01fa8fc739d476d1b2a2f0a18daf9bf';

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
    String direction,
  ) : this._internal(
          (ref) => _getTokensListPerBridge(
            ref as _GetTokensListPerBridgeRef,
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
          direction: direction,
        );

  _GetTokensListPerBridgeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.direction,
  }) : super.internal();

  final String direction;

  @override
  Override overrideWith(
    FutureOr<List<BridgeToken>> Function(_GetTokensListPerBridgeRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetTokensListPerBridgeProvider._internal(
        (ref) => create(ref as _GetTokensListPerBridgeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        direction: direction,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<BridgeToken>> createElement() {
    return _GetTokensListPerBridgeProviderElement(this);
  }

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin _GetTokensListPerBridgeRef
    on AutoDisposeFutureProviderRef<List<BridgeToken>> {
  /// The parameter `direction` of this provider.
  String get direction;
}

class _GetTokensListPerBridgeProviderElement
    extends AutoDisposeFutureProviderElement<List<BridgeToken>>
    with _GetTokensListPerBridgeRef {
  _GetTokensListPerBridgeProviderElement(super.provider);

  @override
  String get direction => (origin as _GetTokensListPerBridgeProvider).direction;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

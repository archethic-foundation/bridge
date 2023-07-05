// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_token.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String $_bridgeTokensRepositoryHash() =>
    r'12ebc18829ad73ffa1c0bfcbc09a9d49eb219bed';

/// See also [_bridgeTokensRepository].
final _bridgeTokensRepositoryProvider =
    AutoDisposeProvider<BridgeTokensRepository>(
  _bridgeTokensRepository,
  name: r'_bridgeTokensRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_bridgeTokensRepositoryHash,
);
typedef _BridgeTokensRepositoryRef
    = AutoDisposeProviderRef<BridgeTokensRepository>;
String $_getTokensListHash() => r'cd2f3ef071ba7abc34228aa001fc217ce2f2a99a';

/// See also [_getTokensList].
final _getTokensListProvider = AutoDisposeFutureProvider<List<BridgeToken>>(
  _getTokensList,
  name: r'_getTokensListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_getTokensListHash,
);
typedef _GetTokensListRef = AutoDisposeFutureProviderRef<List<BridgeToken>>;
String $_getTokensListPerBridgeHash() =>
    r'918b6b0c84ea079954c007ccf241c6526808a29e';

/// See also [_getTokensListPerBridge].
class _GetTokensListPerBridgeProvider
    extends AutoDisposeFutureProvider<List<BridgeToken>> {
  _GetTokensListPerBridgeProvider(
    this.direction,
  ) : super(
          (ref) => _getTokensListPerBridge(
            ref,
            direction,
          ),
          from: _getTokensListPerBridgeProvider,
          name: r'_getTokensListPerBridgeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $_getTokensListPerBridgeHash,
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

typedef _GetTokensListPerBridgeRef
    = AutoDisposeFutureProviderRef<List<BridgeToken>>;

/// See also [_getTokensListPerBridge].
final _getTokensListPerBridgeProvider = _GetTokensListPerBridgeFamily();

class _GetTokensListPerBridgeFamily
    extends Family<AsyncValue<List<BridgeToken>>> {
  _GetTokensListPerBridgeFamily();

  _GetTokensListPerBridgeProvider call(
    String direction,
  ) {
    return _GetTokensListPerBridgeProvider(
      direction,
    );
  }

  @override
  AutoDisposeFutureProvider<List<BridgeToken>> getProviderOverride(
    covariant _GetTokensListPerBridgeProvider provider,
  ) {
    return call(
      provider.direction,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_getTokensListPerBridgeProvider';
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_blockchain.dart';

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

String $_bridgeBlockchainsRepositoryHash() =>
    r'67771710151e43e7b614a1b9226730df6d753f17';

/// See also [_bridgeBlockchainsRepository].
final _bridgeBlockchainsRepositoryProvider =
    AutoDisposeProvider<BridgeBlockchainsRepository>(
  _bridgeBlockchainsRepository,
  name: r'_bridgeBlockchainsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_bridgeBlockchainsRepositoryHash,
);
typedef _BridgeBlockchainsRepositoryRef
    = AutoDisposeProviderRef<BridgeBlockchainsRepository>;
String $_getBlockchainsListHash() =>
    r'0da5dfde1644be1a26716b32bb4b37556d523b8d';

/// See also [_getBlockchainsList].
final _getBlockchainsListProvider =
    AutoDisposeFutureProvider<List<BridgeBlockchain>>(
  _getBlockchainsList,
  name: r'_getBlockchainsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $_getBlockchainsListHash,
);
typedef _GetBlockchainsListRef
    = AutoDisposeFutureProviderRef<List<BridgeBlockchain>>;

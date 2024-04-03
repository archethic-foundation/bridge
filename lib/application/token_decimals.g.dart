// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_decimals.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tokenDecimalsRepositoryHash() =>
    r'6ae9f6f4486b638f811612623a171b31cd1a962c';

/// See also [_tokenDecimalsRepository].
@ProviderFor(_tokenDecimalsRepository)
final _tokenDecimalsRepositoryProvider =
    AutoDisposeProvider<TokenDecimalsRepository>.internal(
  _tokenDecimalsRepository,
  name: r'_tokenDecimalsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tokenDecimalsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _TokenDecimalsRepositoryRef
    = AutoDisposeProviderRef<TokenDecimalsRepository>;
String _$getTokenDecimalsHash() => r'3de07afdf4dec6375ad8183a880d45cff22433bd';

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

/// See also [_getTokenDecimals].
@ProviderFor(_getTokenDecimals)
const _getTokenDecimalsProvider = _GetTokenDecimalsFamily();

/// See also [_getTokenDecimals].
class _GetTokenDecimalsFamily extends Family<AsyncValue<int>> {
  /// See also [_getTokenDecimals].
  const _GetTokenDecimalsFamily();

  /// See also [_getTokenDecimals].
  _GetTokenDecimalsProvider call(
    bool isArchethic,
    String typeToken,
    String tokenAddress,
  ) {
    return _GetTokenDecimalsProvider(
      isArchethic,
      typeToken,
      tokenAddress,
    );
  }

  @override
  _GetTokenDecimalsProvider getProviderOverride(
    covariant _GetTokenDecimalsProvider provider,
  ) {
    return call(
      provider.isArchethic,
      provider.typeToken,
      provider.tokenAddress,
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
  String? get name => r'_getTokenDecimalsProvider';
}

/// See also [_getTokenDecimals].
class _GetTokenDecimalsProvider extends AutoDisposeFutureProvider<int> {
  /// See also [_getTokenDecimals].
  _GetTokenDecimalsProvider(
    bool isArchethic,
    String typeToken,
    String tokenAddress,
  ) : this._internal(
          (ref) => _getTokenDecimals(
            ref as _GetTokenDecimalsRef,
            isArchethic,
            typeToken,
            tokenAddress,
          ),
          from: _getTokenDecimalsProvider,
          name: r'_getTokenDecimalsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTokenDecimalsHash,
          dependencies: _GetTokenDecimalsFamily._dependencies,
          allTransitiveDependencies:
              _GetTokenDecimalsFamily._allTransitiveDependencies,
          isArchethic: isArchethic,
          typeToken: typeToken,
          tokenAddress: tokenAddress,
        );

  _GetTokenDecimalsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.isArchethic,
    required this.typeToken,
    required this.tokenAddress,
  }) : super.internal();

  final bool isArchethic;
  final String typeToken;
  final String tokenAddress;

  @override
  Override overrideWith(
    FutureOr<int> Function(_GetTokenDecimalsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetTokenDecimalsProvider._internal(
        (ref) => create(ref as _GetTokenDecimalsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        isArchethic: isArchethic,
        typeToken: typeToken,
        tokenAddress: tokenAddress,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _GetTokenDecimalsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetTokenDecimalsProvider &&
        other.isArchethic == isArchethic &&
        other.typeToken == typeToken &&
        other.tokenAddress == tokenAddress;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isArchethic.hashCode);
    hash = _SystemHash.combine(hash, typeToken.hashCode);
    hash = _SystemHash.combine(hash, tokenAddress.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetTokenDecimalsRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `isArchethic` of this provider.
  bool get isArchethic;

  /// The parameter `typeToken` of this provider.
  String get typeToken;

  /// The parameter `tokenAddress` of this provider.
  String get tokenAddress;
}

class _GetTokenDecimalsProviderElement
    extends AutoDisposeFutureProviderElement<int> with _GetTokenDecimalsRef {
  _GetTokenDecimalsProviderElement(super.provider);

  @override
  bool get isArchethic => (origin as _GetTokenDecimalsProvider).isArchethic;
  @override
  String get typeToken => (origin as _GetTokenDecimalsProvider).typeToken;
  @override
  String get tokenAddress => (origin as _GetTokenDecimalsProvider).tokenAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

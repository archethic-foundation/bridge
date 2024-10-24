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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef _TokenDecimalsRepositoryRef
    = AutoDisposeProviderRef<TokenDecimalsRepository>;
String _$getTokenDecimalsHash() => r'c3db7698f37404937f0a9503c39efeb6e40f5c81';

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

/// See also [getTokenDecimals].
@ProviderFor(getTokenDecimals)
const getTokenDecimalsProvider = GetTokenDecimalsFamily();

/// See also [getTokenDecimals].
class GetTokenDecimalsFamily extends Family<AsyncValue<int>> {
  /// See also [getTokenDecimals].
  const GetTokenDecimalsFamily();

  /// See also [getTokenDecimals].
  GetTokenDecimalsProvider call(
    bool isArchethic,
    String typeToken,
    String tokenAddress,
  ) {
    return GetTokenDecimalsProvider(
      isArchethic,
      typeToken,
      tokenAddress,
    );
  }

  @override
  GetTokenDecimalsProvider getProviderOverride(
    covariant GetTokenDecimalsProvider provider,
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
  String? get name => r'getTokenDecimalsProvider';
}

/// See also [getTokenDecimals].
class GetTokenDecimalsProvider extends AutoDisposeFutureProvider<int> {
  /// See also [getTokenDecimals].
  GetTokenDecimalsProvider(
    bool isArchethic,
    String typeToken,
    String tokenAddress,
  ) : this._internal(
          (ref) => getTokenDecimals(
            ref as GetTokenDecimalsRef,
            isArchethic,
            typeToken,
            tokenAddress,
          ),
          from: getTokenDecimalsProvider,
          name: r'getTokenDecimalsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTokenDecimalsHash,
          dependencies: GetTokenDecimalsFamily._dependencies,
          allTransitiveDependencies:
              GetTokenDecimalsFamily._allTransitiveDependencies,
          isArchethic: isArchethic,
          typeToken: typeToken,
          tokenAddress: tokenAddress,
        );

  GetTokenDecimalsProvider._internal(
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
    FutureOr<int> Function(GetTokenDecimalsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetTokenDecimalsProvider._internal(
        (ref) => create(ref as GetTokenDecimalsRef),
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
    return other is GetTokenDecimalsProvider &&
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetTokenDecimalsRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `isArchethic` of this provider.
  bool get isArchethic;

  /// The parameter `typeToken` of this provider.
  String get typeToken;

  /// The parameter `tokenAddress` of this provider.
  String get tokenAddress;
}

class _GetTokenDecimalsProviderElement
    extends AutoDisposeFutureProviderElement<int> with GetTokenDecimalsRef {
  _GetTokenDecimalsProviderElement(super.provider);

  @override
  bool get isArchethic => (origin as GetTokenDecimalsProvider).isArchethic;
  @override
  String get typeToken => (origin as GetTokenDecimalsProvider).typeToken;
  @override
  String get tokenAddress => (origin as GetTokenDecimalsProvider).tokenAddress;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

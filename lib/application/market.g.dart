// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$marketRepositoryHash() => r'582d4226877bf0433fb62e1714a86d182d3f0cb0';

/// See also [_marketRepository].
@ProviderFor(_marketRepository)
final _marketRepositoryProvider =
    AutoDisposeProvider<MarketRepository>.internal(
  _marketRepository,
  name: r'_marketRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$marketRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _MarketRepositoryRef = AutoDisposeProviderRef<MarketRepository>;
String _$getPriceHash() => r'756723a0f015bacf62b2b3c5f557b763b014d088';

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

/// See also [_getPrice].
@ProviderFor(_getPrice)
const _getPriceProvider = _GetPriceFamily();

/// See also [_getPrice].
class _GetPriceFamily extends Family<AsyncValue<Result<double, Failure>>> {
  /// See also [_getPrice].
  const _GetPriceFamily();

  /// See also [_getPrice].
  _GetPriceProvider call(
    String coinId,
  ) {
    return _GetPriceProvider(
      coinId,
    );
  }

  @override
  _GetPriceProvider getProviderOverride(
    covariant _GetPriceProvider provider,
  ) {
    return call(
      provider.coinId,
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
  String? get name => r'_getPriceProvider';
}

/// See also [_getPrice].
class _GetPriceProvider
    extends AutoDisposeFutureProvider<Result<double, Failure>> {
  /// See also [_getPrice].
  _GetPriceProvider(
    String coinId,
  ) : this._internal(
          (ref) => _getPrice(
            ref as _GetPriceRef,
            coinId,
          ),
          from: _getPriceProvider,
          name: r'_getPriceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPriceHash,
          dependencies: _GetPriceFamily._dependencies,
          allTransitiveDependencies: _GetPriceFamily._allTransitiveDependencies,
          coinId: coinId,
        );

  _GetPriceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.coinId,
  }) : super.internal();

  final String coinId;

  @override
  Override overrideWith(
    FutureOr<Result<double, Failure>> Function(_GetPriceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPriceProvider._internal(
        (ref) => create(ref as _GetPriceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        coinId: coinId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Result<double, Failure>> createElement() {
    return _GetPriceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPriceProvider && other.coinId == coinId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, coinId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPriceRef on AutoDisposeFutureProviderRef<Result<double, Failure>> {
  /// The parameter `coinId` of this provider.
  String get coinId;
}

class _GetPriceProviderElement
    extends AutoDisposeFutureProviderElement<Result<double, Failure>>
    with _GetPriceRef {
  _GetPriceProviderElement(super.provider);

  @override
  String get coinId => (origin as _GetPriceProvider).coinId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

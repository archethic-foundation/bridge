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
String _$getPriceFromCoinIdHash() =>
    r'e733a49f3cf9def2d0f88ba60991026a2808b4dd';

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

/// See also [_getPriceFromCoinId].
@ProviderFor(_getPriceFromCoinId)
const _getPriceFromCoinIdProvider = _GetPriceFromCoinIdFamily();

/// See also [_getPriceFromCoinId].
class _GetPriceFromCoinIdFamily
    extends Family<AsyncValue<Result<double, Failure>>> {
  /// See also [_getPriceFromCoinId].
  const _GetPriceFromCoinIdFamily();

  /// See also [_getPriceFromCoinId].
  _GetPriceFromCoinIdProvider call(
    String coinId,
  ) {
    return _GetPriceFromCoinIdProvider(
      coinId,
    );
  }

  @override
  _GetPriceFromCoinIdProvider getProviderOverride(
    covariant _GetPriceFromCoinIdProvider provider,
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
  String? get name => r'_getPriceFromCoinIdProvider';
}

/// See also [_getPriceFromCoinId].
class _GetPriceFromCoinIdProvider
    extends AutoDisposeFutureProvider<Result<double, Failure>> {
  /// See also [_getPriceFromCoinId].
  _GetPriceFromCoinIdProvider(
    String coinId,
  ) : this._internal(
          (ref) => _getPriceFromCoinId(
            ref as _GetPriceFromCoinIdRef,
            coinId,
          ),
          from: _getPriceFromCoinIdProvider,
          name: r'_getPriceFromCoinIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPriceFromCoinIdHash,
          dependencies: _GetPriceFromCoinIdFamily._dependencies,
          allTransitiveDependencies:
              _GetPriceFromCoinIdFamily._allTransitiveDependencies,
          coinId: coinId,
        );

  _GetPriceFromCoinIdProvider._internal(
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
    FutureOr<Result<double, Failure>> Function(_GetPriceFromCoinIdRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPriceFromCoinIdProvider._internal(
        (ref) => create(ref as _GetPriceFromCoinIdRef),
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
    return _GetPriceFromCoinIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPriceFromCoinIdProvider && other.coinId == coinId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, coinId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPriceFromCoinIdRef
    on AutoDisposeFutureProviderRef<Result<double, Failure>> {
  /// The parameter `coinId` of this provider.
  String get coinId;
}

class _GetPriceFromCoinIdProviderElement
    extends AutoDisposeFutureProviderElement<Result<double, Failure>>
    with _GetPriceFromCoinIdRef {
  _GetPriceFromCoinIdProviderElement(super.provider);

  @override
  String get coinId => (origin as _GetPriceFromCoinIdProvider).coinId;
}

String _$getPriceFromSymbolHash() =>
    r'624b8ccf552d0609ba14ab0c18fe265b895d2c25';

/// See also [_getPriceFromSymbol].
@ProviderFor(_getPriceFromSymbol)
const _getPriceFromSymbolProvider = _GetPriceFromSymbolFamily();

/// See also [_getPriceFromSymbol].
class _GetPriceFromSymbolFamily extends Family<AsyncValue<double>> {
  /// See also [_getPriceFromSymbol].
  const _GetPriceFromSymbolFamily();

  /// See also [_getPriceFromSymbol].
  _GetPriceFromSymbolProvider call(
    String symbol,
  ) {
    return _GetPriceFromSymbolProvider(
      symbol,
    );
  }

  @override
  _GetPriceFromSymbolProvider getProviderOverride(
    covariant _GetPriceFromSymbolProvider provider,
  ) {
    return call(
      provider.symbol,
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
  String? get name => r'_getPriceFromSymbolProvider';
}

/// See also [_getPriceFromSymbol].
class _GetPriceFromSymbolProvider extends AutoDisposeFutureProvider<double> {
  /// See also [_getPriceFromSymbol].
  _GetPriceFromSymbolProvider(
    String symbol,
  ) : this._internal(
          (ref) => _getPriceFromSymbol(
            ref as _GetPriceFromSymbolRef,
            symbol,
          ),
          from: _getPriceFromSymbolProvider,
          name: r'_getPriceFromSymbolProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPriceFromSymbolHash,
          dependencies: _GetPriceFromSymbolFamily._dependencies,
          allTransitiveDependencies:
              _GetPriceFromSymbolFamily._allTransitiveDependencies,
          symbol: symbol,
        );

  _GetPriceFromSymbolProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.symbol,
  }) : super.internal();

  final String symbol;

  @override
  Override overrideWith(
    FutureOr<double> Function(_GetPriceFromSymbolRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetPriceFromSymbolProvider._internal(
        (ref) => create(ref as _GetPriceFromSymbolRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        symbol: symbol,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _GetPriceFromSymbolProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetPriceFromSymbolProvider && other.symbol == symbol;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, symbol.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetPriceFromSymbolRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `symbol` of this provider.
  String get symbol;
}

class _GetPriceFromSymbolProviderElement
    extends AutoDisposeFutureProviderElement<double>
    with _GetPriceFromSymbolRef {
  _GetPriceFromSymbolProviderElement(super.provider);

  @override
  String get symbol => (origin as _GetPriceFromSymbolProvider).symbol;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

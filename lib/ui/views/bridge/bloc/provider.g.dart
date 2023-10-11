// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bridgeFormNotifierHash() =>
    r'da2689b5b0abb6e7917cb5c62ae9fce7f2f2ee52';

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

abstract class _$BridgeFormNotifier
    extends BuildlessAutoDisposeNotifier<BridgeFormState> {
  late final BridgeFormState? args;

  BridgeFormState build(
    BridgeFormState? args,
  );
}

/// See also [_BridgeFormNotifier].
@ProviderFor(_BridgeFormNotifier)
const _bridgeFormNotifierProvider = _BridgeFormNotifierFamily();

/// See also [_BridgeFormNotifier].
class _BridgeFormNotifierFamily extends Family<BridgeFormState> {
  /// See also [_BridgeFormNotifier].
  const _BridgeFormNotifierFamily();

  /// See also [_BridgeFormNotifier].
  _BridgeFormNotifierProvider call(
    BridgeFormState? args,
  ) {
    return _BridgeFormNotifierProvider(
      args,
    );
  }

  @override
  _BridgeFormNotifierProvider getProviderOverride(
    covariant _BridgeFormNotifierProvider provider,
  ) {
    return call(
      provider.args,
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
  String? get name => r'_bridgeFormNotifierProvider';
}

/// See also [_BridgeFormNotifier].
class _BridgeFormNotifierProvider extends AutoDisposeNotifierProviderImpl<
    _BridgeFormNotifier, BridgeFormState> {
  /// See also [_BridgeFormNotifier].
  _BridgeFormNotifierProvider(
    BridgeFormState? args,
  ) : this._internal(
          () => _BridgeFormNotifier()..args = args,
          from: _bridgeFormNotifierProvider,
          name: r'_bridgeFormNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bridgeFormNotifierHash,
          dependencies: _BridgeFormNotifierFamily._dependencies,
          allTransitiveDependencies:
              _BridgeFormNotifierFamily._allTransitiveDependencies,
          args: args,
        );

  _BridgeFormNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.args,
  }) : super.internal();

  final BridgeFormState? args;

  @override
  BridgeFormState runNotifierBuild(
    covariant _BridgeFormNotifier notifier,
  ) {
    return notifier.build(
      args,
    );
  }

  @override
  Override overrideWith(_BridgeFormNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: _BridgeFormNotifierProvider._internal(
        () => create()..args = args,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        args: args,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<_BridgeFormNotifier, BridgeFormState>
      createElement() {
    return _BridgeFormNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _BridgeFormNotifierProvider && other.args == args;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, args.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _BridgeFormNotifierRef
    on AutoDisposeNotifierProviderRef<BridgeFormState> {
  /// The parameter `args` of this provider.
  BridgeFormState? get args;
}

class _BridgeFormNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<_BridgeFormNotifier,
        BridgeFormState> with _BridgeFormNotifierRef {
  _BridgeFormNotifierProviderElement(super.provider);

  @override
  BridgeFormState? get args => (origin as _BridgeFormNotifierProvider).args;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_mobile_format.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isAppMobileFormatHash() => r'5adde64bfc13070911848990b92b589d8bb8028c';

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

/// See also [isAppMobileFormat].
@ProviderFor(isAppMobileFormat)
const isAppMobileFormatProvider = IsAppMobileFormatFamily();

/// See also [isAppMobileFormat].
class IsAppMobileFormatFamily extends Family<bool> {
  /// See also [isAppMobileFormat].
  const IsAppMobileFormatFamily();

  /// See also [isAppMobileFormat].
  IsAppMobileFormatProvider call(
    BuildContext context,
  ) {
    return IsAppMobileFormatProvider(
      context,
    );
  }

  @override
  IsAppMobileFormatProvider getProviderOverride(
    covariant IsAppMobileFormatProvider provider,
  ) {
    return call(
      provider.context,
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
  String? get name => r'isAppMobileFormatProvider';
}

/// See also [isAppMobileFormat].
class IsAppMobileFormatProvider extends Provider<bool> {
  /// See also [isAppMobileFormat].
  IsAppMobileFormatProvider(
    BuildContext context,
  ) : this._internal(
          (ref) => isAppMobileFormat(
            ref as IsAppMobileFormatRef,
            context,
          ),
          from: isAppMobileFormatProvider,
          name: r'isAppMobileFormatProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isAppMobileFormatHash,
          dependencies: IsAppMobileFormatFamily._dependencies,
          allTransitiveDependencies:
              IsAppMobileFormatFamily._allTransitiveDependencies,
          context: context,
        );

  IsAppMobileFormatProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final BuildContext context;

  @override
  Override overrideWith(
    bool Function(IsAppMobileFormatRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsAppMobileFormatProvider._internal(
        (ref) => create(ref as IsAppMobileFormatRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  ProviderElement<bool> createElement() {
    return _IsAppMobileFormatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsAppMobileFormatProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsAppMobileFormatRef on ProviderRef<bool> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _IsAppMobileFormatProviderElement extends ProviderElement<bool>
    with IsAppMobileFormatRef {
  _IsAppMobileFormatProviderElement(super.provider);

  @override
  BuildContext get context => (origin as IsAppMobileFormatProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

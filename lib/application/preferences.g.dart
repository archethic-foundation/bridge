// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$preferencesRepositoryHash() =>
    r'd6fbea253becb455dfe91fbff34e698be9996581';

/// See also [_preferencesRepository].
@ProviderFor(_preferencesRepository)
final _preferencesRepositoryProvider =
    AutoDisposeProvider<PreferencesRepository>.internal(
  _preferencesRepository,
  name: r'_preferencesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$preferencesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _PreferencesRepositoryRef
    = AutoDisposeProviderRef<PreferencesRepository>;
String _$getPreferencesHash() => r'aed236ee6504de5c172fb9ae06a49e996639538f';

/// See also [_getPreferences].
@ProviderFor(_getPreferences)
final _getPreferencesProvider =
    AutoDisposeFutureProvider<HivePreferencesDatasource>.internal(
  _getPreferences,
  name: r'_getPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetPreferencesRef
    = AutoDisposeFutureProviderRef<HivePreferencesDatasource>;
String _$isLogsActivedHash() => r'fc5d3e99156b2cb93f39b4b24767cb1ab0919bf0';

/// See also [_isLogsActived].
@ProviderFor(_isLogsActived)
final _isLogsActivedProvider = AutoDisposeFutureProvider<bool>.internal(
  _isLogsActived,
  name: r'_isLogsActivedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isLogsActivedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _IsLogsActivedRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

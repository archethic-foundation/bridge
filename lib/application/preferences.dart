import 'package:aebridge/domain/repositories/preferences.repository.dart';
import 'package:aebridge/infrastructure/hive/preferences.hive.dart';
import 'package:aebridge/infrastructure/preferences.respository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'preferences.g.dart';

@riverpod
PreferencesRepository _preferencesRepository(
  _PreferencesRepositoryRef ref,
) =>
    PreferencesRepositoryImpl();

@riverpod
Future<HivePreferencesDatasource> _getPreferences(
  _GetPreferencesRef ref,
) async {
  return ref.watch(_preferencesRepositoryProvider).getPreferences();
}

@riverpod
Future<bool> _isLogsActived(
  _IsLogsActivedRef ref,
) async {
  final preferences =
      await ref.watch(_preferencesRepositoryProvider).getPreferences();
  return preferences.isLogsActived();
}

abstract class PreferencesProviders {
  static final getPreferences = _getPreferencesProvider;
  static final isLogsActived = _isLogsActivedProvider;
  static final preferencesRepository = _preferencesRepositoryProvider;
}

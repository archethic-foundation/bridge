/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/infrastructure/hive/preferences.hive.dart';

abstract class PreferencesRepository {
  Future<HivePreferencesDatasource> getPreferences();

  Future<void> setFirstConnection(bool value);

  Future<void> setLogsActived(bool value);

  Future<bool> isLogsActived();
}

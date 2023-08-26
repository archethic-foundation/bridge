/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:developer';

import 'package:aebridge/model/hive/db_helper.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

void setupServiceLocator() {
  sl
    ..registerLazySingleton<DBHelper>(DBHelper.new)
    ..registerLazySingleton<OracleService>(
      () => OracleService('https://mainnet.archethic.net'),
    );
  log('Register', name: 'OracleService');
}

void setupServiceLocatorApiService(String endpoint) {
  sl.registerLazySingleton<ApiService>(
    () => ApiService(endpoint),
  );
  log('Register', name: 'ApiService');
}

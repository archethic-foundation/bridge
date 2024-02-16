/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/infrastructure/hive/db_helper.hive.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

void setupServiceLocator() {
  aedappfm.sl
    ..registerLazySingleton<DBHelper>(DBHelper.new)
    ..registerLazySingleton<aedappfm.LogManager>(
      () => aedappfm.LogManager(
        url:
            'https://faas-fra1-afec6ce7.doserverless.co/api/v1/web/fn-b200dcda-cd45-406c-acb1-8a7642f462c2/default/app-log',
      ),
    )
    ..registerLazySingleton<OracleService>(
      () =>
          OracleService('https://mainnet.archethic.net', logsActivation: false),
    );
}

void setupServiceLocatorApiService(String endpoint) {
  aedappfm.sl.registerLazySingleton<ApiService>(
    () => ApiService(endpoint, logsActivation: false),
  );
}

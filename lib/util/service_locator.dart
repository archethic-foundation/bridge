/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/infrastructure/hive/db_helper.hive.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;

Future<void> setupServiceLocator() async {
  if (aedappfm.sl.isRegistered<aedappfm.LogManager>()) {
    await aedappfm.sl.unregister<aedappfm.LogManager>();
  }

  aedappfm.sl
    ..registerSingleton<EVMWalletProvider>(
      EVMWalletProvider(),
    )
    ..registerLazySingleton<DBHelper>(DBHelper.new)
    ..registerLazySingleton<OracleService>(
      () =>
          OracleService('https://mainnet.archethic.net', logsActivation: false),
    )
    ..registerLazySingleton<aedappfm.LogManager>(() {
      if (Uri.base.toString().toLowerCase().contains('bridge.archethic')) {
        return aedappfm.LogManager(
          url:
              'https://faas-fra1-afec6ce7.doserverless.co/api/v1/web/fn-b200dcda-cd45-406c-acb1-8a7642f462c2/default/app-log-mainnet',
        );
      } else {
        return aedappfm.LogManager(
          url:
              'https://faas-fra1-afec6ce7.doserverless.co/api/v1/web/fn-b200dcda-cd45-406c-acb1-8a7642f462c2/default/app-log',
        );
      }
    })
    ..registerLazySingletonAsync<awc.ArchethicDAppClient>(
      () async {
        try {
          final client = await awc.ArchethicDAppClient.auto(
            origin: const awc.RequestOrigin(
              name: 'aebridge',
            ),
            replyBaseUrl: 'aebridge://archethic.tech',
          );

          return client;
        } catch (e, stackTrace) {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                '$e',
                stackTrace: stackTrace,
                level: aedappfm.LogLevel.error,
                name: '_SessionNotifier - connectToArchethicWallet',
              );
          throw const aedappfm.Failure.connectivityArchethic();
        }
      },
      dispose: (dappClient) async {
        await dappClient.close();
      },
    );
}

Future<void> setupServiceLocatorApiService(String endpoint) async {
  if (aedappfm.sl.isRegistered<ApiService>()) {
    await aedappfm.sl.unregister<ApiService>();
  }
  aedappfm.sl.registerLazySingleton<ApiService>(
    () => ApiService(endpoint, logsActivation: false),
  );
}

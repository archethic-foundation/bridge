/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/app_embedded.dart';
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/infrastructure/hive/db_helper.hive.dart';
import 'package:aebridge/ui/util/router.dart';
import 'package:aebridge/util/service_locator.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  aedappfm.LoggerOutput.setup(level: Level.SEVERE);

  await DBHelper.setupDatabase();
  await setupServiceLocator();
  await wagmi.init();
  setPathUrlStrategy();
  runApp(
    ProviderScope(
      observers: [
        aedappfm.ProvidersLogger(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(
            aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO.notifier,
          )
          .startSubscription();
      await ref
          .read(
            aedappfm.CoinPriceProviders.coinPrices.notifier,
          )
          .startTimer();

      final evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
      if (!evmWalletProvider.isInit) {
        await evmWalletProvider.init(
          ref.read(bridgeBlockchainsRepositoryProvider),
          ref.read(isAppEmbeddedProvider),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'aebridge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'PPTelegraf',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'PPTelegraf',
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        aedappfm.AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      locale: const Locale('en', 'US'),
    );
  }
}

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/oracle/provider.dart';
import 'package:aebridge/infrastructure/hive/db_helper.hive.dart';
import 'package:aebridge/ui/views/main_screen/layouts/main_screen.dart';
import 'package:aebridge/ui/views/welcome/welcome_screen.dart';
import 'package:aebridge/util/generic/providers_observer.dart';
import 'package:aebridge/util/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.setupDatabase();
  setupServiceLocator();
  runApp(
    ProviderScope(
      observers: [
        ProvidersLogger(logger: false),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(ArchethicOracleUCOProviders.archethicOracleUCO.notifier).init();

    // GoRouter configuration
    final _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const WelcomeScreen();
          },
        ),
        GoRoute(
          path: '/main',
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          path: '/welcome',
          builder: (context, state) => const WelcomeScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: _router,
      title: 'aebridge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Telegraf',
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Telegraf',
        useMaterial3: true,
      ),
      supportedLocales: const <Locale>[
        // add here all the supported languages in the app (intl files)
        Locale('en'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

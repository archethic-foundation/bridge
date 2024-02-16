import 'package:aebridge/infrastructure/hive/preferences.hive.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/welcome/welcome_screen.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Splash
/// Default page route that determines if user is logged in
/// and routes them appropriately.
class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  static const routerPage = '/';

  @override
  ConsumerState<Splash> createState() => SplashState();
}

class SplashState extends ConsumerState<Splash> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await HivePreferencesDatasource.getInstance().then((value) {
        if (value.isFirstConnection()) {
          if (context.mounted) context.go(WelcomeScreen.routerPage);
        }
      });
      if (!context.mounted) return;
      context.go(
        BridgeSheet.routerPage,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: aedappfm.AppBackground(
        backgroundImage: 'assets/images/background-welcome.png',
      ),
    );
  }
}

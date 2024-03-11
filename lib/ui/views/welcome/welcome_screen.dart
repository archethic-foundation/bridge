import 'dart:ui';

import 'package:aebridge/ui/util/components/bridge_main_menu_app.dart';
import 'package:aebridge/ui/views/main_screen/layouts/app_bar_welcome.dart';
import 'package:aebridge/ui/views/welcome/components/welcome_bridge_btn.dart';
import 'package:aebridge/ui/views/welcome/components/welcome_title.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({
    super.key,
  });

  static const routerPage = '/welcome';

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _isSubMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeSubMenu,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: aedappfm.AppThemeBase.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AppBarWelcome(
                onAEMenuTapped: _toggleSubMenu,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            const aedappfm.AppBackground(
              withAnimation: true,
              backgroundImage: 'assets/images/background-welcome.png',
            ),
            const Column(
              children: [
                WelcomeTitle(),
                WelcomeBridgeBtn(),
              ],
            ),
            if (_isSubMenuOpen)
              const BridgeMainMenuApp(
                withFaucet: false,
              ),
          ],
        ),
      ),
    );
  }

  void _toggleSubMenu() {
    setState(() {
      _isSubMenuOpen = !_isSubMenuOpen;
    });
    return;
  }

  void _closeSubMenu() {
    setState(() {
      _isSubMenuOpen = false;
    });
  }
}

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aebridge/infrastructure/hive/preferences.hive.dart';
import 'package:aebridge/ui/util/components/bridge_main_menu_app.dart';
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/main_screen/layouts/app_bar.dart';
import 'package:aebridge/ui/views/main_screen/layouts/bottom_navigation_bar.dart';
import 'package:aebridge/ui/views/main_screen/layouts/browser_popup.dart';
import 'package:aebridge/ui/views/main_screen/layouts/privacy_popup.dart';
import 'package:aebridge/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aebridge/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreenList extends ConsumerStatefulWidget {
  const MainScreenList({required this.body, super.key});

  final Widget body;
  @override
  ConsumerState<MainScreenList> createState() => MainScreenListState();
}

class MainScreenListState extends ConsumerState<MainScreenList> {
  bool _isSubMenuOpen = false;
  List<(String, IconData)> listNavigationLabelIcon = [];

  @override
  void initState() {
    super.initState();

    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const BrowserPopup();
          },
        );
      });
    }

    HivePreferencesDatasource.getInstance().then((value) {
      if (value.isFirstConnection()) {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PrivacyPopup();
            },
          );
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    listNavigationLabelIcon = [
      (
        AppLocalizations.of(context)!.menu_bridge,
        aedappfm.Iconsax.recovery_convert
      ),
      (
        AppLocalizations.of(context)!.menu_local_history,
        aedappfm.Iconsax.clock
      ),
      (
        AppLocalizations.of(context)!.menu_refund,
        aedappfm.Iconsax.empty_wallet_change
      ),
    ];
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeSubMenu,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: aedappfm.AppThemeBase.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AppBarMainScreen(
                onAEMenuTapped: _toggleSubMenu,
              ),
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.topRight,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const aedappfm.AppBackground(
                  backgroundImage: 'assets/images/background-welcome.png',
                ),
                widget.body
                    .animate()
                    .fade(
                      duration: const Duration(milliseconds: 200),
                    )
                    .scale(
                      duration: const Duration(milliseconds: 200),
                    ),
                if (_isSubMenuOpen) const BridgeMainMenuApp(),
              ],
            ),
          ],
        ),
        bottomNavigationBar: aedappfm.Responsive.isMobile(context) ||
                aedappfm.Responsive.isTablet(context)
            ? BottomNavigationBarMainScreen(
                listNavigationLabelIcon: listNavigationLabelIcon,
                navDrawerIndex: ref.watch(navigationIndexMainScreenProvider),
              )
            : null,
      ),
    );
  }
}

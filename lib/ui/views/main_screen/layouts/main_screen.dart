/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';

import 'package:aebridge/infrastructure/hive/preferences.hive.dart';
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/main_screen/layouts/app_bar.dart';
import 'package:aebridge/ui/views/main_screen/layouts/body.dart';
import 'package:aebridge/ui/views/main_screen/layouts/bottom_navigation_bar.dart';
import 'package:aebridge/ui/views/main_screen/layouts/browser_popup.dart';
import 'package:aebridge/ui/views/main_screen/layouts/privacy_popup.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/bridge_background.dart';
import 'package:aebridge/ui/views/util/components/bridge_main_menu_app.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:aebridge/util/browser_util.dart';
import 'package:busy/busy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});
  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
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
      (AppLocalizations.of(context)!.menu_bridge, Iconsax.recovery_convert),
      (AppLocalizations.of(context)!.menu_local_history, Iconsax.clock),
      (AppLocalizations.of(context)!.menu_refund, Iconsax.empty_wallet_change),
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
      child: BusyScaffold(
        isBusy: ref.watch(isLoadingMainScreenProvider),
        scaffold: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: BridgeThemeBase.backgroundColor,
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
            alignment: Alignment.center,
            children: [
              const BridgeBackground(),
              Body(
                listNavigationLabelIcon: listNavigationLabelIcon,
                navDrawerIndex: ref.watch(navigationIndexMainScreenProvider),
              ),
              if (_isSubMenuOpen) const BridgeMainMenuApp(),
            ],
          ),
          bottomNavigationBar: Responsive.isMobile(context)
              ? BottomNavigationBarMainScreen(
                  listNavigationLabelIcon: listNavigationLabelIcon,
                  navDrawerIndex: ref.watch(navigationIndexMainScreenProvider),
                )
              : null,
        ),
      ),
    );
  }
}

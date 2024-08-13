/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:ui';
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/main_screen/layouts/app_bar.dart';
import 'package:aebridge/ui/views/main_screen/layouts/bottom_navigation_bar.dart';
import 'package:aebridge/ui/views/main_screen/layouts/browser_popup.dart';
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    listNavigationLabelIcon = [
      (
        AppLocalizations.of(context)!.menu_swap,
        aedappfm.Iconsax.arrange_circle_2
      ),
      (
        AppLocalizations.of(context)!.menu_liquidity,
        aedappfm.Iconsax.wallet_money
      ),
      (AppLocalizations.of(context)!.menu_earn, aedappfm.Iconsax.wallet_add),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: aedappfm.AppThemeBase.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: const AppBarMainScreen(),
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
    );
  }
}

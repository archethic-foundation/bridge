/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/local_history/local_history_sheet.dart';
import 'package:aebridge/ui/views/main_screen/app_bar.dart';
import 'package:aebridge/ui/views/main_screen/body.dart';
import 'package:aebridge/ui/views/main_screen/bottom_navigation_bar.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});
  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  bool _isSubMenuOpen = false;
  int navigationIndex = 0;
  List<(String, IconData)> listNavigationLabelIcon = [];

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

  void _onDestinationSelected(int selectedIndex) {
    setState(() {
      navigationIndex = selectedIndex;
    });

    switch (selectedIndex) {
      case 0:
        ref
            .read(
              MainScreenWidgetDisplayedProviders
                  .mainScreenWidgetDisplayedProvider.notifier,
            )
            .setWidget(const BridgeSheet());

        break;
      case 1:
        ref
            .read(
              MainScreenWidgetDisplayedProviders
                  .mainScreenWidgetDisplayedProvider.notifier,
            )
            .setWidget(const LocalHistorySheet());

        break;
      case 2:
        ref
            .read(
              MainScreenWidgetDisplayedProviders
                  .mainScreenWidgetDisplayedProvider.notifier,
            )
            .setWidget(const RefundSheet());

        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeSubMenu,
      child: Scaffold(
        backgroundColor: BridgeThemeBase.backgroundColor,
        appBar: AppBarMainScreen(
          onAEMenuTapped: _toggleSubMenu,
          title: Center(
            child: Text(
              listNavigationLabelIcon[navigationIndex].$1,
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Body(
              listNavigationLabelIcon: listNavigationLabelIcon,
              navDrawerIndex: navigationIndex,
              onDestinationSelected: _onDestinationSelected,
            ),
            if (_isSubMenuOpen)
              Positioned(
                top: 0,
                right: 20,
                child: Column(
                  children: [
                    _buildSubMenu(
                      AppLocalizations.of(context)!
                          .archethicDashboardMenuAEWebItem,
                      AppLocalizations.of(context)!
                          .archethicDashboardMenuAEWebDesc,
                      'https://aeweb.archethic.net',
                    )
                        .animate(delay: 100.ms)
                        .fadeIn(duration: 400.ms, delay: 200.ms)
                        .move(
                          begin: const Offset(-16, 0),
                          curve: Curves.easeOutQuad,
                        ),
                    _buildSubMenu(
                      AppLocalizations.of(context)!
                          .archethicDashboardMenuBridgeOnWayItem,
                      AppLocalizations.of(context)!
                          .archethicDashboardMenuBridgeOnWayDesc,
                      'https://bridge.archethic.net',
                    )
                        .animate(delay: 200.ms)
                        .fadeIn(duration: 400.ms, delay: 200.ms)
                        .move(
                          begin: const Offset(-16, 0),
                          curve: Curves.easeOutQuad,
                        ),
                    _buildSubMenu(
                      AppLocalizations.of(context)!
                          .archethicDashboardMenuDEXItem,
                      AppLocalizations.of(context)!
                          .archethicDashboardMenuDEXDesc,
                      'https://dex.archethic.net',
                    )
                        .animate(delay: 300.ms)
                        .fadeIn(duration: 400.ms, delay: 200.ms)
                        .move(
                          begin: const Offset(-16, 0),
                          curve: Curves.easeOutQuad,
                        ),
                    _buildSubMenu(
                      AppLocalizations.of(context)!
                          .archethicDashboardMenuWalletOnWayItem,
                      AppLocalizations.of(context)!
                          .archethicDashboardMenuWalletOnWayDesc,
                      'https://www.archethic.net/aewallet.html',
                    )
                        .animate(delay: 400.ms)
                        .fadeIn(duration: 400.ms, delay: 200.ms)
                        .move(
                          begin: const Offset(-16, 0),
                          curve: Curves.easeOutQuad,
                        ),
                  ],
                ),
              ),
          ],
        ),
        bottomNavigationBar: Responsive.isMobile(context)
            ? BottomNavigationBarMainScreen(
                listNavigationLabelIcon: listNavigationLabelIcon,
                navDrawerIndex: navigationIndex,
                onDestinationSelected: _onDestinationSelected,
              )
            : null,
      ),
    );
  }

  Widget _buildSubMenu(
    String label,
    String description,
    String url,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () {
          launchUrl(
            Uri.parse(url),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                ArchethicThemeBase.blue800,
                BlendMode.modulate,
              ),
              image: const AssetImage(
                'assets/images/background-sub-menu.png',
              ),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: ArchethicThemeBase.neutral900,
                blurRadius: 40,
                spreadRadius: 10,
                offset: const Offset(1, 10),
              ),
            ],
          ),
          width: 250,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    description,
                    textAlign: TextAlign.end,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

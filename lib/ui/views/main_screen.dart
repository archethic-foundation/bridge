/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/navigation_drawer_section.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'util/header.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});
  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  bool _isSubMenuOpen = false;
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
        backgroundColor: BridgeThemeBase.backgroundColor,
        appBar: AppBar(
          leading: const Header(),
          leadingWidth: 150,
          actions: [
            PopupMenuButton(
              offset: const Offset(0, 50),
              icon: const Icon(Iconsax.message_question),
              onSelected: (selectedIndex) {
                var url = '';
                if (selectedIndex == 0) {
                  url = 'https://wiki.archethic.net';
                } else if (selectedIndex == 1) {
                  url = 'https://github.com/archethic-foundation/bridge';
                } else if (selectedIndex == 2) {
                  url = 'https://wiki.archethic.net/category/FAQ';
                } else if (selectedIndex == 3) {
                  url = 'https://wiki.archethic.net/';
                }

                launchUrl(
                  Uri.parse(
                    url,
                  ),
                );
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.document_text,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(AppLocalizations.of(context)!.menu_documentation),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Iconsax.export_3,
                        size: 12,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.code_circle,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(AppLocalizations.of(context)!.menu_sourceCode),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Iconsax.export_3,
                        size: 12,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.message_question,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(AppLocalizations.of(context)!.menu_faq),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Iconsax.export_3,
                        size: 12,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.video_play,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(AppLocalizations.of(context)!.menu_tuto),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Iconsax.export_3,
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            IconButton(
              icon: const Icon(Iconsax.element_3),
              onPressed: _toggleSubMenu,
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        body: Responsive(
          mobile: const SizedBox(),
          tablet: const SizedBox(),
          desktop: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 30,
                        bottom: 30,
                        left: 30,
                        right: 10,
                      ),
                      child: NavigationDrawerSection(),
                    )
                        .animate()
                        .fade(duration: const Duration(milliseconds: 200))
                        .scale(duration: const Duration(milliseconds: 200)),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: ref
                          .watch(
                            MainScreenWidgetDisplayedProviders
                                .mainScreenWidgetDisplayedProvider,
                          )
                          .animate()
                          .fade(
                            duration: const Duration(milliseconds: 200),
                          )
                          .scale(
                            duration: const Duration(milliseconds: 200),
                          ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                child: Text(
                  'The visuals in the app are temporary and subject to change in future updates',
                  style: TextStyle(
                    color: ArchethicThemeBase.systemDanger500,
                  ),
                ),
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
                    ],
                  ),
                ),
            ],
          ),
        ),
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

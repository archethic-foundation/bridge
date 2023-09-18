/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/navigation_drawer_section.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/icon_animated.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BridgeThemeBase.backgroundColor,
      body: Responsive(
        mobile: const SizedBox(),
        tablet: const SizedBox(),
        desktop: Stack(
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
              top: 10,
              right: 44,
              child: IconButton(
                icon: const Icon(Iconsax.element_3, size: 20),
                onPressed: _toggleSubMenu,
              ),
            ),
            if (_isSubMenuOpen)
              Positioned(
                top: 40,
                right: 10,
                child: Column(
                  children: [
                    _buildSubMenuIcon(
                      Iconsax.activity,
                      'AEWeb',
                      'https://aeweb.archethic.net',
                    ),
                    _buildSubMenuIcon(
                      Iconsax.activity,
                      'Bridge on way',
                      'https://bridge.archethic.net',
                    ),
                    _buildSubMenuIcon(
                      Iconsax.activity,
                      'DEX',
                      'https://dex.archethic.net',
                    ),
                    _buildSubMenuIcon(
                      Iconsax.add,
                      'Website',
                      'https://archethic.net',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubMenuIcon(IconData icon, String label, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          launchUrl(
            Uri.parse(url),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              IconAnimated(icon: icon, color: Colors.white60),
              const SizedBox(
                height: 3,
              ),
              Text(label, style: const TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}

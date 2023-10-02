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

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BridgeThemeBase.backgroundColor,
      endDrawer: NavigationDrawer(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          _buildSubMenu(
            AppLocalizations.of(context)!.archethicDashboardMenuAEWebItem,
            AppLocalizations.of(context)!.archethicDashboardMenuAEWebDesc,
            'https://aeweb.archethic.net',
          ),
          _buildSubMenu(
            AppLocalizations.of(context)!.archethicDashboardMenuBridgeOnWayItem,
            AppLocalizations.of(context)!.archethicDashboardMenuBridgeOnWayDesc,
            'https://bridge.archethic.net',
          ),
          _buildSubMenu(
            AppLocalizations.of(context)!.archethicDashboardMenuDEXItem,
            AppLocalizations.of(context)!.archethicDashboardMenuDEXDesc,
            'https://dex.archethic.net',
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          return Responsive(
            mobile: const SizedBox(),
            tablet: const SizedBox(),
            desktop: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
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
                    Expanded(
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
                  top: 20,
                  right: 20,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                    ),
                    child: IconButton(
                      icon: const Icon(Iconsax.element_3, size: 26),
                      hoverColor: Colors.transparent,
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ),
                  ),
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
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubMenu(
    String label,
    String description,
    String url,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(50),
                right: Radius.circular(50),
              ),
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
            ),
            child: TextButton(
              onPressed: () {
                launchUrl(
                  Uri.parse(url),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .color,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  description,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Iconsax.export_3,
                      size: 24,
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

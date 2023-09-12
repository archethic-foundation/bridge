import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/application/version.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/local_history/local_history_sheet.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/connection_to_wallet_status.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:aebridge/ui/views/util/header.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuDestination {
  const MenuDestination(
    this.label,
    this.icon,
    this.externalLink, {
    this.readOnly = false,
  });

  final String label;
  final Widget icon;
  final bool externalLink;
  final bool readOnly;
}

class NavigationDrawerSection extends ConsumerStatefulWidget {
  const NavigationDrawerSection({super.key});

  @override
  ConsumerState<NavigationDrawerSection> createState() =>
      _NavigationDrawerSectionState();
}

class _NavigationDrawerSectionState
    extends ConsumerState<NavigationDrawerSection> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Responsive.isDesktop(context)
                ? NavigationDrawer(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    onDestinationSelected: (selectedIndex) {
                      setState(() {
                        navDrawerIndex = selectedIndex;
                      });
                      _manageLink(selectedIndex);
                    },
                    selectedIndex: navDrawerIndex,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                        child: Text(
                          AppLocalizations.of(context)!.menu_section_actions,
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ...<MenuDestination>[
                        MenuDestination(
                          AppLocalizations.of(context)!.menu_bridge,
                          const Icon(Iconsax.recovery_convert),
                          false,
                        ),
                        MenuDestination(
                          AppLocalizations.of(context)!.menu_local_history,
                          const Icon(Iconsax.clock),
                          false,
                        ),
                        MenuDestination(
                          AppLocalizations.of(context)!.menu_refund,
                          const Icon(Iconsax.empty_wallet_change),
                          false,
                        ),
                      ].map((destination) {
                        return NavigationDrawerDestination(
                          label: destination.externalLink
                              ? Row(
                                  children: [
                                    Text(
                                      destination.label,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                    const SizedBox(width: 5),
                                    const Icon(
                                      Iconsax.export_3,
                                      size: 12,
                                    ),
                                  ],
                                )
                              : Text(
                                  destination.label,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                          icon: destination.icon,
                          selectedIcon: destination.icon,
                        );
                      }),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 50,
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: BridgeThemeBase.gradient,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (Responsive.isDesktop(context))
                        Padding(
                          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                          child: Text(
                            AppLocalizations.of(context)!.menu_section_infos,
                            style: Theme.of(context).textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ...<MenuDestination>[
                        MenuDestination(
                          AppLocalizations.of(context)!.menu_documentation,
                          const Icon(Iconsax.document_text),
                          true,
                        ),
                        MenuDestination(
                          AppLocalizations.of(context)!.menu_sourceCode,
                          const Icon(Iconsax.code_circle),
                          true,
                        ),
                        MenuDestination(
                          AppLocalizations.of(context)!.menu_faq,
                          const Icon(Iconsax.message_question),
                          true,
                        ),
                        MenuDestination(
                          AppLocalizations.of(context)!.menu_tuto,
                          const Icon(Iconsax.video_play),
                          true,
                        ),
                      ].map((destination) {
                        return Responsive.isDesktop(context)
                            ? NavigationDrawerDestination(
                                label: destination.externalLink
                                    ? Row(
                                        children: [
                                          Text(
                                            destination.label,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          const SizedBox(width: 5),
                                          const Icon(
                                            Iconsax.export_3,
                                            size: 12,
                                          ),
                                        ],
                                      )
                                    : Text(destination.label),
                                icon: destination.icon,
                                selectedIcon: destination.icon,
                              )
                            : NavigationDrawerDestination(
                                label: const SizedBox(),
                                icon: destination.icon,
                                selectedIcon: destination.icon,
                              );
                      }),
                    ],
                  )
                : NavigationRail(
                    backgroundColor: Colors.transparent,
                    destinations: const [
                      NavigationRailDestination(
                        label: SizedBox(),
                        icon: Icon(Iconsax.recovery_convert),
                      ),
                      NavigationRailDestination(
                        label: SizedBox(),
                        icon: Icon(Iconsax.document_text),
                      ),
                      NavigationRailDestination(
                        label: SizedBox(),
                        icon: Icon(Iconsax.code_circle),
                      ),
                      NavigationRailDestination(
                        label: SizedBox(),
                        icon: Icon(Iconsax.message_question),
                      ),
                      NavigationRailDestination(
                        label: SizedBox(),
                        icon: Icon(Iconsax.video_play),
                      ),
                    ],
                    selectedIndex: navDrawerIndex,
                    onDestinationSelected: (selectedIndex) {
                      setState(() {
                        navDrawerIndex = selectedIndex;
                      });
                      _manageLink(selectedIndex);
                    },
                  ),
          ),
        ),
        if (Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/AELogo-Public Blockchain-White.svg',
                  semanticsLabel: 'AE Logo',
                  height: 22,
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final asyncVersionString = ref.watch(
                      versionStringProvider(
                        AppLocalizations.of(context)!,
                      ),
                    );
                    return Text(
                      asyncVersionString.asData?.value ?? '',
                      style: Theme.of(context).textTheme.labelSmall,
                    );
                  },
                ),
              ],
            ),
          ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: ConnectionToWalletStatus(),
        ),
      ],
    );
  }

  void _manageLink(int selectedIndex) {
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
      case 3:
        launchUrl(
          Uri.parse(
            'https://wiki.archethic.net',
          ),
        );
        break;
      case 4:
        launchUrl(
          Uri.parse(
            'https://github.com/archethic-foundation/bridge',
          ),
        );
        break;
      case 5:
        launchUrl(
          Uri.parse(
            'https://wiki.archethic.net/category/FAQ',
          ),
        );
        break;
      case 6:
        launchUrl(
          Uri.parse(
            'https://wiki.archethic.net/',
          ),
        );
        break;
      default:
    }
  }
}

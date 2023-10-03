import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/local_history/local_history_sheet.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuDestination {
  const MenuDestination(
    this.label,
    this.icon, {
    this.readOnly = false,
  });

  final String label;
  final Widget icon;
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: NavigationRail(
              extended: Responsive.isDesktop(context),
              labelType: Responsive.isDesktop(context)
                  ? null
                  : NavigationRailLabelType.all,
              backgroundColor: Colors.transparent,
              destinations: [
                NavigationRailDestination(
                  label: Text(AppLocalizations.of(context)!.menu_bridge),
                  icon: const Icon(Iconsax.recovery_convert),
                ),
                NavigationRailDestination(
                  label: Text(AppLocalizations.of(context)!.menu_local_history),
                  icon: const Icon(Iconsax.clock),
                ),
                NavigationRailDestination(
                  label: Text(AppLocalizations.of(context)!.menu_refund),
                  icon: const Icon(Iconsax.empty_wallet_change),
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
              bottom: 10,
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/AELogo-Public Blockchain-White.svg',
                  semanticsLabel: 'AE Logo',
                  height: 22,
                ),
              ],
            ),
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
      default:
    }
  }
}

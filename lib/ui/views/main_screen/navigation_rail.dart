import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationRailMainScreen extends ConsumerStatefulWidget {
  const NavigationRailMainScreen({
    super.key,
    required this.navDrawerIndex,
    required this.listNavigationLabelIcon,
    required this.onDestinationSelected,
  });

  final int navDrawerIndex;
  final List<(String, IconData)> listNavigationLabelIcon;
  final Function(int) onDestinationSelected;

  @override
  ConsumerState<NavigationRailMainScreen> createState() =>
      _NavigationRailMainScreenState();
}

class _NavigationRailMainScreenState
    extends ConsumerState<NavigationRailMainScreen> {
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
              destinations: widget.listNavigationLabelIcon
                  .map(
                    (item) => NavigationRailDestination(
                      label: Text(item.$1),
                      icon: Icon(item.$2),
                    ),
                  )
                  .toList(),
              selectedIndex: widget.navDrawerIndex,
              onDestinationSelected: widget.onDestinationSelected,
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
}

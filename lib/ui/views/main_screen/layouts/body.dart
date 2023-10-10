/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/ui/views/main_screen/layouts/navigation_rail.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Body extends ConsumerWidget {
  const Body({
    super.key,
    required this.navDrawerIndex,
    required this.listNavigationLabelIcon,
    required this.onDestinationSelected,
  });

  final int navDrawerIndex;
  final List<(String, IconData)> listNavigationLabelIcon;
  final Function(int) onDestinationSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (Responsive.isTablet(context) || Responsive.isDesktop(context))
          NavigationRailMainScreen(
            listNavigationLabelIcon: listNavigationLabelIcon,
            navDrawerIndex: navDrawerIndex,
            onDestinationSelected: onDestinationSelected,
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
    );
  }
}

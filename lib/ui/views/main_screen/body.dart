/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/navigation_drawer_section.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return const SizedBox();
    }

    return const BodyLarge();
  }
}

class BodyLarge extends ConsumerWidget {
  const BodyLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: NavigationDrawerSection(),
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

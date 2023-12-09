/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Body extends ConsumerWidget {
  const Body({
    super.key,
    required this.navDrawerIndex,
    required this.listNavigationLabelIcon,
  });

  final int navDrawerIndex;
  final List<(String, IconData)> listNavigationLabelIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
    );
  }
}

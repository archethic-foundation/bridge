/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/local_history/local_history_sheet.dart';
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/generic/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Header extends ConsumerWidget {
  const Header({
    this.withMenu = true,
    super.key,
  });

  final bool withMenu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexMenu = ref.watch(navigationIndexMainScreenProvider);

    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Image.asset(
          'assets/images/logo_crystal.png',
          height: 50,
        ),
        const SizedBox(
          width: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            'aeBridge',
            style: TextStyle(
              fontSize: 30,
              color: ArchethicThemeBase.blue200,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 20),
          child: Text(
            'Beta',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        if (withMenu && Responsive.isMobile(context) == false)
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: () {
                    ref.read(navigationIndexMainScreenProvider.notifier).state =
                        0;
                    ref
                        .read(
                          MainScreenWidgetDisplayedProviders
                              .mainScreenWidgetDisplayedProvider.notifier,
                        )
                        .setWidget(const BridgeSheet(), ref);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.menu_bridge,
                    style: TextStyle(
                      fontSize: 16,
                      color: indexMenu == 0
                          ? ArchethicThemeBase.blue50
                          : ArchethicThemeBase.blue200,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: () {
                    ref.read(navigationIndexMainScreenProvider.notifier).state =
                        1;
                    ref
                        .read(
                          MainScreenWidgetDisplayedProviders
                              .mainScreenWidgetDisplayedProvider.notifier,
                        )
                        .setWidget(const LocalHistorySheet(), ref);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.menu_local_history,
                    style: TextStyle(
                      fontSize: 16,
                      color: indexMenu == 1
                          ? ArchethicThemeBase.blue50
                          : ArchethicThemeBase.blue200,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: () {
                    ref.read(navigationIndexMainScreenProvider.notifier).state =
                        2;
                    ref
                        .read(
                          MainScreenWidgetDisplayedProviders
                              .mainScreenWidgetDisplayedProvider.notifier,
                        )
                        .setWidget(const RefundSheet(), ref);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.menu_refund,
                    style: TextStyle(
                      fontSize: 16,
                      color: indexMenu == 2
                          ? ArchethicThemeBase.blue50
                          : ArchethicThemeBase.blue200,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

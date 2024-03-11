/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/local_history/local_history_sheet.dart';
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
        SvgPicture.asset(
          'assets/images/AELogo.svg',
          height: 34,
        ),
        const SizedBox(
          width: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: SelectableText(
            'aeBridge',
            style: TextStyle(
              fontSize: 33,
              color: aedappfm.ArchethicThemeBase.neutral0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 26),
          child: SelectableText(
            'Beta',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        if (withMenu &&
            aedappfm.Responsive.isMobile(context) == false &&
            aedappfm.Responsive.isTablet(context) == false)
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.go(
                          BridgeSheet.routerPage,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.menu_bridge,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == NavigationIndex.bridge
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : aedappfm.ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 60,
                      color: indexMenu == NavigationIndex.bridge
                          ? aedappfm.ArchethicThemeBase.raspberry200
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.go(
                          LocalHistorySheet.routerPage,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.menu_local_history,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == NavigationIndex.localHistory
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : aedappfm.ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 110,
                      color: indexMenu == NavigationIndex.localHistory
                          ? aedappfm.ArchethicThemeBase.raspberry200
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.go(
                          RefundSheet.routerPage,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.menu_refund,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == NavigationIndex.refund
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : aedappfm.ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 60,
                      color: indexMenu == NavigationIndex.refund
                          ? aedappfm.ArchethicThemeBase.raspberry200
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}

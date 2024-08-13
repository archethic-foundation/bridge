import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends ConsumerWidget {
  const Header({
    this.withMenu = true,
    super.key,
  });

  final bool withMenu;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexMenu = ref.watch(navigationIndexMainScreenProvider);
    final session = ref.watch(SessionProviders.session);
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        if (aedappfm.Responsive.isMobile(context) == false)
          SvgPicture.asset(
            'assets/images/AELogo.svg',
            height: 34,
          )
        else
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SvgPicture.asset(
              'assets/images/AELogo.svg',
              height: 24,
            ),
          ),
        if (aedappfm.Responsive.isMobile(context) == false)
          const SizedBox(
            width: 8,
          ),
        if (aedappfm.Responsive.isMobile(context) == false)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: SelectableText(
              'aeBridge',
              style: TextStyle(
                fontSize: aedappfm.Responsive.fontSizeFromValue(
                  context,
                  desktopValue: 33,
                ),
                color: aedappfm.ArchethicThemeBase.neutral0,
              ),
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
                      onPressed: () async {
                        await launchUrl(
                          Uri.parse(
                            (Uri.base
                                    .toString()
                                    .toLowerCase()
                                    .contains('bridge.archethic'))
                                ? 'https://swap.archethic.net/swap'
                                : 'https://swap.testnet.archethic.net/swap',
                          ),
                          webOnlyWindowName: '_self',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.menu_swap,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == NavigationIndex.swap
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : aedappfm.ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 70,
                      color: indexMenu == NavigationIndex.swap
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
                      onPressed: () async {
                        await launchUrl(
                          Uri.parse(
                            (Uri.base
                                    .toString()
                                    .toLowerCase()
                                    .contains('bridge.archethic'))
                                ? 'https://swap.archethic.net/poolList'
                                : 'https://swap.testnet.archethic.net/poolList',
                          ),
                          webOnlyWindowName: '_self',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.menu_liquidity,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == NavigationIndex.pool
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : aedappfm.ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 90,
                      color: indexMenu == NavigationIndex.pool
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
                      onPressed: () async {
                        await launchUrl(
                          Uri.parse(
                            (Uri.base
                                    .toString()
                                    .toLowerCase()
                                    .contains('bridge.archethic'))
                                ? 'https://swap.archethic.net/earn'
                                : 'https://swap.testnet.archethic.net/earn',
                          ),
                          webOnlyWindowName: '_self',
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.menu_earn,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: indexMenu == NavigationIndex.earn
                              ? aedappfm.ArchethicThemeBase.raspberry200
                              : aedappfm.ArchethicThemeBase.neutral0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 0.5,
                      width: 70,
                      color: indexMenu == NavigationIndex.earn
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
                        context.go(BridgeSheet.routerPage);
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
                      width: 70,
                      color: indexMenu == NavigationIndex.bridge
                          ? aedappfm.ArchethicThemeBase.raspberry200
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
              if (((session.walletFrom != null &&
                          session.walletFrom!.wallet == kArchethicWallet &&
                          session.walletFrom!.isConnected == true) ||
                      (session.walletTo != null &&
                          session.walletTo!.wallet == kArchethicWallet &&
                          session.walletTo!.isConnected == true)) ==
                  false)
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            aedappfm.ArchethicThemeBase.blue600
                                .withOpacity(0.7),
                          ),
                        ),
                        onPressed: () async {
                          await launchUrl(
                            Uri.parse(
                              'https://www.archethic.net/wallet.html',
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.menu_get_wallet,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: indexMenu == NavigationIndex.getWallet
                                ? aedappfm.ArchethicThemeBase.raspberry200
                                : aedappfm.ArchethicThemeBase.neutral0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 0.5,
                        width: 70,
                        color: indexMenu == NavigationIndex.getWallet
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

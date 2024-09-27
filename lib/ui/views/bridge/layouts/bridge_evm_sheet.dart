import 'dart:ui';

import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/main_screen/layouts/app_bar.dart';
import 'package:aebridge/ui/views/main_screen/layouts/bottom_navigation_bar.dart';
import 'package:aebridge/ui/views/main_screen/layouts/browser_popup.dart';
import 'package:aebridge/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aebridge/util/browser_util_web.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BridgeEVMSheet extends ConsumerStatefulWidget {
  const BridgeEVMSheet({
    super.key,
  });

  static const routerPage = 'evm';
  static const navPage = '/bridge/evm';

  @override
  ConsumerState<BridgeEVMSheet> createState() => _BridgeEVMSheetState();
}

class _BridgeEVMSheetState extends ConsumerState<BridgeEVMSheet> {
  List<(String, IconData)> listNavigationLabelIcon = [];

  @override
  void initState() {
    super.initState();

    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const BrowserPopup();
          },
        );
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    listNavigationLabelIcon = [
      (
        AppLocalizations.of(context)!.menu_swap,
        aedappfm.Iconsax.arrange_circle_2
      ),
      (
        AppLocalizations.of(context)!.menu_liquidity,
        aedappfm.Iconsax.wallet_money
      ),
      (AppLocalizations.of(context)!.menu_earn, aedappfm.Iconsax.wallet_add),
      (
        AppLocalizations.of(context)!.menu_bridge,
        aedappfm.Iconsax.recovery_convert
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      title: 'aeBridge - Bridge Archethic blockchain',
      color: Colors.black,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: aedappfm.AppThemeBase.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const AppBarMainScreen(),
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            const aedappfm.AppBackground(
              backgroundImage: 'assets/images/background-welcome.png',
            ),
            Align(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.bridgeEVMHeaderText,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .bridgeWormholeHeaderDesc,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: 650,
                            decoration: BoxDecoration(
                              color: aedappfm.AppThemeBase.sheetBackground,
                              border: Border.all(
                                color: aedappfm.AppThemeBase.sheetBorder,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 30,
                                right: 30,
                                top: 11,
                                bottom: 5,
                              ),
                              child: LayoutBuilder(
                                builder: (context, constraint) {
                                  return aedappfm.ArchethicScrollbar(
                                    child: Container(
                                      constraints: BoxConstraints(
                                        minHeight: 100,
                                        maxHeight: constraint.maxHeight,
                                      ),
                                      child: IntrinsicHeight(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 630,
                                              width: 630,
                                              child: EasyWebView(
                                                // TODO: To manage
                                                src:
                                                    'https://bridge.testnet.archethic.net/bridge-evm.html',
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 10, bottom: 30),
                        child: InkWell(
                          onTap: () async {
                            context.go(BridgeSheet.routerPage);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.backToAEBridge,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontSize,
                              color: aedappfm.AppThemeBase.secondaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
                .animate()
                .fade(
                  duration: const Duration(milliseconds: 200),
                )
                .scale(
                  duration: const Duration(milliseconds: 200),
                ),
          ],
        ),
        bottomNavigationBar: aedappfm.Responsive.isMobile(context) ||
                aedappfm.Responsive.isTablet(context)
            ? BottomNavigationBarMainScreen(
                listNavigationLabelIcon: listNavigationLabelIcon,
                navDrawerIndex: ref.watch(navigationIndexMainScreenProvider),
              )
            : null,
      ),
    );
  }
}

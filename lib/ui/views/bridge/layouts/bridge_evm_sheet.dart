import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:aebridge/ui/views/main_screen/layouts/browser_popup.dart';
import 'package:aebridge/ui/views/main_screen/layouts/main_screen_list.dart';
import 'package:aebridge/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aebridge/util/browser_util_web.dart';
import 'package:aebridge/util/uri.util.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
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
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const BrowserPopup();
            },
          );
        }
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
  Widget build(
    BuildContext context,
  ) {
    if (mounted == false) {
      return const SizedBox.shrink();
    }
    return MainScreenList(
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: InkWell(
                onTap: () async {
                  context.go(BridgeSheet.routerPage);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: aedappfm.AppThemeBase.secondaryColor,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      AppLocalizations.of(context)!.backToAEBridge,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge!.fontSize,
                        color: aedappfm.AppThemeBase.secondaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: EasyWebView(
                src: '${UriUtil.getBaseUrl()}/bridge-evm.html',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

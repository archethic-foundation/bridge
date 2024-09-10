/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_evm_sheet.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_sheet.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_form_sheet.dart';
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aebridge/ui/views/main_screen/layouts/troubles_popup.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class BridgeSheet extends ConsumerStatefulWidget {
  const BridgeSheet({
    super.key,
    this.initialState,
  });

  final BridgeFormState? initialState;

  static const routerPage = '/bridge';

  @override
  ConsumerState<BridgeSheet> createState() => _BridgeSheetState();
}

class _BridgeSheetState extends ConsumerState<BridgeSheet> {
  late W3MService _w3mService;

  @override
  void initState() {
    initializeState();
    Future.delayed(Duration.zero, () async {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.bridge;

      if (widget.initialState != null) {
        ref.read(BridgeFormProvider.bridgeForm.notifier).currentState =
            widget.initialState!;
      }
    });

    super.initState();
  }

  Future<void> initializeState() async {
    _w3mService = W3MService(
      projectId: 'ce9ee3c8e58873e8708247895990bc27',
      metadata: const PairingMetadata(
        name: 'Web3Modal Flutter Example',
        description: 'Web3Modal Flutter Example',
        url: 'http://localhost:58667/bridge',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'w3m://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
      includedWalletIds: {
        'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96', // MetaMask
        '4622a2b2d6af1c9844944291e5e7351a6aa24cd7b23099efac1b2fd875da31a0', // Trust
        'fd20dc426fb37566d803205b19bbc1d4096b248ac04548e3cfb6b3a38bd033aa', // Coinbase Wallet
      },
    );

    // Register callbacks on the Web3App you'd like to use. See `Events` section.
    await _w3mService.init();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep: ref.watch(BridgeFormProvider.bridgeForm).processStep,
      formSheet: BridgeFormSheet(w3mService: _w3mService),
      confirmSheet: const BridgeConfirmSheet(),
      topWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.bridgeHeaderText,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.bridgeHeaderDesc,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      bottomWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const TroublesPopup();
                },
              );
            },
            child: Text(
              AppLocalizations.of(context)!.havingTrouble,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                color: aedappfm.AppThemeBase.secondaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const aedappfm.ArchethicOracleUco(
            faqLink:
                'https://wiki.archethic.net/FAQ/bridge-2-ways#how-is-the-price-of-uco-estimated',
          ),
        ],
      ),
      afterBottomWidget: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 10),
            child: InkWell(
              onTap: () async {
                context.go(BridgeEVMSheet.navPage);
              },
              child: Text(
                AppLocalizations.of(context)!.goToEVMBridge,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  color: aedappfm.AppThemeBase.secondaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

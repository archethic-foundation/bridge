/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/app_embedded.dart';
import 'package:aebridge/application/app_mobile_format.dart';
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
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.bridge;

      if (widget.initialState != null) {
        ref.read(bridgeFormNotifierProvider.notifier).currentState =
            widget.initialState!;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isAppMobileFormat = ref.watch(isAppMobileFormatProvider(context));
    final isAppEmbedded = ref.watch(isAppEmbeddedProvider);
    final processStep = ref.watch(bridgeFormNotifierProvider).processStep;

    return MainScreenSheet(
      currentStep: processStep,
      formSheet: const BridgeFormSheet(),
      confirmSheet: const BridgeConfirmSheet(),
      topWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isAppEmbedded == false)
              Text(
                AppLocalizations.of(context)!.bridgeHeaderText,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            if (isAppMobileFormat == false)
              const SizedBox(
                height: 10,
              ),
            if (isAppMobileFormat == false ||
                (isAppMobileFormat && processStep == aedappfm.ProcessStep.form))
              Text(
                AppLocalizations.of(context)!.bridgeHeaderDesc,
                style: isAppMobileFormat
                    ? Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: aedappfm.AppThemeBase.secondaryColor,
                        )
                    : Theme.of(context).textTheme.labelLarge,
              ),
            if (isAppMobileFormat == false)
              const SizedBox(
                height: 30,
              ),
          ],
        ),
      ),
      bottomWidget: isAppMobileFormat
          ? processStep == aedappfm.ProcessStep.form
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize,
                          color: aedappfm.AppThemeBase.secondaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const aedappfm.ArchethicOracleUco(
                      faqLink:
                          'https://wiki.archethic.net/FAQ/bridge-2-ways#how-is-the-price-of-uco-estimated',
                      precision: 4,
                    ),
                  ],
                )
              : const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    aedappfm.ArchethicOracleUco(
                      faqLink:
                          'https://wiki.archethic.net/FAQ/bridge-2-ways#how-is-the-price-of-uco-estimated',
                      precision: 4,
                    ),
                  ],
                )
          : Row(
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
                      fontSize:
                          Theme.of(context).textTheme.labelSmall!.fontSize,
                      color: aedappfm.AppThemeBase.secondaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const aedappfm.ArchethicOracleUco(
                  faqLink:
                      'https://wiki.archethic.net/FAQ/bridge-2-ways#how-is-the-price-of-uco-estimated',
                  precision: 4,
                ),
              ],
            ),
      afterBottomWidget: processStep == aedappfm.ProcessStep.confirmation &&
              isAppMobileFormat
          ? null
          : Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    top: 10,
                    bottom: isAppMobileFormat ? 30 : 0,
                  ),
                  child: InkWell(
                    onTap: () async {
                      context.go(BridgeEVMSheet.navPage);
                    },
                    child: Text(
                      textAlign: isAppMobileFormat ? TextAlign.center : null,
                      AppLocalizations.of(context)!.goToEVMBridge,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.bodyLarge!.fontSize,
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

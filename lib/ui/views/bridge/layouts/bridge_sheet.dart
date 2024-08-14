/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
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
    Future.delayed(Duration.zero, () {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.bridge;

      if (widget.initialState != null) {
        ref.read(BridgeFormProvider.bridgeForm.notifier).currentState =
            widget.initialState!;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep: ref.watch(BridgeFormProvider.bridgeForm).processStep,
      formSheet: const BridgeFormSheet(),
      confirmSheet: const BridgeConfirmSheet(),
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
    );
  }
}

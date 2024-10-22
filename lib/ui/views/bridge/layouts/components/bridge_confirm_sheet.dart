/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/app_mobile_format.dart';
import 'package:aebridge/ui/util/components/blockchain_label.dart';
import 'package:aebridge/ui/util/components/fiat_value.dart';
import 'package:aebridge/ui/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/util/components/format_address_link_copy_big_icon.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_sheet_fees.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_in_progress_popup.dart';
import 'package:aebridge/ui/views/util/consent_uri.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeConfirmSheet extends ConsumerStatefulWidget {
  const BridgeConfirmSheet({super.key});

  @override
  ConsumerState<BridgeConfirmSheet> createState() => BridgeConfirmSheetState();
}

class BridgeConfirmSheetState extends ConsumerState<BridgeConfirmSheet> {
  bool consentChecked = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    final bridge = ref.watch(bridgeFormNotifierProvider);
    if (bridge.blockchainFrom == null) {
      return const SizedBox.shrink();
    }
    final isAppMobileFormat = ref.watch(isAppMobileFormatProvider(context));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        aedappfm.ButtonConfirmBack(
          title: AppLocalizations.of(context)!.bridgeConfirmTitle,
          onPressed: bridge.tokenToBridge == null
              ? null
              : () {
                  ref.read(bridgeFormNotifierProvider.notifier)
                    ..setBridgeProcessStep(
                      AppLocalizations.of(context)!,
                      aedappfm.ProcessStep.form,
                    )
                    ..setMessageMaxHalfUCO(false);
                },
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              AppLocalizations.of(context)!.bridge_blockchain_from_lbl,
            ),
            const SizedBox(width: 8),
            BlockchainLabel(
              chainId: bridge.blockchainFrom!.chainId,
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              AppLocalizations.of(context)!.bridge_blockchain_to_lbl,
            ),
            const SizedBox(width: 8),
            BlockchainLabel(
              chainId: bridge.blockchainTo!.chainId,
            ),
          ],
        ),
        const SizedBox(height: 3),
        if (bridge.tokenToBridge != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectableText(
                AppLocalizations.of(context)!.bridge_token_amount_lbl,
              ),
              FutureBuilder<String>(
                future: FiatValue().display(
                  ref,
                  bridge.tokenToBridge!.symbol,
                  bridge.tokenToBridgeAmount,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SelectableText(
                      '${bridge.tokenToBridgeAmount.formatNumber(precision: 8)} ${bridge.tokenToBridge!.symbol} ${snapshot.data}',
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        const SizedBox(
          height: 3,
        ),
        if (bridge.targetAddress.isNotEmpty)
          if (isAppMobileFormat)
            Column(
              children: [
                SelectableText(
                  AppLocalizations.of(context)!.bridge_target_address_lbl,
                ),
                SizedBox(
                  height: 30,
                  child: FormatAddressLinkCopyBigIcon(
                    address: bridge.targetAddress,
                    chainId: bridge.blockchainTo!.chainId,
                    reduceAddress: true,
                    fontSize: 14,
                  ),
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SelectableText(
                    AppLocalizations.of(context)!.bridge_target_address_lbl,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                FormatAddressLinkCopy(
                  address: bridge.targetAddress,
                  chainId: bridge.blockchainTo!.chainId,
                  reduceAddress: true,
                ),
              ],
            ),
        const SizedBox(
          height: 10,
        ),
        const BridgeConfirmSheetFees(),
        if (bridge.messageMaxHalfUCO)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              child: aedappfm.InfoBanner(
                AppLocalizations.of(context)!.bridgeConfirmMessageMaxHalfUCO,
                aedappfm.InfoBannerType.request,
              ),
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        const Spacer(),
        if (bridge.consentDateTime == null)
          aedappfm.ConsentToCheck(
            consentChecked: consentChecked,
            onToggleConsent: (newValue) {
              setState(() {
                consentChecked = newValue!;
              });
            },
            uriPrivacyPolicy: kURIPrivacyPolicy,
            uriTermsOfUse: kURITermsOfUse,
          )
        else
          aedappfm.ConsentAlready(
            consentDateTime: bridge.consentDateTime!,
            uriPrivacyPolicy: kURIPrivacyPolicy,
            uriTermsOfUse: kURITermsOfUse,
          ),
        aedappfm.ButtonConfirm(
          labelBtn: AppLocalizations.of(context)!.btn_confirm_bridge,
          disabled: !consentChecked && bridge.consentDateTime == null,
          onPressed: () async {
            unawaited(
              ref
                  .read(bridgeFormNotifierProvider.notifier)
                  .bridge(AppLocalizations.of(context)!, ref),
            );

            if (!context.mounted) return;
            await BridgeInProgressPopup.getDialog(
              context,
              ref,
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

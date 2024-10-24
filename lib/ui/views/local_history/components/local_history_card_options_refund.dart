/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LocalHistoryCardOptionsRefund extends ConsumerWidget {
  const LocalHistoryCardOptionsRefund({
    required this.bridge,
    required this.isRefunded,
    super.key,
  });
  final BridgeFormState bridge;
  final bool isRefunded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepOk = bridge.blockchainFrom!.isArchethic ? 3 : 4;

    if (isRefunded == true ||
        bridge.failure == null ||
        bridge.currentStep < stepOk ||
        (bridge.htlcEVMAddress == null && bridge.htlcAEAddress == null) ||
        bridge.blockchainFrom == null) {
      return const SizedBox.shrink();
    }

    final isAppMobileFormat = aedappfm.Responsive.isMobile(context);

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () async {
          final helper = aedappfm.QueryParameterHelper();
          final htlcAddressEncoded = helper.encodeQueryParameter(
            bridge.blockchainFrom!.isArchethic == true
                ? bridge.htlcAEAddress!
                : bridge.htlcEVMAddress!,
          );
          final chainIdEncoded =
              helper.encodeQueryParameter(bridge.blockchainFrom!.chainId);
          await context.push(
            Uri(
              path: RefundSheet.routerPage,
              queryParameters: {
                'htlcAddress': htlcAddressEncoded,
                'chainId': chainIdEncoded,
              },
            ).toString(),
          );
        },
        child: Column(
          children: [
            aedappfm.IconAnimated(
              icon: aedappfm.Iconsax.empty_wallet_change,
              color: Colors.white,
              tooltip:
                  AppLocalizations.of(context)!.local_history_option_refund,
            ),
            if (isAppMobileFormat)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  AppLocalizations.of(context)!.local_history_option_refund,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

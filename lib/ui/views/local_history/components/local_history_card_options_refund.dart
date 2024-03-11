/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/contracts/evm_htlc.dart';
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
    super.key,
  });
  final BridgeFormState bridge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (bridge.failure == null ||
        bridge.htlcEVMAddress == null ||
        (bridge.blockchainFrom != null &&
            bridge.blockchainFrom!.isArchethic == true)) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<int>(
      future: EVMHTLC(
        bridge.blockchainFrom!.providerEndpoint,
        bridge.blockchainFrom!.htlcAddress!,
        bridge.blockchainFrom!.chainId,
      ).getStatus(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != 1 && snapshot.data != 2) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () {
                final helper = aedappfm.QueryParameterHelper();
                final htlcAddressEncoded = helper
                    .encodeQueryParameter(bridge.blockchainFrom!.htlcAddress!);
                context.go(
                  Uri(
                    path: RefundSheet.routerPage,
                    queryParameters: {
                      'htlcAddress': htlcAddressEncoded,
                    },
                  ).toString(),
                );
              },
              child: aedappfm.IconAnimated(
                icon: aedappfm.Iconsax.empty_wallet_change,
                color: Colors.white,
                tooltip:
                    AppLocalizations.of(context)!.local_history_option_refund,
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/main_screen_widget_displayed.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/refund/layouts/refund_sheet.dart';
import 'package:aebridge/ui/views/util/components/icon_animated.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {
          ref
              .read(
                MainScreenWidgetDisplayedProviders
                    .mainScreenWidgetDisplayedProvider.notifier,
              )
              .setWidget(
                RefundSheet(htlcAddress: bridge.htlcEVMAddress),
                ref,
              );
        },
        child: IconAnimated(
          icon: Iconsax.empty_wallet_change,
          color: Colors.white,
          tooltip: AppLocalizations.of(context)!.local_history_option_refund,
        ),
      ),
    );
  }
}

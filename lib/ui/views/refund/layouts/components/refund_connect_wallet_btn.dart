/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundConnectWalletButton extends ConsumerWidget {
  const RefundConnectWalletButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refund = ref.watch(RefundFormProvider.refundForm);

    if ((refund.wallet != null && refund.wallet!.isConnected) ||
        (refund.blockchain == null || refund.addressType == null)) {
      return const SizedBox.shrink();
    }
    return refund.addressType == AddressType.evm
        ? aedappfm.AppButton(
            labelBtn: AppLocalizations.of(context)!.btn_refund_evm_connect,
            onPressed: () async {
              await ref
                  .read(RefundFormProvider.refundForm.notifier)
                  .connectToEVMWallet(context);
            },
          )
        : aedappfm.AppButton(
            labelBtn:
                AppLocalizations.of(context)!.btn_refund_archethic_connect,
            onPressed: () async {
              await ref
                  .read(RefundFormProvider.refundForm.notifier)
                  .connectToArchethicWallet(context);
            },
          );
  }
}

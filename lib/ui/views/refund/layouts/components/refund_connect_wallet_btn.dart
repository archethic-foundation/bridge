/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
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

    if (refund.evmWallet != null && refund.evmWallet!.isConnected) {
      return const SizedBox.shrink();
    }

    return aedappfm.AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_refund_evm_connect,
      onPressed: () async {
        await ref
            .read(RefundFormProvider.refundForm.notifier)
            .connectToEVMWallet();
      },
    );
  }
}

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
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

    return AppButton(
      labelBtn: AppLocalizations.of(context)!.btn_refund_evm_connect,
      icon: Iconsax.empty_wallet,
      onPressed: () async {
        await ref
            .read(RefundFormProvider.refundForm.notifier)
            .connectToEVMWallet();
      },
    );
  }
}

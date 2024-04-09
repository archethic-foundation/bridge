import 'package:aebridge/ui/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundInfosWallet extends ConsumerWidget {
  const RefundInfosWallet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refund = ref.watch(RefundFormProvider.refundForm);
    if (refund.evmWallet == null || refund.processRefund == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (refund.chainId != null)
          Align(
            alignment: Alignment.centerRight,
            child: FormatAddressLinkCopy(
              header: 'Your EVM wallet address: ',
              address: refund.evmWallet!.nameAccount,
              chainId: refund.chainId!,
              reduceAddress: true,
            ),
          ),
        SelectableText(
          refund.processRefund == ProcessRefund.chargeable
              ? '${refund.evmWallet!.endpoint} to Archethic'
              : 'Archethic to ${refund.evmWallet!.endpoint}',
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: aedappfm.Responsive.fontSizeFromValue(
              context,
              desktopValue: 13,
            ),
          ),
        ),
      ],
    );
  }
}

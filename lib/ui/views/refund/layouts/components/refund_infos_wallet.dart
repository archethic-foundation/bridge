import 'package:aebridge/ui/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
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
    if (refund.wallet == null ||
        refund.processRefund == null ||
        refund.isAlreadyRefunded == true ||
        refund.isAlreadyWithdrawn == true ||
        refund.blockchainTo == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (refund.chainId != null)
          Align(
            alignment: Alignment.centerRight,
            child: FormatAddressLinkCopy(
              header: 'Your wallet address: ',
              address: refund.wallet!.genesisAddress,
              chainId: refund.chainId!,
              reduceAddress: true,
            ),
          ),
        SelectableText(
          '${refund.wallet!.endpoint} to ${refund.blockchainTo}',
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

import 'package:aebridge/ui/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundInfosWallet extends ConsumerWidget {
  const RefundInfosWallet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refund = ref.watch(RefundFormProvider.refundForm);
    if (refund.evmWallet == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (refund.chainId != null)
          Align(
            alignment: Alignment.centerRight,
            child: FormatAddressLinkCopy(
              address: refund.evmWallet!.nameAccount,
              chainId: refund.chainId!,
            ),
          ),
        SelectableText(
          refund.evmWallet!.endpoint,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}

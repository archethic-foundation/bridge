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
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          refund.evmWallet!.nameAccount,
          textAlign: TextAlign.end,
        ),
        Text(
          refund.evmWallet!.endpoint,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}

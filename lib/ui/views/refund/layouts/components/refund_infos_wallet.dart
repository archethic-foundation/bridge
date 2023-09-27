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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              refund.evmWallet!.nameAccount,
            ),
            Row(
              children: [
                Text(
                  refund.evmWallet!.endpoint,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

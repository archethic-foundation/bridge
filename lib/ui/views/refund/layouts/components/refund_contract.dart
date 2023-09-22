/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/format_address_link_copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundTransaction extends ConsumerWidget {
  const RefundTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refund = ref.watch(RefundFormProvider.refundForm);
    if (refund.refundTxAddress == null) {
      return const SizedBox(
        height: 20,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            '${AppLocalizations.of(context)!.refundTxAddressLbl}:',
          ),
          FormatAddressLinkCopy(
            address: refund.refundTxAddress!,
            chainId: refund.chainId ?? 0,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

import 'package:aebridge/ui/util/components/format_address_link_copy.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundInProgressUserExplorer extends ConsumerWidget {
  const RefundInProgressUserExplorer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refund = ref.watch(RefundFormProvider.refundForm);

    if (refund.addressType == AddressType.evm &&
        (refund.requestTooLong == true ||
            (refund.failure != null && refund.failure is aedappfm.Timeout))) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              children: [
                FormatAddressLinkCopy(
                  address: refund.wallet!.genesisAddress,
                  chainId: refund.chainId!,
                  reduceAddress: true,
                  typeAddress: TypeAddress.chain,
                  header: AppLocalizations.of(context)!
                      .goToExplorer
                      .replaceFirst('%1', refund.blockchainTo ?? ''),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return SizedBox.fromSize();
  }
}

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundInfo extends ConsumerWidget {
  const RefundInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          "Need help getting your funds back? Don't worry, we'll guide you!",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.labelLarge!,
                ),
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        SelectableText(
          "If your transfer didn't go as planned, or if you didn't complete all the necessary steps, you can get your funds back by using our refund function. Here's how it works:",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.labelMedium!,
                ),
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        SelectableText(
          'Identify and fill in the contract address: This is not the address of your wallet, but that of the contract that manages the transfer between blockchains. You need to provide this address to initiate the refund.',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.labelMedium!,
                ),
              ),
        ),
        SelectableText(
          "- If you're bridging from an EVM blockchain (such as Ethereum) to Archethic, use the EVM contract address.",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.labelMedium!,
                ),
              ),
        ),
        SelectableText(
          '- If you are bridging from Archethic to an EVM blockchain, use the Archethic contract address.',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.labelMedium!,
                ),
              ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

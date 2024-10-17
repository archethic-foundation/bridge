import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInterrupInfo extends ConsumerWidget {
  const BridgeInterrupInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(bridgeFormNotifierProvider);

    if (bridge.blockchainFrom == null) {
      return const SizedBox.shrink();
    }

    final htlcAddress = bridge.blockchainFrom!.isArchethic
        ? bridge.htlcAEAddress ?? ''
        : bridge.htlcEVMAddress ?? '';
    final stepOk = bridge.blockchainFrom!.isArchethic ? 3 : 4;

    if (htlcAddress.isEmpty ||
        bridge.isTransferInProgress == true ||
        bridge.failure == null ||
        bridge.currentStep < stepOk) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          AppLocalizations.of(context)!.bridgeInterrupInfoText1,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.labelMedium!,
                ),
              ),
        ),
        SelectableText(
          AppLocalizations.of(context)!.bridgeInterrupInfoText2,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.labelMedium!,
                ),
              ),
        ),
        SelectableText(
          AppLocalizations.of(context)!.bridgeInterrupInfoText3,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.labelMedium!,
                ),
              ),
        ),
        Row(
          children: [
            SelectableText(
              htlcAddress,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                      context,
                      Theme.of(context).textTheme.labelMedium!,
                    ),
                  ),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () {
                Clipboard.setData(
                  ClipboardData(text: htlcAddress),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor:
                        Theme.of(context).snackBarTheme.backgroundColor,
                    content: SelectableText(
                      AppLocalizations.of(context)!.addressCopied,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).textTheme.labelMedium!,
                            ),
                          ),
                    ),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: AppLocalizations.of(context)!.addressCopied,
                      onPressed: () {},
                    ),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Icon(
                  aedappfm.Iconsax.copy,
                  size: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
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
          AppLocalizations.of(context)!.refundInfoText1,
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
          AppLocalizations.of(context)!.refundInfoText2,
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
          AppLocalizations.of(context)!.refundInfoText3,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.labelMedium!,
                ),
              ),
        ),
        SelectableText(
          AppLocalizations.of(context)!.refundInfoText4,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                  context,
                  Theme.of(context).textTheme.labelMedium!,
                ),
              ),
        ),
        SelectableText(
          AppLocalizations.of(context)!.refundInfoText5,
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

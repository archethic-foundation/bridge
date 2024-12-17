import 'package:aebridge/ui/views/util/support_popup.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardOptionsSupport extends ConsumerWidget {
  const CardOptionsSupport({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: 70,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
            width: 0.5,
          ),
          gradient: aedappfm.AppThemeBase.gradientInputFormBackground,
        ),
        child: InkWell(
          onTap: () async {
            await SupportPopup.getDialog(
              context,
              ref,
            );
          },
          child: Column(
            children: [
              aedappfm.IconAnimated(
                icon: aedappfm.Iconsax.support,
                color: Colors.white,
                tooltip:
                    AppLocalizations.of(context)!.local_history_option_help,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  AppLocalizations.of(context)!.local_history_option_help,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

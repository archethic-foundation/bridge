import 'package:aebridge/application/app_mobile_format.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HTLCStatus extends ConsumerWidget {
  const HTLCStatus({
    required this.status,
    super.key,
  });

  final int? status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAppMobileFormat = ref.watch(isAppMobileFormatProvider(context));
    if (status == null) {
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (isAppMobileFormat)
            SelectableText(
              '${AppLocalizations.of(context)!.htlcStatusHeader}: ',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          else
            SelectableText(
              ' - ${AppLocalizations.of(context)!.htlcStatusHeader}: ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                      context,
                      Theme.of(context).textTheme.bodyMedium!,
                    ),
                  ),
            ),
          const SizedBox(
            height: 10,
            width: 10,
            child: CircularProgressIndicator(strokeWidth: 1),
          ),
        ],
      );
    }

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (isAppMobileFormat)
          SelectableText(
            '${AppLocalizations.of(context)!.htlcStatusHeader}: ',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        else
          SelectableText(
            ' - ${AppLocalizations.of(context)!.htlcStatusHeader}: ',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                    context,
                    Theme.of(context).textTheme.bodyMedium!,
                  ),
                ),
          ),
        SelectableText(
          _htlcStatusLabel(context, status),
          style: TextStyle(
            color: _htlcColor(status),
            fontSize: isAppMobileFormat
                ? Theme.of(context).textTheme.bodyMedium!.fontSize
                : Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                      fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                        context,
                        Theme.of(context).textTheme.bodyMedium!,
                      ),
                    )
                    .fontSize,
          ),
        ),
      ],
    );
  }

  Color _htlcColor(int? status) {
    switch (status) {
      case 0:
        return aedappfm.ArchethicThemeBase.systemWarning600;
      case 1:
        return aedappfm.ArchethicThemeBase.systemPositive500;
      case 2:
        return aedappfm.ArchethicThemeBase.systemPositive500;
      default:
        return aedappfm.ArchethicThemeBase.neutral0;
    }
  }

  String _htlcStatusLabel(BuildContext context, int? status) {
    if (status == null) {
      return AppLocalizations.of(context)!.htlcStatusLabelUnknown;
    }
    switch (status) {
      case 0:
        return AppLocalizations.of(context)!.htlcStatusLabelPending;
      case 1:
        return AppLocalizations.of(context)!.htlcStatusLabelWithdrawn;
      case 2:
        return AppLocalizations.of(context)!.htlcStatusLabelRefunded;
      default:
        return AppLocalizations.of(context)!.htlcStatusLabelUnknown;
    }
  }
}

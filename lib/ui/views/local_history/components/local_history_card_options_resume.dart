/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/bridge_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LocalHistoryCardOptionsResume extends ConsumerWidget {
  const LocalHistoryCardOptionsResume({
    required this.bridge,
    super.key,
  });
  final BridgeFormState bridge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (bridge.failure == null && bridge.currentStep == 8) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () async {
              try {
                final state = await ref
                    .read(BridgeFormProvider.bridgeForm.notifier)
                    .resume(bridge);
                if (!context.mounted) return;
                final helper = aedappfm.QueryParameterHelper();
                final initialStateEncoded = helper.encodeQueryParameter(state);
                context.go(
                  Uri(
                    path: BridgeSheet.routerPage,
                    queryParameters: {
                      'initialState': initialStateEncoded,
                    },
                  ).toString(),
                );
              } catch (exc) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor:
                        Theme.of(context).snackBarTheme.backgroundColor,
                    content: Text(
                      AppLocalizations.of(context)!
                          .anErrorOccurred(exc.toString()),
                      style: Theme.of(context)
                          .snackBarTheme
                          .contentTextStyle!
                          .copyWith(
                            fontSize: aedappfm.Responsive.fontSizeFromTextStyle(
                              context,
                              Theme.of(context).snackBarTheme.contentTextStyle!,
                            ),
                          ),
                    ),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: AppLocalizations.of(context)!.ok,
                      onPressed: () {},
                    ),
                  ),
                );
              }
            },
            child: aedappfm.IconAnimated(
              icon: aedappfm.Iconsax.play_circle,
              color: Colors.white,
              tooltip:
                  AppLocalizations.of(context)!.local_history_option_resume,
            ),
          ),
        ),
      ],
    );
  }
}

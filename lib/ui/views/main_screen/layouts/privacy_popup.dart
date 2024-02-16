import 'package:aebridge/application/preferences.dart';

import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyPopup extends ConsumerWidget {
  const PrivacyPopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent.withAlpha(120),
      body: AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          margin: const EdgeInsets.only(
            top: 30,
            right: 15,
            left: 8,
          ),
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: aedappfm.AppThemeBase.backgroundPopupColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
              ),
            ],
          ),
          child: aedappfm.ArchethicScrollbar(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SelectableText('Information - Testnet'),
                const SizedBox(height: 40),
                const SelectableText(
                  'During the testnet phase, Archethic collects logs, both functional and technical, to analyze anomalies in the Apps operation.',
                ),
                const SizedBox(height: 20),
                const SelectableText(
                  'These logs may contain information related to the transactions performed but do not in any way allow us to alter or interfere with the transactions. These logs do not contain sensitive information such as seed or private keys.',
                ),
                const SizedBox(height: 20),
                const Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'You can disable or activate logs when you want in the info menu ',
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.info_outlined,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                aedappfm.AppButton(
                  labelBtn: AppLocalizations.of(context)!.btn_understand,
                  onPressed: () async {
                    await ref
                        .read(
                          PreferencesProviders.preferencesRepository,
                        )
                        .setFirstConnection(false);
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

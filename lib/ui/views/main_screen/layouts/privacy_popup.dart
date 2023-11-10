import 'package:aebridge/application/preferences.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/app_button.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
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
            color: BridgeThemeBase.backgroundPopupColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Information - Testnet'),
              const SizedBox(height: 40),
              const Text(
                'During the testnet phase, Archethic collects logs, both functional and technical, to analyze anomalies in the Apps operation.',
              ),
              const SizedBox(height: 20),
              const Text(
                'These logs may contain information related to the transactions performed but do not in any way allow us to alter or interfere with the transactions. These logs do not contain sensitive information such as seed or private keys.',
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'You can disable or activate logs when you want in the info menu ',
                  ),
                  Icon(
                    Icons.info_outlined,
                    size: 14,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              AppButton(
                labelBtn: AppLocalizations.of(context)!.btn_understand,
                icon: Iconsax.close_square,
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
            ],
          ),
        ),
      ),
    );
  }
}

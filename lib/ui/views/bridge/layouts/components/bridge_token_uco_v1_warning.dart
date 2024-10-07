import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class BridgeUCOV1Warning extends ConsumerWidget {
  const BridgeUCOV1Warning({
    super.key,
  });
  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(bridgeFormNotifierProvider);

    if (bridge.tokenToBridge == null ||
        bridge.tokenToBridge!.ucoV1Address.isEmpty ||
        bridge.ucoV1Balance < 10e-8) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        children: [
          BlockInfo(
            width: aedappfm.AppThemeBase.sizeBoxComponentWidth,
            height: 200,
            info: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  'Migration required',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: aedappfm.ArchethicThemeBase.systemWarning500,
                      ),
                ),
                const SizedBox(height: 10),
                const SelectableText(
                  'We have detected that you hold UCO V1 tokens. To continue using your tokens securely and benefit from the new features, you need to migrate to UCO V2.',
                ),
                const SizedBox(height: 10),
                const SelectableText(
                  'To migrate your UCO V1 tokens to UCO V2, please use the migration tool below. You will receive a 1:1 ratio for your tokens.',
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          _launchURL('https://migration-uco.archethic.net'),
                      child: const Text('Go to the migration tool'),
                    ),
                    ElevatedButton(
                      onPressed: () => _launchURL(
                        'https://wiki.archethic.net/FAQ/migration-erc-token',
                      ),
                      child: const Text('More information'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

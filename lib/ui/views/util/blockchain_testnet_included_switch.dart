/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge_blockchain_selection/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlockchainTestnetIncludedSwitch extends ConsumerWidget {
  const BlockchainTestnetIncludedSwitch({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final blockchainSelectionNotifier = ref.watch(
      blockchainSelectionFormNotifierProvider.notifier,
    );

    final blockchainSelectionProvider =
        ref.watch(blockchainSelectionFormNotifierProvider);
    if (blockchainSelectionProvider is AsyncLoading) {
      return const CircularProgressIndicator();
    } else if (blockchainSelectionProvider is AsyncError) {
      return Text('Error: ${blockchainSelectionProvider.error}');
    }

    final blockchainSelectionData = blockchainSelectionProvider.valueOrNull;

    if (blockchainSelectionData != null &&
        blockchainSelectionData.isTestnetIncludedComponentDisplayed == false) {
      return const SizedBox.shrink();
    }

    final testnetIncluded = blockchainSelectionData?.testnetIncluded ?? false;

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: AppLocalizations.of(context)!
                  .blockchain_selection_test_included_lbl,
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                padding: const EdgeInsets.only(left: 2),
                height: 30,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return const Icon(Icons.check);
                        }
                        return const Icon(Icons.close);
                      },
                    ),
                    value: testnetIncluded,
                    onChanged: blockchainSelectionNotifier.setTestnetIncluded,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

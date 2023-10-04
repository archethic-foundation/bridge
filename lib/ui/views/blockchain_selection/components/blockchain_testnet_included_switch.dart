/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/blockchain_selection/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlockchainTestnetIncludedSwitch extends ConsumerStatefulWidget {
  const BlockchainTestnetIncludedSwitch({
    super.key,
  });

  @override
  ConsumerState<BlockchainTestnetIncludedSwitch> createState() =>
      _BlockchainTestnetIncludedSwitchState();
}

class _BlockchainTestnetIncludedSwitchState
    extends ConsumerState<BlockchainTestnetIncludedSwitch> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final blockchainSelectionNotifier = ref.watch(
      BlockchainSelectionFormProvider.blockchainSelectionForm.notifier,
    );

    final blockchainSelectionProvider =
        ref.watch(BlockchainSelectionFormProvider.blockchainSelectionForm);
    final thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );

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
                    thumbIcon: thumbIcon,
                    value: blockchainSelectionProvider.testnetIncluded,
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

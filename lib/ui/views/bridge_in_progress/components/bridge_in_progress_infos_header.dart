/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressInfosHeader extends ConsumerWidget {
  const BridgeInProgressInfosHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.isTransferInProgress) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.bridgeInProgressInfo1,
          ),
          Text(
            AppLocalizations.of(context)!.bridgeInProgressInfo2,
          ),
        ],
      );
    }

    return const SizedBox(height: 40);
  }
}

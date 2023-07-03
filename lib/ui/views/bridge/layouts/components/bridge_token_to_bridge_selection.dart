/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class BridgeTokenToBridgeSelection extends ConsumerWidget {
  const BridgeTokenToBridgeSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    return Container(
      width: 150,
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.4),
            Colors.white.withOpacity(0.1),
          ],
          stops: const [0, 1],
        ),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.4),
              Colors.white.withOpacity(0.1),
            ],
            stops: const [0, 1],
          ),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () async {
          /*    final token = await TokenSelectionPopup.getDialog(
            context,
          );
          if (token == null) return;
          ref
              .watch(BridgeFormProvider.bridgeForm.notifier)
              .setTokenToBridge(token);*/
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                if (bridge.tokenToBridge == null)
                  Text(
                    AppLocalizations.of(context)!.btn_selectToken,
                  )
                else
                  Text(bridge.tokenToBridge!.name)
              ],
            ),
            const Icon(
              Iconsax.search_normal,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}

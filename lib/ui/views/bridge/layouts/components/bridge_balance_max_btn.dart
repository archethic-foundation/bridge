/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeBalanceMaxButton extends ConsumerWidget {
  const BridgeBalanceMaxButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    // TODO(reddwarf03): Change the condition
    if (bridge.tokenToBridgeBalance > 0) {
      return const SizedBox();
    }

    return InkWell(
      onTap: () {},
      child: Text(
        AppLocalizations.of(context)!.btn_max,
        style: TextStyle(color: ThemeBase.maxButtonColor),
      )
          .animate()
          .fade(
            duration: const Duration(milliseconds: 500),
          )
          .scale(
            duration: const Duration(milliseconds: 500),
          ),
    );
  }
}

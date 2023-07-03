/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeTokenToBridgeBalance extends ConsumerWidget {
  const BridgeTokenToBridgeBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    return Text(
      '${AppLocalizations.of(context)!.balance_title_infos} ${bridge.tokenToBridgeBalance.toString().replaceAll(RegExp(r"0*$"), "").replaceAll(RegExp(r"\.$"), "")}',
    );
  }
}

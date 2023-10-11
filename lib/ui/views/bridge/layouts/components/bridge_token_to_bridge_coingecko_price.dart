/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BridgeTokenToBridgeCoingeckoPrice extends ConsumerWidget {
  const BridgeTokenToBridgeCoingeckoPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.newBridgeForm);

    if (bridge.tokenToBridge == null ||
        bridge.tokenToBridge!.symbol == 'UCO' ||
        bridge.coingeckoPrice == 0) {
      return const SizedBox();
    }

    final timestamp = DateFormat.yMMMEd(
      Localizations.localeOf(context).languageCode,
    ).add_Hm().format(
          DateTime.now(),
        );

    return Text(
      '1 ${bridge.tokenToBridge!.symbol} = \$${bridge.coingeckoPrice} ($timestamp)',
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
      ),
    );
  }
}

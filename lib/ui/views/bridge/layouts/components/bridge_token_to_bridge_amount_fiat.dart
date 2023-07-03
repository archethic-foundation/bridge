/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeTokenToBridgeAmountFiat extends ConsumerWidget {
  const BridgeTokenToBridgeAmountFiat({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    return Text('\$${bridge.tokenToBridgeAmountFiat.toStringAsFixed(2)}');
  }
}

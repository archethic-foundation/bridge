/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/info_banner.dart';
import 'package:aebridge/ui/views/util/failure_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeInProgressError extends ConsumerWidget {
  const BridgeInProgressError({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.failure == null) {
      return const SizedBox(
        height: 40,
      );
    }

    return InfoBanner(
      FailureMessage(
        context: context,
        failure: bridge.failure,
      ).getMessage(),
      width: MediaQuery.of(context).size.width * 0.9,
      error: true,
    );
  }
}

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/util/failure_message.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeErrorMessage extends ConsumerWidget {
  const BridgeErrorMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.failure == null) {
      return const SizedBox(
        height: 10,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 40,
        child: aedappfm.InfoBanner(
          FailureMessage(
            context: context,
            failure: bridge.failure,
          ).getMessage(),
          aedappfm.InfoBannerType.error,
        ),
      ),
    );
  }
}

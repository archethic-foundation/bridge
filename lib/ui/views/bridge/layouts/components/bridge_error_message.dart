/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/info_banner.dart';
import 'package:aebridge/ui/views/util/failure_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeErrorMessage extends ConsumerWidget {
  const BridgeErrorMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.newBridgeForm);
    if (bridge.failure == null) {
      return const SizedBox(height: 40);
    }

    return SizedBox(
      height: 40,
      child: InfoBanner(
        FailureMessage(
          context: context,
          failure: bridge.failure,
        ).getMessage(),
        InfoBannerType.error,
      ),
    );
  }
}

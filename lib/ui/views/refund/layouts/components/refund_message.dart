/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/util/components/info_banner.dart';
import 'package:aebridge/ui/views/util/failure_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundMessage extends ConsumerWidget {
  const RefundMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refund = ref.watch(RefundFormProvider.refundForm);
    if (refund.refundOk) {
      return const SizedBox(
        height: 40,
        child: InfoBanner(
          'The refund has been performed successfully',
          InfoBannerType.success,
        ),
      );
    }

    if (refund.isAlwaysRefunded != null && refund.isAlwaysRefunded == true) {
      return SizedBox(
        height: 40,
        child: InfoBanner(
          FailureMessage(
            context: context,
            failure: const Failure.other(
              cause: 'This contract has already been refunded',
            ),
          ).getMessage(),
          InfoBannerType.request,
        ),
      );
    }

    if (refund.failure == null) {
      return const SizedBox(height: 40);
    }

    return SizedBox(
      height: 40,
      child: InfoBanner(
        FailureMessage(
          context: context,
          failure: refund.failure,
        ).getMessage(),
        InfoBannerType.error,
      ),
    );
  }
}
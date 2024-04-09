/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/util/failure_message.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundMessage extends ConsumerWidget {
  const RefundMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refund = ref.watch(RefundFormProvider.refundForm);

    if (refund.refundOk) {
      return aedappfm.InfoBanner(
        AppLocalizations.of(context)!.refundSuccessInfo,
        aedappfm.InfoBannerType.success,
      );
    }

    if (refund.isAlreadyRefunded != null && refund.isAlreadyRefunded == true) {
      return aedappfm.InfoBanner(
        FailureMessage(
          context: context,
          failure: aedappfm.Failure.other(
            cause: AppLocalizations.of(context)!.refundAlreadyDoneInfo,
          ),
        ).getMessage(),
        aedappfm.InfoBannerType.request,
      );
    }

    if (refund.isAlreadyWithdrawn != null &&
        refund.isAlreadyWithdrawn == true) {
      return aedappfm.InfoBanner(
        FailureMessage(
          context: context,
          failure: aedappfm.Failure.other(
            cause: AppLocalizations.of(context)!.refundAlreadyWithdrawnInfo,
          ),
        ).getMessage(),
        aedappfm.InfoBannerType.request,
      );
    }

    if (refund.failure == null) {
      return const SizedBox.shrink();
    }

    return aedappfm.InfoBanner(
      FailureMessage(
        context: context,
        failure: refund.failure,
      ).getMessage(),
      aedappfm.InfoBannerType.error,
    );
  }
}

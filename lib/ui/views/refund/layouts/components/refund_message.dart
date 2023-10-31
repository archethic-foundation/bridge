/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:aebridge/ui/views/util/components/info_banner.dart';
import 'package:aebridge/ui/views/util/failure_message.dart';
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

    if (refund.walletConfirmation == WalletConfirmationRefund.evm) {
      return InfoBanner(
        AppLocalizations.of(context)!.bridgeInProgressConfirmEVMWallet,
        InfoBannerType.request,
        width: MediaQuery.of(context).size.width * 0.9,
      );
    }

    if (refund.refundOk) {
      return SizedBox(
        height: 40,
        child: InfoBanner(
          AppLocalizations.of(context)!.refundSuccessInfo,
          InfoBannerType.success,
        ),
      );
    }

    if (refund.isAlreadyRefunded != null && refund.isAlreadyRefunded == true) {
      return SizedBox(
        height: 40,
        child: InfoBanner(
          FailureMessage(
            context: context,
            failure: Failure.other(
              cause: AppLocalizations.of(context)!.refundAlreadyDoneInfo,
            ),
          ).getMessage(),
          InfoBannerType.request,
        ),
      );
    }

    if (refund.isAlreadyWithdrawn != null &&
        refund.isAlreadyWithdrawn == true) {
      return SizedBox(
        height: 40,
        child: InfoBanner(
          FailureMessage(
            context: context,
            failure: Failure.other(
              cause: AppLocalizations.of(context)!.refundAlreadyWithdrawnInfo,
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

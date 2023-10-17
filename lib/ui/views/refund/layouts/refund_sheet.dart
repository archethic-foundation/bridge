/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundSheet extends ConsumerWidget {
  const RefundSheet({
    this.htlcAddress,
    super.key,
  });

  final String? htlcAddress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        RefundFormProvider.initialRefundForm.overrideWithValue(
          RefundFormState(
            htlcAddress: htlcAddress ?? '',
          ),
        ),
      ],
      child: RefundFormSheet(htlcAddress: htlcAddress),
    );
  }
}

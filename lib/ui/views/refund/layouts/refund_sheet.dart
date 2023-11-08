/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_form_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundSheet extends ConsumerStatefulWidget {
  const RefundSheet({
    this.htlcAddress,
    super.key,
  });

  final String? htlcAddress;

  @override
  ConsumerState<RefundSheet> createState() => _RefundSheetState();
}

class _RefundSheetState extends ConsumerState<RefundSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (widget.htlcAddress != null && widget.htlcAddress!.isNotEmpty) {
        ref
            .read(RefundFormProvider.refundForm.notifier)
            .setContractAddress(widget.htlcAddress!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const RefundFormSheet();
  }
}

/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/main_screen/bloc/provider.dart';
import 'package:aebridge/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_form_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic-dapp-framework-flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundSheet extends ConsumerStatefulWidget {
  const RefundSheet({
    this.htlcAddress,
    super.key,
  });

  final String? htlcAddress;

  static const routerPage = '/refund';

  @override
  ConsumerState<RefundSheet> createState() => _RefundSheetState();
}

class _RefundSheetState extends ConsumerState<RefundSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(navigationIndexMainScreenProvider.notifier).state =
          NavigationIndex.refund;

      if (widget.htlcAddress != null && widget.htlcAddress!.isNotEmpty) {
        ref
            .read(RefundFormProvider.refundForm.notifier)
            .setContractAddress(widget.htlcAddress!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MainScreenSheet(
      currentStep: ProcessStep.form,
      formSheet: RefundFormSheet(),
      confirmSheet: SizedBox.shrink(),
      bottomWidget: SizedBox.shrink(),
    );
  }
}

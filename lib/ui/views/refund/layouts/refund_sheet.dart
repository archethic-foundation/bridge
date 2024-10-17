import 'package:aebridge/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_form_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RefundSheet extends ConsumerStatefulWidget {
  const RefundSheet({
    this.htlcAddress,
    this.chainId,
    super.key,
  });

  final String? htlcAddress;
  final int? chainId;

  static const routerPage = '/refund';

  @override
  ConsumerState<RefundSheet> createState() => _RefundSheetState();
}

class _RefundSheetState extends ConsumerState<RefundSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (widget.htlcAddress != null && widget.htlcAddress!.isNotEmpty) {
        await ref
            .read(RefundFormProvider.refundForm.notifier)
            .setContractAddress(context, widget.htlcAddress!);
      }
      if (widget.chainId != null && widget.chainId!.isNaN == false) {
        await ref
            .read(RefundFormProvider.refundForm.notifier)
            .setChainId(widget.chainId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenSheet(
      currentStep: aedappfm.ProcessStep.form,
      formSheet: const RefundFormSheet(),
      confirmSheet: const SizedBox.shrink(),
      bottomWidget: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                context.pop();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: aedappfm.AppThemeBase.secondaryColor,
                      size: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    AppLocalizations.of(context)!.backToBridge,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.labelMedium!.fontSize,
                      color: aedappfm.AppThemeBase.secondaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

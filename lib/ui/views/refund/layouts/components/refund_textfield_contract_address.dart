/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/refund/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundContractAddress extends ConsumerStatefulWidget {
  const RefundContractAddress({
    super.key,
  });

  @override
  ConsumerState<RefundContractAddress> createState() =>
      _RefundContractAddressState();
}

class _RefundContractAddressState extends ConsumerState<RefundContractAddress> {
  late TextEditingController addressController;
  late FocusNode addressFocusNode;

  @override
  void initState() {
    super.initState();
    addressFocusNode = FocusNode();
    _updateTextController();
  }

  @override
  void dispose() {
    addressFocusNode.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _updateTextController() {
    final refund = ref.read(RefundFormProvider.refundForm);
    addressController = TextEditingController(text: refund.htlcAddressFilled);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final refund = ref.watch(RefundFormProvider.refundForm);

    if (refund.htlcAddressFilled != addressController.text) {
      _updateTextController();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SelectableText(
            AppLocalizations.of(context)!.refund_contract_address_lbl,
          ),
        ),
        SizedBox(
          width: aedappfm.AppThemeBase.sizeBoxComponentWidth,
          child: Row(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              width: 0.5,
                            ),
                            gradient: aedappfm
                                .AppThemeBase.gradientInputFormBackground,
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontFamily: aedappfm.AppThemeBase.addressFont,
                              fontSize: aedappfm.Responsive.fontSizeFromValue(
                                context,
                                desktopValue: 14,
                              ),
                            ),
                            autocorrect: false,
                            controller: addressController,
                            onChanged: (text) async {
                              await ref
                                  .read(RefundFormProvider.refundForm.notifier)
                                  .setContractAddress(
                                    text,
                                  );
                            },
                            focusNode: addressFocusNode,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(68),
                            ],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}

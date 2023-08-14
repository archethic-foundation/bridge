/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_to_bridge_balance.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeTokenAmount extends ConsumerStatefulWidget {
  const BridgeTokenAmount({
    super.key,
  });

  @override
  ConsumerState<BridgeTokenAmount> createState() => _BridgeTokenAmountState();
}

class _BridgeTokenAmountState extends ConsumerState<BridgeTokenAmount> {
  late TextEditingController tokenAmountController;
  late FocusNode tokenAmountFocusNode;

  @override
  void initState() {
    super.initState();
    tokenAmountFocusNode = FocusNode();
    _updateAmountTextController();
  }

  void _updateAmountTextController() {
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    tokenAmountController = TextEditingController(
      text: bridge.tokenToBridgeAmount == 0
          ? ''
          : bridge.tokenToBridgeAmount.toString(),
    );
  }

  @override
  void dispose() {
    tokenAmountFocusNode.dispose();
    tokenAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    final bridgeNotifier = ref.watch(BridgeFormProvider.bridgeForm.notifier);
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    if (bridge.blockchainFrom == null ||
        bridge.blockchainFrom == null ||
        bridge.tokenToBridge == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.bridge_token_amount_lbl,
              ),
              //   const BridgeTokenToBridgeBalance(),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            SizedBox(
              width: ThemeBase.sizeBoxComponentWidth,
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
                                gradient: ThemeBase.gradientInputFormBackground,
                              ),
                              child: TextField(
                                style: textTheme.titleMedium,
                                autocorrect: false,
                                controller: tokenAmountController,
                                onChanged: (text) async {
                                  bridgeNotifier.setTokenToBridgeAmount(
                                    double.tryParse(text.replaceAll(' ', '')) ??
                                        0,
                                  );
                                },
                                focusNode: tokenAmountFocusNode,
                                textAlign: TextAlign.left,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                inputFormatters: <TextInputFormatter>[
                                  AmountTextInputFormatter(precision: 8),
                                  LengthLimitingTextInputFormatter(18),
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
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () async {
                  final bridgeNotifier =
                      ref.watch(BridgeFormProvider.bridgeForm.notifier);
                  await bridgeNotifier
                      .setTokenToBridgeAmount(bridge.tokenToBridgeBalance);
                  _updateAmountTextController();
                },
                child: Text(
                  AppLocalizations.of(context)!.btn_max,
                  style: TextStyle(color: ThemeBase.maxButtonColor),
                )
                    .animate()
                    .fade(
                      duration: const Duration(milliseconds: 500),
                    )
                    .scale(
                      duration: const Duration(milliseconds: 500),
                    ),
              ),
            ),
          ],
        )
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}

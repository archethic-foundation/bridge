/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/util/components/fiat_value.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    tokenAmountController = TextEditingController();
    tokenAmountController.value =
        aedappfm.AmountTextInputFormatter(precision: 8).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: bridge.tokenToBridgeAmount == 0
            ? ''
            : bridge.tokenToBridgeAmount
                .formatNumber(precision: 8)
                .replaceAll(',', ''),
      ),
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

    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    final textNum = double.tryParse(tokenAmountController.text);
    if (!(bridge.tokenToBridgeAmount != 0.0 ||
        tokenAmountController.text == '' ||
        (textNum != null && textNum == 0))) {
      _updateAmountTextController();
    }

    if (bridge.blockchainFrom == null ||
        bridge.blockchainFrom == null ||
        bridge.tokenToBridge == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
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
                                style: textTheme.titleMedium!.copyWith(
                                  fontSize:
                                      aedappfm.Responsive.fontSizeFromTextStyle(
                                    context,
                                    Theme.of(context).textTheme.titleMedium!,
                                  ),
                                ),
                                autocorrect: false,
                                controller: tokenAmountController,
                                onChanged: (text) async {
                                  final bridgeNotifier = ref.read(
                                    BridgeFormProvider.bridgeForm.notifier,
                                  );
                                  await bridgeNotifier.setTokenToBridgeAmount(
                                    double.tryParse(text.replaceAll(' ', '')) ??
                                        0,
                                  );
                                },
                                focusNode: tokenAmountFocusNode,
                                textAlign: TextAlign.left,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                inputFormatters: <TextInputFormatter>[
                                  aedappfm.AmountTextInputFormatter(
                                    precision: bridge.tokenToBridgeDecimals,
                                  ),
                                  LengthLimitingTextInputFormatter(
                                    bridge.tokenToBridgeBalance
                                            .formatNumber(precision: 0)
                                            .length +
                                        bridge.tokenToBridgeDecimals +
                                        1,
                                  ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 80,
                  padding: const EdgeInsets.only(right: 10),
                  child: aedappfm.ButtonHalf(
                    balanceAmount: bridge.tokenToBridgeBalance,
                    onTap: () async {
                      await ref
                          .read(BridgeFormProvider.bridgeForm.notifier)
                          .setMaxHalf();
                      _updateAmountTextController();
                    },
                  ),
                ),
                Container(
                  width: 80,
                  padding: const EdgeInsets.only(right: 10),
                  child: aedappfm.ButtonMax(
                    balanceAmount: bridge.tokenToBridgeBalance,
                    onTap: () async {
                      await ref
                          .read(BridgeFormProvider.bridgeForm.notifier)
                          .setMaxAmount();
                      _updateAmountTextController();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FutureBuilder<String>(
                future: FiatValue().display(
                  ref,
                  bridge.tokenToBridge!.symbol,
                  bridge.tokenToBridgeAmount,
                  withParenthesis: false,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: SelectableText(
                        '${snapshot.data}',
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}

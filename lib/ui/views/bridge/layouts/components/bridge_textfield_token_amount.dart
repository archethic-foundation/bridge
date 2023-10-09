/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/fiat_value.dart';
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
    tokenAmountController = TextEditingController();
    tokenAmountController.value =
        AmountTextInputFormatter(precision: 8).formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(
        text: bridge.tokenToBridgeAmount == 0
            ? ''
            : bridge.tokenToBridgeAmount.toString(),
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
    if (!(bridge.tokenToBridgeAmount != 0.0 ||
        (tokenAmountController.text == '' ||
            tokenAmountController.text == '0'))) {
      _updateAmountTextController();
    }

    if (bridge.blockchainFrom == null ||
        bridge.blockchainFrom == null ||
        bridge.tokenToBridge == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            SizedBox(
              width: BridgeThemeBase.sizeBoxComponentWidth,
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
                                gradient:
                                    BridgeThemeBase.gradientInputFormBackground,
                              ),
                              child: TextField(
                                style: textTheme.titleMedium,
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
                  await ref
                      .read(BridgeFormProvider.bridgeForm.notifier)
                      .setMaxAmount();
                  _updateAmountTextController();
                },
                child: Text(
                  AppLocalizations.of(context)!.btn_max,
                  style: TextStyle(color: BridgeThemeBase.maxButtonColor),
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
        ),
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
                child: Text(
                  '${snapshot.data}',
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 300))
        .scale(duration: const Duration(milliseconds: 300));
  }
}

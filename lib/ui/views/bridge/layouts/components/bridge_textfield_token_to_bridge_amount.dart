/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/util/generic/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeTokenToBridgeAmount extends ConsumerStatefulWidget {
  const BridgeTokenToBridgeAmount({
    super.key,
  });

  @override
  ConsumerState<BridgeTokenToBridgeAmount> createState() =>
      _BridgeTokenToBridgeAmountState();
}

class _BridgeTokenToBridgeAmountState
    extends ConsumerState<BridgeTokenToBridgeAmount> {
  late TextEditingController tokenToBridgeAmountController;
  late FocusNode tokenToBridgeAmountFocusNode;

  @override
  void initState() {
    super.initState();
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    tokenToBridgeAmountFocusNode = FocusNode();
    tokenToBridgeAmountController =
        TextEditingController(text: bridge.tokenToBridgeAmount.toString());
  }

  @override
  void dispose() {
    tokenToBridgeAmountFocusNode.dispose();
    tokenToBridgeAmountController.dispose();
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

    return SizedBox(
      width: 400,
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
                          color: Theme.of(context).colorScheme.primaryContainer,
                          width: 0.5,
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(1),
                            Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.3),
                          ],
                          stops: const [0, 1],
                        ),
                      ),
                      child: TextField(
                        style: textTheme.titleLarge,
                        autocorrect: false,
                        controller: tokenToBridgeAmountController,
                        onChanged: (text) async {
                          bridgeNotifier.setTokenToBridgeAmount(
                            double.tryParse(text) ?? 0,
                          );
                        },
                        focusNode: tokenToBridgeAmountFocusNode,
                        textAlign: TextAlign.left,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          AmountTextInputFormatter(precision: 8),
                          LengthLimitingTextInputFormatter(10),
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
    );
  }
}

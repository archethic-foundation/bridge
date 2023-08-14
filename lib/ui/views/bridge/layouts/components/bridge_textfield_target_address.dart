/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/themes/theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeTargetAddress extends ConsumerStatefulWidget {
  const BridgeTargetAddress({
    super.key,
  });

  @override
  ConsumerState<BridgeTargetAddress> createState() =>
      _BridgeTargetAddressState();
}

class _BridgeTargetAddressState extends ConsumerState<BridgeTargetAddress> {
  late TextEditingController addressController;
  late FocusNode addressFocusNode;

  @override
  void initState() {
    super.initState();
    final bridge = ref.read(BridgeFormProvider.bridgeForm);
    addressFocusNode = FocusNode();
    addressController = TextEditingController(text: bridge.targetAddress);
  }

  @override
  void dispose() {
    addressFocusNode.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
          child: Text(
            AppLocalizations.of(context)!.bridge_target_address_lbl,
          ),
        ),
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
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                            ),
                            autocorrect: false,
                            controller: addressController,
                            onChanged: (text) async {
                              bridgeNotifier.setTargetAddress(
                                text,
                              );
                            },
                            focusNode: addressFocusNode,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              if (bridge.blockchainTo!.chainId < 0)
                                LengthLimitingTextInputFormatter(68)
                              else
                                LengthLimitingTextInputFormatter(42),
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

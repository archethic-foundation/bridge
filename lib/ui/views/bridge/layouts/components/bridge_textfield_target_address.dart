/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/app_mobile_format.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
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
    final bridge = ref.read(bridgeFormNotifierProvider);
    addressController = TextEditingController(text: bridge.targetAddress);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final bridge = ref.watch(bridgeFormNotifierProvider);
    final isAppMobileFormat = ref.watch(isAppMobileFormatProvider(context));

    if (bridge.targetAddress != addressController.text) {
      _updateTextController();
    }

    if (bridge.blockchainFrom == null ||
        bridge.blockchainTo == null ||
        bridge.tokenToBridge == null) {
      return const SizedBox.shrink();
    }

    final maxLines = bridge.blockchainTo!.isArchethic == true ? 2 : 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SelectableText(
            AppLocalizations.of(context)!.bridge_target_address_lbl,
            style: isAppMobileFormat
                ? Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: aedappfm.AppThemeBase.secondaryColor,
                    )
                : null,
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
                            maxLines: maxLines,
                            style: TextStyle(
                              fontFamily: aedappfm.AppThemeBase.addressFont,
                              fontSize: isAppMobileFormat
                                  ? 12
                                  : aedappfm.Responsive.fontSizeFromValue(
                                      context,
                                      desktopValue: 14,
                                    ),
                            ),
                            autocorrect: false,
                            controller: addressController,
                            onChanged: (text) async {
                              final bridgeNotifier = ref.read(
                                bridgeFormNotifierProvider.notifier,
                              );
                              await bridgeNotifier.setTargetAddress(
                                text,
                              );
                            },
                            focusNode: addressFocusNode,
                            textAlign: TextAlign.left,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              if (bridge.blockchainTo!.isArchethic)
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

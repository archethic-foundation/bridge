/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_sheet.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_form_sheet.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_to_bridge_archethic_oracle_uco.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class BridgeSheet extends ConsumerStatefulWidget {
  const BridgeSheet({
    super.key,
    this.initialState,
  });

  final BridgeFormState? initialState;

  @override
  ConsumerState<BridgeSheet> createState() => _BridgeSheetState();
}

class _BridgeSheetState extends ConsumerState<BridgeSheet> {
  @override
  void initState() {
    if (widget.initialState != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(BridgeFormProvider.bridgeForm.notifier).currentState =
            widget.initialState!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);

    debugPrint('bridgeSheet: ${bridge.bridgeProcessStep}');

    return Align(
      child: Container(
        width: 650,
        constraints: const BoxConstraints(minHeight: 400, maxHeight: 600),
        decoration: BoxDecoration(
          gradient: BridgeThemeBase.gradientSheetBackground,
          border: GradientBoxBorder(
            gradient: BridgeThemeBase.gradientSheetBorder,
          ),
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/background-sheet.png',
            ),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: ArchethicThemeBase.neutral900,
              blurRadius: 40,
              spreadRadius: 10,
              offset: const Offset(1, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 11,
            bottom: 5,
          ),
          child: LayoutBuilder(
            builder: (context, constraint) {
              return ArchethicScrollbar(
                child: Container(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        if (bridge.bridgeProcessStep == BridgeProcessStep.form)
                          const BridgeFormSheet()
                        else
                          const BridgeConfirmSheet(),
                        const BridgeTokenToBridgeArchethicOracleUco(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

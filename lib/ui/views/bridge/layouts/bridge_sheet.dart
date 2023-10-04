/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_sheet.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_form_sheet.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_to_bridge_archethic_oracle_uco.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_to_bridge_coingecko_price.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class BridgeSheet extends ConsumerWidget {
  const BridgeSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    debugPrint('bridgeSheet: ${bridge.bridgeProcessStep}');

    return Align(
      child: ArchethicScrollbar(
        child: Container(
          width: 650,
          height: 520,
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
          child: Stack(
            children: [
              const Positioned(
                bottom: 5,
                right: 15,
                child: BridgeTokenToBridgeArchethicOracleUco(),
              ),
              const Positioned(
                bottom: 35,
                right: 15,
                child: BridgeTokenToBridgeCoingeckoPrice(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 11,
                  bottom: 20,
                ),
                child: bridge.bridgeProcessStep == BridgeProcessStep.form
                    ? const BridgeFormSheet()
                    : const BridgeConfirmSheet(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

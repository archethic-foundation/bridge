/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_confirm_sheet.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_form_sheet.dart';
import 'package:aebridge/ui/views/bridge/layouts/components/bridge_token_to_bridge_archethic_oracle_uco.dart';
import 'package:aebridge/ui/views/main_screen/layouts/main_screen_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeSheet extends ConsumerStatefulWidget {
  const BridgeSheet({
    super.key,
    this.initialState,
  });

  final BridgeFormState? initialState;

  static const routerPage = '/bridge';

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
    return MainScreenSheet(
      currentStep: ref.watch(BridgeFormProvider.bridgeForm).processStep,
      formSheet: const BridgeFormSheet(),
      confirmSheet: const BridgeConfirmSheet(),
      bottomWidget: const BridgeTokenToBridgeArchethicOracleUco(),
    );
  }
}

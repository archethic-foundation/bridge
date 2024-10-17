import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchEVMContextPopup extends ConsumerWidget {
  const SwitchEVMContextPopup({
    super.key,
    required this.onEVMContextSwitched,
    required this.switchEVMContextDesc,
    required this.switchEVMContextBtnLabel,
  });

  final VoidCallback onEVMContextSwitched;
  final String switchEVMContextDesc;
  final String switchEVMContextBtnLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent.withAlpha(120),
      body: AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          margin: const EdgeInsets.only(
            top: 30,
            right: 15,
            left: 8,
          ),
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: aedappfm.AppThemeBase.backgroundPopupColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
              ),
            ],
          ),
          child: aedappfm.ArchethicScrollbar(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectableText(
                  AppLocalizations.of(context)!.switchNetworkTitle,
                ),
                const SizedBox(height: 40),
                SelectableText(
                  switchEVMContextDesc,
                ),
                const SizedBox(height: 40),
                aedappfm.AppButton(
                  labelBtn: switchEVMContextBtnLabel,
                  onPressed: () async {
                    onEVMContextSwitched();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

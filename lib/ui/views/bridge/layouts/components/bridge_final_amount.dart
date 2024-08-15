import 'dart:async';

import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeFinalAmount extends ConsumerStatefulWidget {
  const BridgeFinalAmount({
    super.key,
    required this.directionAEToEVM,
    required this.address,
    required this.isUCO,
    required this.to,
    required this.decimal,
    this.chainId,
    this.providerEndpoint,
  });

  final bool directionAEToEVM;
  final String address;
  final bool isUCO;
  final String to;
  final int? chainId;
  final String? providerEndpoint;
  final int decimal;

  @override
  ConsumerState<BridgeFinalAmount> createState() => _BridgeFinalAmountState();
}

class _BridgeFinalAmountState extends ConsumerState<BridgeFinalAmount>
    with aedappfm.TransactionMixin {
  double? finalAmount;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (widget.directionAEToEVM) {
      startTimerAEToEVM();
    } else {
      startTimerEVMToAE();
    }
  }

  void startTimerAEToEVM() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      try {
        final evmHTLC = EVMHTLC(
          widget.providerEndpoint ?? '',
          widget.address,
          widget.chainId ?? 0,
        );
        final resultAmount = await evmHTLC.getAmount(widget.decimal);
        resultAmount.map(
          success: (amount) {
            if (amount > 0) {
              setState(() {
                finalAmount = amount;
              });
              unawaited(refreshCurrentAccountInfoWallet());
              timer?.cancel();
            }
          },
          failure: (_) {},
        );

        // ignore: empty_catches
      } catch (e) {}
    });
  }

  void startTimerEVMToAE() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) async {
      try {
        final amount = await getAmountFromTx(
          widget.address,
          widget.isUCO,
          widget.to,
          withLastAddress: true,
        );
        if (amount > 0) {
          setState(() {
            finalAmount = amount;
          });
          unawaited(refreshCurrentAccountInfoWallet());
          timer?.cancel();
        }
        // ignore: empty_catches
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    if (bridge.bridgeOk == false) return const SizedBox.shrink();

    return finalAmount != null
        ? SelectableText(
            '${AppLocalizations.of(context)!.bridgeFinalAmountLabelAmountBridged} ${finalAmount!.formatNumber(precision: 8)} ${bridge.tokenToBridge!.targetTokenSymbol}',
            style: TextStyle(
              fontSize: aedappfm.Responsive.fontSizeFromValue(
                context,
                desktopValue: 13,
              ),
            ),
          )
        : Row(
            children: [
              SelectableText(
                AppLocalizations.of(context)!
                    .bridgeFinalAmountLabelAmountBridged,
                style: TextStyle(
                  fontSize: aedappfm.Responsive.fontSizeFromValue(
                    context,
                    desktopValue: 13,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
                width: 10,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ],
          );
  }
}

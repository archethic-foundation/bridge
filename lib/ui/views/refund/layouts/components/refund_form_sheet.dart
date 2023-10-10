import 'package:aebridge/ui/views/refund/layouts/components/refund_btn.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_can_refund_info.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_connect_wallet_btn.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_contract.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_infos.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_infos_wallet.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_message.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_textfield_contract_address.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';

class RefundFormSheet extends ConsumerWidget {
  const RefundFormSheet({this.contractAddress, super.key});
  final String? contractAddress;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const RefundInfo(),
                        const SizedBox(
                          height: 10,
                        ),
                        RefundContractAddress(contractAddress: contractAddress),
                        const RefundInfosWallet(),
                        const RefundCanRefundInfo(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Spacer(),
                        const RefundMessage(),
                        const SizedBox(
                          height: 20,
                        ),
                        const RefundTransaction(),
                        const RefundConnectWalletButton(),
                        const RefundButton(),
                        const SizedBox(
                          height: 10,
                        ),
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

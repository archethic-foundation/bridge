import 'package:aebridge/ui/views/refund/layouts/components/refund_blockchain_info.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_btn.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_can_refund_info.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_contract.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_infos.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_message.dart';
import 'package:aebridge/ui/views/refund/layouts/components/refund_textfield_contract_address.dart';
import 'package:aebridge/ui/views/themes/bridge_theme_base.dart';
import 'package:aebridge/ui/views/util/components/main_screen_background.dart';
import 'package:aebridge/ui/views/util/components/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gradient_borders/gradient_borders.dart';

class RefundFormSheet extends ConsumerWidget {
  const RefundFormSheet({this.contractAddress, super.key});
  final String? contractAddress;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const MainScreenBackground(),
        Container(
          width: 650,
          height: 350,
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
          child: ArchethicScrollbar(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: SelectionArea(
                          child: Text(
                            AppLocalizations.of(context)!.refundFormTitle,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 50,
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: BridgeThemeBase.gradient,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const RefundInfo(),
                      const SizedBox(
                        height: 10,
                      ),
                      RefundContractAddress(contractAddress: contractAddress),
                      const RefundBlockchainInfo(),
                      const RefundCanRefundInfo(),
                      const SizedBox(
                        height: 20,
                      ),
                      const RefundMessage(),
                      const SizedBox(
                        height: 20,
                      ),
                      const RefundTransaction(),
                    ],
                  ),
                ),
                const RefundButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

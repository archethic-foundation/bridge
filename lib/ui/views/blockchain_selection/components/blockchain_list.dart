/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/ui/views/blockchain_selection/bloc/provider.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class BlockchainList extends ConsumerWidget {
  const BlockchainList({
    required this.isFrom,
    super.key,
  });

  final bool isFrom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockchains = ref.watch(
      getBlockchainsListProvider,
    );

    return SizedBox(
      child: blockchains.map(
        data: (data) {
          final blockchainSelectionProvider = ref
              .watch(BlockchainSelectionFormProvider.blockchainSelectionForm);
          if (blockchainSelectionProvider.testnetIncluded == false) {
            data.value.removeWhere(
              (element) => element.env != '1-mainnet',
            );
          }

          final bridge = ref.watch(bridgeFormNotifierProvider);
          if (blockchainSelectionProvider.forceChoiceTestnetIncluded == false) {
            if (isFrom) {
              if (bridge.blockchainTo != null &&
                  bridge.blockchainTo!.env.isNotEmpty) {
                if (bridge.blockchainTo!.env != '1-mainnet') {
                  Future.delayed(
                    Duration.zero,
                    () {
                      ref
                          .read(
                            BlockchainSelectionFormProvider
                                .blockchainSelectionForm.notifier,
                          )
                          .setTestnetIncluded(true);
                    },
                  );
                }
                data.value.removeWhere(
                  (element) => element.env != bridge.blockchainTo!.env,
                );
                data.value.removeWhere(
                  (element) =>
                      element.env == bridge.blockchainTo!.env &&
                      element.name == bridge.blockchainTo!.name,
                );
              }
            } else {
              if (bridge.blockchainFrom != null &&
                  bridge.blockchainFrom!.env.isNotEmpty) {
                if (bridge.blockchainFrom!.env != '1-mainnet') {
                  Future.delayed(
                    Duration.zero,
                    () {
                      ref
                          .read(
                            BlockchainSelectionFormProvider
                                .blockchainSelectionForm.notifier,
                          )
                          .setTestnetIncluded(true);
                    },
                  );
                }
                data.value.removeWhere(
                  (element) => element.env != bridge.blockchainFrom!.env,
                );
                data.value.removeWhere(
                  (element) =>
                      element.env == bridge.blockchainFrom!.env &&
                      element.name == bridge.blockchainFrom!.name,
                );
              }
            }
          }

          return _BlockchainsList(isFrom: isFrom, blockchains: data.value);
        },
        error: (error) => const SizedBox(
          height: 300,
        ),
        loading: (loading) => const Stack(
          children: [
            SizedBox(
              height: 300,
            ),
            SizedBox(
              height: 20,
              width: 20,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlockchainsList extends StatelessWidget {
  const _BlockchainsList({required this.isFrom, required this.blockchains});

  final List<BridgeBlockchain> blockchains;
  final bool isFrom;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        shrinkWrap: true,
        itemCount: blockchains.length,
        itemBuilder: (BuildContext context, int index) {
          return _SingleBlockchain(
            isFrom: isFrom,
            blockchain: blockchains[index],
          );
        },
      ),
    );
  }
}

class _SingleBlockchain extends ConsumerWidget {
  const _SingleBlockchain({required this.isFrom, required this.blockchain});
  final bool isFrom;
  final BridgeBlockchain blockchain;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          ref
              .read(
                BlockchainSelectionFormProvider
                    .blockchainSelectionForm.notifier,
              )
              .setTestnetIncluded(false);
          final bridge = ref.read(bridgeFormNotifierProvider);
          if (isFrom) {
            if (bridge.blockchainTo != null &&
                blockchain.env != bridge.blockchainTo!.env) {
              ref
                  .read(bridgeFormNotifierProvider.notifier)
                  .setBlockchainTo(AppLocalizations.of(context)!, null);
            }
          } else {
            if (bridge.blockchainFrom != null &&
                blockchain.env != bridge.blockchainFrom!.env) {
              ref
                  .read(bridgeFormNotifierProvider.notifier)
                  .setBlockchainFrom(AppLocalizations.of(context)!, null);
            }
          }
          Navigator.pop(context, blockchain);
        },
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              'assets/images/bc-logos/${blockchain.icon}',
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                '${blockchain.name} ',
                style: Theme.of(context).textTheme.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

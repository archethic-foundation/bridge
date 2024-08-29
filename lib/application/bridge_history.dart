import 'dart:developer';

import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/bridge_token.dart';
import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/archethic_factory.dart';
import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/contracts/evm_lp.dart';
import 'package:aebridge/domain/models/bridge_history.dart';
import 'package:aebridge/domain/models/swap.dart';
import 'package:aebridge/domain/repositories/bridge_history.repository.dart';
import 'package:aebridge/domain/repositories/features_flags.dart';
import 'package:aebridge/domain/usecases/bridge_ae_process_mixin.dart';
import 'package:aebridge/infrastructure/balance.repository.dart';
import 'package:aebridge/infrastructure/bridge_history.respository.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'bridge_history.g.dart';

@riverpod
BridgeHistoryRepository _bridgeHistoryRepository(
  _BridgeHistoryRepositoryRef ref,
) =>
    BridgeHistoryRepositoryImpl();

@riverpod
Future<BridgeHistory?> _fetchBridgeHistory(_FetchBridgeHistoryRef ref) async {
  return ref.watch(_bridgeHistoryRepositoryProvider).fetchBridgeHistory();
}

@riverpod
Future<List<Map<String, dynamic>>> _fetchBridgesList(
  _FetchBridgesListRef ref, {
  bool asc = true,
}) async {
  return ref.watch(_bridgeHistoryRepositoryProvider).fetchBridgesList(asc: asc);
}

@riverpod
Future<List<Map<String, dynamic>>> _fetchBridgesOnchainList(
  _FetchBridgesOnchainListRef ref,
) async {
  final bridgesOnchainList = <Map<String, dynamic>>[];

  final blockchainConfMap = await ref.read(
    BridgeBlockchainsProviders.getBlockchainsMap.future,
  );

  final bridgeTokensPerBridgeList = await ref.read(
    BridgeTokensProviders.getTokensListPerBridgeConf.future,
  );
  if (bridgeTokensPerBridgeList.tokens == null) {
    return [];
  }

  for (final entry in bridgeTokensPerBridgeList.tokens!.entries) {
    final direction = entry.key;
    final bridgeTokens = entry.value;
    final directionFrom = direction.split('->')[0];
    final directionTo = direction.split('->')[1];

    var archethicProtocolFeesAddress = '';
    var archethicProtocolFeesRate = 0.0;

    var poolTargetBalance = 0.0;

    var blockchainFrom = blockchainConfMap[int.parse(directionFrom)];
    var blockchainTo = blockchainConfMap[int.parse(directionTo)];

    if (blockchainFrom == null || blockchainTo == null) continue;

    if (FeatureFlags.fetchBridgesOnchainListWithDevEnv == false &&
        blockchainFrom.env == '3-devnet') continue;

    final apiService = archethic.ApiService(
      blockchainFrom.isArchethic
          ? blockchainFrom.providerEndpoint
          : blockchainTo.providerEndpoint,
      logsActivation: false,
    );

    final archethicProtocolInfo = await ArchethicFactory(
      blockchainFrom.isArchethic
          ? blockchainFrom.archethicFactoryAddress!
          : blockchainTo.archethicFactoryAddress!,
    ).calculateArchethicProtocolFees();
    archethicProtocolFeesAddress = archethicProtocolInfo.address;
    archethicProtocolFeesRate = archethicProtocolInfo.rate;

    for (final bridgeToken in bridgeTokens) {
      final evmLP = EVMLP(
        blockchainFrom!.isArchethic == false
            ? blockchainFrom.providerEndpoint
            : blockchainTo!.providerEndpoint,
      );
      final swapByOwnerResult = await evmLP.getSwapsByOwner(
        blockchainFrom.isArchethic == false
            ? bridgeToken.poolAddressFrom
            : bridgeToken.poolAddressTo,
        '0x7F0F44C4EDfBB7c54501547009d32A2BC788BE79',
      );

      final swapslist = await swapByOwnerResult.map(
        success: (success) async => success,
        failure: (failure) async => <Swap>[],
      );

      for (final swap in swapslist) {
        print(
          'swap: ${swap.htlcContractAddressEVM} -> ${swap.htlcContractAddressAE} (${swap.swapProcess?.index} (0=Chargeable, 1=Signed))',
        );

        try {
          // To avoid doublons
          if ((blockchainFrom!.isArchethic && swap.swapProcess?.index == 1) ||
              (blockchainFrom.isArchethic == false &&
                  swap.swapProcess?.index == 0)) {
            double? currentStep;
            double? amount;
            int? timestamp;
            String? recipient;
            if (swap.swapProcess?.index == 0) {
              // Chargeable
              blockchainFrom = blockchainFrom.copyWith(
                htlcAddress: swap.htlcContractAddressEVM ?? '',
              );
              blockchainTo = blockchainTo!.copyWith(
                htlcAddress: swap.htlcContractAddressAE ?? '',
              );

              // Get HTLC EVM Info
              final htlc = EVMHTLC(
                blockchainFrom.providerEndpoint,
                swap.htlcContractAddressEVM!,
                blockchainFrom.chainId,
              );

              // TODO: Decimal to managed
              final amountResult = await htlc.getAmount(8);
              await amountResult.map(
                success: (success) async => amount,
                failure: (failure) async => null,
              );

              final timestampResult = await htlc.getHTLCTimestamp();
              await timestampResult.map(
                success: (success) async => timestamp,
                failure: (failure) async => null,
              );

              if (swap.htlcContractAddressEVM != null &&
                  amount == 0 &&
                  (swap.htlcContractAddressAE == null ||
                      swap.htlcContractAddressAE!.isEmpty)) {
                currentStep = 1;
              }

              if (swap.htlcContractAddressEVM != null &&
                  amount! > 0 &&
                  (swap.htlcContractAddressAE == null ||
                      swap.htlcContractAddressAE!.isEmpty)) {
                currentStep = 3;
              }
              if (swap.htlcContractAddressEVM != null &&
                  amount! > 0 &&
                  (swap.htlcContractAddressAE != null &&
                      swap.htlcContractAddressAE!.isNotEmpty)) {
                var statusAEHTLC = -1;

                final info = await ArchethicContract().getInfo(
                  apiService,
                  blockchainTo.htlcAddress!,
                );
                statusAEHTLC = info.statusHTLC ?? -1;

                final transactionIndexResult = await apiService
                    .getTransactionIndex([blockchainTo.htlcAddress!]);
                if (transactionIndexResult[blockchainTo.htlcAddress!] != null) {
                  if (transactionIndexResult[blockchainTo.htlcAddress!] == 2) {
                    if (statusAEHTLC != 1) {
                      currentStep = 6;
                    } else {
                      currentStep = 5;
                    }
                  } else {
                    if (transactionIndexResult[blockchainTo.htlcAddress!] ==
                        3) {
                      currentStep = 7;
                    } else {
                      currentStep = 8;
                    }
                  }
                }
              }
            } else {
              // Signed

              blockchainFrom = blockchainFrom.copyWith(
                htlcAddress: swap.htlcContractAddressAE ?? '',
              );
              blockchainTo = blockchainTo!.copyWith(
                htlcAddress: swap.htlcContractAddressEVM ?? '',
              );

              print(
                ' blockchainTo.isArchethic ${blockchainTo.isArchethic} bridgeToken.poolAddressTo ${bridgeToken.poolAddressTo} bridgeToken.typeTarget ${bridgeToken.typeTarget} blockchainTo.providerEndpoint ${blockchainTo.providerEndpoint}',
              );
              // TODO: Decimal to managed
              poolTargetBalance = await BalanceRepositoryImpl().getBalance(
                blockchainTo.isArchethic,
                bridgeToken.poolAddressTo,
                bridgeToken.typeTarget,
                bridgeToken.tokenAddressTarget,
                8,
                providerEndpoint: blockchainTo.providerEndpoint,
              );
              print('poolTargetBalance $poolTargetBalance');

              final transactionChainResult =
                  await apiService.getTransactionChain(
                {swap.htlcContractAddressAE!: ''},
                request: 'address validationStamp { timestamp }',
              );

              final transactionChain =
                  transactionChainResult[swap.htlcContractAddressAE!];
              final nbTx = transactionChain!.length;
              timestamp = transactionChain[0].validationStamp!.timestamp;

              if (nbTx > 1) {
                print(
                  'getAEHTLCData ${transactionChain[1].address!.address!} before',
                );
                final htlcData =
                    await ArchethicBridgeProcessMixin().getAEHTLCData(
                  transactionChain[1].address!.address!,
                  apiService,
                  resolveLastAddress: false,
                );
                amount = htlcData.amount;
                print(
                  'getAEHTLCData ${transactionChain[1].address!.address!} $amount',
                );
              }

              switch (nbTx) {
                case 1:
                  if (swap.htlcContractAddressEVM == null &&
                      swap.htlcContractAddressEVM!.isEmpty) {
                    currentStep = 2;
                  }
                  break;
                case 2:
                  if (swap.htlcContractAddressEVM == null &&
                      swap.htlcContractAddressEVM!.isEmpty) {
                    currentStep = 3;
                  } else {
                    currentStep = 5;
                  }
                  break;
                case 3:
                  if (swap.htlcContractAddressEVM != null &&
                      swap.htlcContractAddressEVM!.isNotEmpty) {
                    int statusAEHTLC;
                    final info = await ArchethicContract().getInfo(
                      apiService,
                      blockchainFrom.htlcAddress!,
                    );
                    statusAEHTLC = info.statusHTLC ?? -1;
                    if (statusAEHTLC == 0) {
                      currentStep = 6;
                    } else {
                      currentStep = 8;
                    }
                  }
                  break;
              }
            }

            final bridgeJson = <String, dynamic>{
              // Unused info
              'archethicOracleUCO': null,
              'archethicTransactionFees': 0,
              'consentDateTime': null,
              'tokenToBridgeDecimals': 8,
              'failure': currentStep != 8
                  ? {'cause': 'Unknwown', 'runtimeType': 'other'}
                  : null,
              'processStep': 'form',
              'isTransferInProgress': false,
              'walletConfirmation': null,
              'bridgeOk': currentStep == 8,
              'changeDirectionInProgress': false,
              'secret': [],
              'tokenBridgedBalance': 0,
              'tokenToBridgeBalance': 0,
              // Used info
              // TODO
              'poolTargetBalance': poolTargetBalance,
              'resumeProcess': true,
              'blockchainFrom': blockchainFrom.toJson(),
              'blockchainTo': blockchainTo.toJson(),
              'tokenToBridge': bridgeToken.toJson(),
              'tokenToBridgeAmount': amount ?? 0,
              // TODO
              'targetAddress': recipient,
              'currentStep': currentStep ?? 0,
              'timestampExec':
                  timestamp ?? DateTime.now().millisecondsSinceEpoch,
              'htlcAEAddress': swap.htlcContractAddressAE ?? '',
              'htlcEVMAddress': swap.htlcContractAddressEVM ?? '',
              // TODO
              'htlcEVMTxAddress': '',
              'archethicProtocolFeesAddress': archethicProtocolFeesAddress,
              'archethicProtocolFeesRate': archethicProtocolFeesRate,
            };
            bridgesOnchainList.add(bridgeJson);
            await BridgeHistoryRepositoryImpl().addBridge(bridge: bridgeJson);
          }
        } catch (e) {
          log('$e', name: 'fetchBridgesOnchainList');
        }
      }
    }
  }
  print('END');
  return bridgesOnchainList;
}

@riverpod
Future<void> _clearBridgesList(_ClearBridgesListRef ref) async {
  await ref.watch(_bridgeHistoryRepositoryProvider).clearBridgesList();
  ref.invalidate(BridgeHistoryProviders.fetchBridgesList);
  return;
}

abstract class BridgeHistoryProviders {
  static final fetchBridgeHistory = _fetchBridgeHistoryProvider;
  static const fetchBridgesList = _fetchBridgesListProvider;
  static final fetchBridgesOnchainList = _fetchBridgesOnchainListProvider;
  static final bridgeHistoryRepository = _bridgeHistoryRepositoryProvider;
  static final clearBridgesList = _clearBridgesListProvider;
}

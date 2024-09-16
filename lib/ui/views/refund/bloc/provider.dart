import 'dart:async';

import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/contracts/evm_htlc_erc.dart';
import 'package:aebridge/application/contracts/evm_htlc_native.dart';
import 'package:aebridge/application/contracts/evm_lp.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:aebridge/domain/models/swap.dart';
import 'package:aebridge/domain/usecases/refund_archethic.usecase.dart';
import 'package:aebridge/domain/usecases/refund_evm.usecase.dart';
import 'package:aebridge/infrastructure/hive/preferences.hive.dart';
import 'package:aebridge/infrastructure/pools.repository.dart';
import 'package:aebridge/infrastructure/token_decimals.repository.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:aebridge/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aebridge/util/browser_util_web.dart';
import 'package:aebridge/util/ethereum_util.dart';
import 'package:aebridge/util/service_locator.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kArchethicAddressLength = 68;
const kEvmAddressLength = 42;

final _refundFormNotifierProvider =
    NotifierProvider.autoDispose<RefundFormNotifier, RefundFormState>(
  () {
    return RefundFormNotifier();
  },
);

class RefundFormNotifier extends AutoDisposeNotifier<RefundFormState> {
  StreamSubscription? connectionStatusSubscription;

  @override
  RefundFormState build() {
    if (aedappfm.sl.isRegistered<EVMWalletProvider>()) {
      aedappfm.sl.unregister<EVMWalletProvider>();
    }
    ref.read(sessionNotifierProvider.notifier).cancelAllWalletsConnection();

    ref.onDispose(() {
      connectionStatusSubscription?.cancel();
    });

    return const RefundFormState();
  }

  Future<void> setContractAddress(
    BuildContext context,
    String htlcAddress,
  ) async {
    state = state.copyWith(
      htlcAddressFilled: htlcAddress,
      isAlreadyRefunded: false,
      isAlreadyWithdrawn: false,
      failure: null,
    );
    await setAddressType(null);
    if (state.wallet == null || state.wallet!.isConnected == false) {
      if (context.mounted) {
        await _controlAddress(context);
      }
    }
  }

  void setRequestTooLong(bool requestTooLong) {
    state = state.copyWith(requestTooLong: requestTooLong);
  }

  Future<void> setStatusArchethic(BuildContext context) async {
    if (state.wallet == null || state.wallet!.isConnected == false) {
      return;
    }

    state = state.copyWith(
      processRefund: null,
      defineStatusInProgress: true,
      refundTxAddress: null,
      isAlreadyRefunded: false,
      isAlreadyWithdrawn: false,
    );

    final archethicContract = ArchethicContract();
    if (await control(context)) {
      try {
        final htlcInfo = await archethicContract.getHTLCInfo(
          aedappfm.sl.get<archethic.ApiService>(),
          state.htlcAddressFilled,
        );
        if (htlcInfo.status == 2) {
          state = state.copyWith(
            processRefund: ProcessRefund.signed,
            isAlreadyRefunded: true,
          );
          return;
        }
        if (htlcInfo.status == 1) {
          state = state.copyWith(
            processRefund: ProcessRefund.signed,
            isAlreadyWithdrawn: true,
          );
        }

        final infoResult = await archethicContract.getInfo(
          aedappfm.sl.get<archethic.ApiService>(),
          state.htlcAddressFilled,
        );

        var chainId = 0;
        switch (state.wallet!.env) {
          case '1-mainnet':
            chainId = -1;
            break;
          case '2-testnet':
            chainId = -2;
            break;
          case '3-devnet':
            chainId = -3;
            break;
          default:
        }

        final symbol = await PoolsRepositoryImpl()
            .getSymbolFromPoolAddress(chainId, infoResult.aePoolAddress!);
        if (symbol != null) {
          setAmountCurrency(symbol);
        }

        setFee(htlcInfo.estimatedProtocolFees ?? 0);
        setAmount(htlcInfo.amount ?? 0);
        state = state.copyWith(
          htlcCanRefund:
              DateTime.fromMillisecondsSinceEpoch(htlcInfo.endTime! * 1000)
                  .isBefore(DateTime.now()),
          processRefund: ProcessRefund.signed,
          htlcDateLock: htlcInfo.endTime ?? 0,
          blockchainTo: 'EVM',
          chainId: chainId,
          defineStatusInProgress: false,
        );
      } catch (e) {
        if (e is aedappfm.Failure == false) {
          if (e is archethic.ArchethicJsonRPCException) {
            setFailure(const aedappfm.Failure.notHTLC());
          } else {
            setFailure(aedappfm.Failure.other(cause: e.toString()));
          }
        } else {
          setFailure(e as aedappfm.Failure);
        }
        return;
      } finally {
        state = state.copyWith(
          defineStatusInProgress: false,
        );
      }
    }
  }

  Future<void> setStatusEVM(BuildContext context) async {
    if (state.wallet == null || state.wallet!.isConnected == false) {
      return;
    }

    state = state.copyWith(
      defineStatusInProgress: true,
      refundTxAddress: null,
      isAlreadyRefunded: false,
      isAlreadyWithdrawn: false,
    );

    final chainId = aedappfm.sl.get<EVMWalletProvider>().currentChain ?? 0;

    if (await control(context)) {
      final evmHTLC = EVMHTLC(
        state.wallet!.providerEndpoint,
        state.htlcAddressFilled,
        chainId,
      );

      final blockchain = await ref.read(
        getBlockchainFromChainIdProvider(chainId).future,
      );

      state = state.copyWith(isERC20: null);
      final resultSymbol = await evmHTLC.getSymbol(blockchain!.nativeCurrency);
      resultSymbol.map(
        success: (result) {
          setAmountCurrency(result.symbol);
          state = state.copyWith(isERC20: result.isERC20);
        },
        failure: setFailure,
      );

      final poolAddress = await PoolsRepositoryImpl()
          .getPoolAddress(chainId, state.amountCurrency);

      int? status;
      try {
        status = await evmHTLC.getStatus();
      } catch (e) {
        setFailure(const aedappfm.Failure.notHTLC());
        state = state.copyWith(
          defineStatusInProgress: false,
        );
        return;
      }
      if (status == 2) {
        state = state.copyWith(
          isAlreadyRefunded: true,
          defineStatusInProgress: false,
        );
        return;
      }
      if (status == 1) {
        state = state.copyWith(
          isAlreadyWithdrawn: true,
          defineStatusInProgress: false,
        );
        return;
      }

      final evmLP = EVMLP(
        blockchain.providerEndpoint,
        chainId,
      );
      final swapByOwnerResult = await evmLP.getSwapsByOwner(
        poolAddress ?? '',
        state.wallet!.genesisAddress,
      );
      swapByOwnerResult.map(
        success: (swaps) {
          for (final swap in swaps) {
            if (swap.htlcContractAddressEVM != null &&
                swap.htlcContractAddressEVM!.toUpperCase() ==
                    state.htlcAddressFilled.toUpperCase()) {
              if (swap.swapProcess == SwapProcess.signed) {
                state = state.copyWith(processRefund: ProcessRefund.signed);
              } else {
                state = state.copyWith(processRefund: ProcessRefund.chargeable);
              }
              break;
            }
          }
        },
        failure: (failure) {},
      );

      if (state.processRefund == null) {
        if (context.mounted) {
          setFailure(
            aedappfm.Failure.other(
              cause: AppLocalizations.of(context)!.refundNotOwner,
            ),
          );
        }
        state = state.copyWith(
          defineStatusInProgress: false,
        );
        return;
      }

      if (state.processRefund == ProcessRefund.signed) {
        setFailure(const aedappfm.Failure.notHTLC());
        state = state.copyWith(
          defineStatusInProgress: false,
        );
        return;
      }

      final resultLockTime = await evmHTLC.getHTLCLockTimeAndRefundState();
      resultLockTime.map(
        success: (locktime) {
          state = state.copyWith(
            htlcDateLock: locktime.dateLockTime,
            htlcCanRefund: locktime.canRefund,
            blockchainTo: 'Archethic',
          );
        },
        failure: setFailure,
      );

      if (state.htlcCanRefund == false &&
          DateTime.fromMillisecondsSinceEpoch(state.htlcDateLock! * 1000)
              .isBefore(DateTime.now())) {
        setFailure(const aedappfm.Failure.notHTLC());
        state = state.copyWith(
          htlcDateLock: null,
          defineStatusInProgress: false,
          blockchainTo: null,
        );
        return;
      }

      final decimal = await TokenDecimalsRepositoryImpl().getTokenDecimals(
        false,
        state.isERC20! ? 'Wrapped' : 'Native',
        state.htlcAddressFilled,
      );

      final resultAmount = await evmHTLC.getAmount(decimal);
      resultAmount.map(
        success: (amount) {
          setAmount(amount);
        },
        failure: setFailure,
      );

      if (state.isERC20 != null && state.isERC20!) {
        final evmHTLCERC = EVMHTLCERC(
          state.wallet!.providerEndpoint!,
          state.htlcAddressFilled,
          chainId,
        );
        final resultFee = await evmHTLCERC.getFee(decimal);
        resultFee.map(
          success: (fee) {
            setFee(fee);
          },
          failure: setFailure,
        );
      } else {
        final evmHTLCNative = EVMHTLCNative(
          state.wallet!.providerEndpoint!,
          state.htlcAddressFilled,
          chainId,
        );
        final resultFee = await evmHTLCNative.getFee();
        resultFee.map(
          success: (fee) {
            setFee(fee);
          },
          failure: setFailure,
        );
      }
    }
    state = state.copyWith(
      defineStatusInProgress: false,
    );
  }

  void setWalletConfirmation(
    WalletConfirmationRefund? walletConfirmation,
  ) {
    state = state.copyWith(
      walletConfirmation: walletConfirmation,
    );
  }

  void setFailure(
    aedappfm.Failure? failure,
  ) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setRefundInProgress(bool refundInProgress) {
    state = state.copyWith(refundInProgress: refundInProgress);
  }

  void setAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  void setAmountCurrency(String amountCurrency) {
    state = state.copyWith(amountCurrency: amountCurrency);
  }

  void setFee(double fee) {
    state = state.copyWith(fee: fee);
  }

  void setRefundOk(bool refundOk) {
    state = state.copyWith(refundOk: refundOk);
  }

  void setRefundTxAddress(String? refundTxAddress) {
    state = state.copyWith(refundTxAddress: refundTxAddress);
  }

  Future<void> setAddressType(AddressType? addressType) async {
    if (addressType != state.addressType) {
      if (state.wallet != null && state.wallet!.isConnected) {
        await cancelWalletsConnection();
      }
      state = state.copyWith(addressType: addressType);
    }
  }

  Future<({bool result, aedappfm.Failure? failure})> _controlAddress(
    BuildContext context,
  ) async {
    state = state.copyWith(
      processRefund: null,
    );

    if (state.htlcAddressFilled.isEmpty) {
      return (
        result: false,
        failure: aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.refundControlAddressEmpty,
        ),
      );
    }

    if (state.htlcAddressFilled.length != kArchethicAddressLength &&
        state.htlcAddressFilled.length != kEvmAddressLength) {
      return (
        result: false,
        failure: aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.refundControlMalformatedAddress,
        ),
      );
    }

    if (state.htlcAddressFilled.length == kArchethicAddressLength) {
      if (archethic.Address(address: state.htlcAddressFilled).isValid() ==
          false) {
        return (
          result: false,
          failure: aedappfm.Failure.other(
            cause:
                AppLocalizations.of(context)!.refundControlMalformatedAddress,
          ),
        );
      } else {
        await setAddressType(AddressType.archethic);
      }
    }
    if (state.htlcAddressFilled.length == kEvmAddressLength) {
      if (EVMUtil.isValidEVMAddress(state.htlcAddressFilled)) {
        await setAddressType(AddressType.evm);
      } else {
        return (
          result: false,
          failure: aedappfm.Failure.other(
            cause: context.mounted
                ? AppLocalizations.of(context)!.refundControlMalformatedAddress
                : 'Malformated address.',
          ),
        );
      }
    }

    return (result: true, failure: null);
  }

  Future<bool> control(BuildContext context) async {
    state = state.copyWith(
      refundOk: false,
      refundTxAddress: null,
      isAlreadyRefunded: false,
      htlcDateLock: null,
      htlcCanRefund: false,
      amount: 0,
      failure: null,
    );

    if (BrowserUtil().isEdgeBrowser() ||
        BrowserUtil().isInternetExplorerBrowser()) {
      setFailure(
        const aedappfm.Failure.incompatibleBrowser(),
      );
      return false;
    }

    final controlAddress = await _controlAddress(context);
    if (controlAddress.failure != null) {
      state = state.copyWith(
        failure: controlAddress.failure,
      );
    }

    return controlAddress.result;
  }

  Future<void> refund(BuildContext context, WidgetRef ref) async {
    //
    if (state.chainId == null) {
      return;
    }
    switch (state.addressType) {
      case AddressType.evm:
        await RefundEVMCase().run(
          ref,
          state.wallet!.providerEndpoint!,
          state.htlcAddressFilled,
          state.chainId!,
          state.isERC20!,
        );
        break;
      case AddressType.archethic:
        await RefundArchethicCase()
            .run(ref, state.wallet!.nameAccount, state.htlcAddressFilled);
        break;
      case null:
        break;
    }
  }

  Future<aedappfm.Result<void, aedappfm.Failure>> connectToEVMWallet(
    BuildContext context,
  ) async {
    return aedappfm.Result.guard(
      () async {
        var evmWallet = const BridgeWallet();
        evmWallet = evmWallet.copyWith(
          isConnected: false,
          error: '',
        );
        state = state.copyWith(wallet: evmWallet);
        final evmWalletProvider = EVMWalletProvider();

        try {
          final currentChainId = await evmWalletProvider.getChainId();
          final bridgeBlockchain = await ref.read(
            getBlockchainFromChainIdProvider(
              currentChainId,
            ).future,
          );
          await evmWalletProvider.connect(bridgeBlockchain!);
          if (evmWalletProvider.walletConnected) {
            evmWallet = evmWallet.copyWith(
              wallet: kEVMWallet,
              isConnected: true,
              error: '',
              nameAccount: evmWalletProvider.accountName!,
              genesisAddress: evmWalletProvider.currentAddress!,
              endpoint: bridgeBlockchain.name,
              providerEndpoint: bridgeBlockchain.providerEndpoint,
              env: bridgeBlockchain.env,
            );
            state = state.copyWith(
              wallet: evmWallet,
              chainId: currentChainId,
            );
            if (aedappfm.sl.isRegistered<EVMWalletProvider>()) {
              await aedappfm.sl.unregister<EVMWalletProvider>();
            }
            aedappfm.sl.registerLazySingleton<EVMWalletProvider>(
              () => evmWalletProvider,
            );
            if (context.mounted) {
              await setStatusEVM(context);
            }
          }
        } catch (e) {
          throw const aedappfm.Failure.connectivityEVM();
        }
      },
    );
  }

  Future<aedappfm.Result<void, aedappfm.Failure>> connectToArchethicWallet(
    BuildContext context,
  ) async {
    return aedappfm.Result.guard(() async {
      var archethicWallet = const BridgeWallet();
      archethicWallet = archethicWallet.copyWith(
        isConnected: false,
        error: '',
      );
      state = state.copyWith(wallet: archethicWallet);
      awc.ArchethicDAppClient? archethicDAppClient;

      try {
        archethicDAppClient = awc.ArchethicDAppClient.auto(
          origin: const awc.RequestOrigin(
            name: 'aebridge',
          ),
          replyBaseUrl: 'aebridge://archethic.tech',
        );
      } catch (e, stackTrace) {
        aedappfm.sl.get<aedappfm.LogManager>().log(
              '$e',
              stackTrace: stackTrace,
              level: aedappfm.LogLevel.error,
              name: '_SessionNotifier - connectToArchethicWallet',
            );
        throw const aedappfm.Failure.connectivityArchethic();
      }

      final endpointResponse = await archethicDAppClient.getEndpoint();
      await endpointResponse.when(
        failure: (failure) {
          archethicWallet = archethicWallet.copyWith(
            isConnected: false,
            error: AppLocalizations.of(context)!.failureConnectivityArchethic,
          );
          state = state.copyWith(wallet: archethicWallet);
          throw const aedappfm.Failure.connectivityArchethic();
        },
        success: (result) async {
          var chainId = 0;
          switch (result.endpointUrl) {
            case 'https://mainnet.archethic.net':
              chainId = -1;
              break;
            case 'https://testnet.archethic.net':
              chainId = -2;
              break;
            case 'http://localhost:4000':
              chainId = -3;
              break;
            default:
              break;
          }
          final bridgeBlockchain = await ref.read(
            getBlockchainFromChainIdProvider(
              chainId,
            ).future,
          );
          archethicWallet = archethicWallet.copyWith(
            endpoint: bridgeBlockchain!.name,
            env: bridgeBlockchain.env,
          );
          connectionStatusSubscription =
              archethicDAppClient!.connectionStateStream.listen((event) {
            event.when(
              disconnecting: () {},
              disconnected: () {
                archethicWallet = archethicWallet.copyWith(
                  wallet: '',
                  endpoint: '',
                  error: '',
                  genesisAddress: '',
                  nameAccount: '',
                  oldNameAccount: '',
                  isConnected: false,
                );
                state = state.copyWith(wallet: archethicWallet);
              },
              connected: () {
                archethicWallet = archethicWallet.copyWith(
                  wallet: kArchethicWallet,
                  isConnected: true,
                  error: '',
                );
                state = state.copyWith(wallet: archethicWallet);
              },
              connecting: () {
                archethicWallet = archethicWallet.copyWith(
                  wallet: '',
                  error: '',
                  genesisAddress: '',
                  nameAccount: '',
                  oldNameAccount: '',
                  isConnected: false,
                );
                state = state.copyWith(wallet: archethicWallet);
              },
            );
          });
          if (aedappfm.sl.isRegistered<awc.ArchethicDAppClient>()) {
            await aedappfm.sl.unregister<awc.ArchethicDAppClient>();
          }
          aedappfm.sl.registerLazySingleton<awc.ArchethicDAppClient>(
            () => archethicDAppClient!,
          );
          await setupServiceLocatorApiService(result.endpointUrl);

          final preferences = await HivePreferencesDatasource.getInstance();
          aedappfm.sl.get<aedappfm.LogManager>().logsActived =
              preferences.isLogsActived();

          final subscription =
              await archethicDAppClient.subscribeCurrentAccount();

          subscription.when(
            success: (success) {
              archethicWallet = archethicWallet.copyWith(
                accountSub: success,
                error: '',
                isConnected: true,
                accountStreamSub: success.updates.listen((event) {
                  if (event.name.isEmpty && event.genesisAddress.isEmpty) {
                    archethicWallet = archethicWallet.copyWith(
                      oldNameAccount: archethicWallet.nameAccount,
                      genesisAddress: event.genesisAddress,
                      nameAccount: event.name,
                      error: AppLocalizations.of(context)!
                          .failureConnectivityArchethic,
                      isConnected: false,
                    );
                    state = state.copyWith(wallet: archethicWallet);
                    return;
                  }
                  archethicWallet = archethicWallet.copyWith(
                    oldNameAccount: archethicWallet.nameAccount,
                    genesisAddress: event.genesisAddress,
                    nameAccount: event.name,
                  );
                  state = state.copyWith(wallet: archethicWallet);
                }),
              );
              state = state.copyWith(wallet: archethicWallet);
            },
            failure: (failure) {
              archethicWallet = archethicWallet.copyWith(
                isConnected: false,
                error: failure.message,
              );
              state = state.copyWith(wallet: archethicWallet);
              throw aedappfm.Failure.other(cause: archethicWallet.error);
            },
          );
        },
      );

      if (context.mounted) {
        await setStatusArchethic(context);
      }
    });
  }

  Future<void> cancelWalletsConnection() async {
    if (aedappfm.sl.isRegistered<awc.ArchethicDAppClient>()) {
      await aedappfm.sl.get<awc.ArchethicDAppClient>().close();
      await aedappfm.sl.unregister<awc.ArchethicDAppClient>();
    }

    if (aedappfm.sl.isRegistered<archethic.ApiService>()) {
      await aedappfm.sl.unregister<archethic.ApiService>();
    }

    if (aedappfm.sl.isRegistered<EVMWalletProvider>()) {
      await aedappfm.sl.get<EVMWalletProvider>().disconnect();
      await aedappfm.sl.unregister<EVMWalletProvider>();
    }

    if (state.wallet != null) {
      var wallet = state.wallet;
      wallet = wallet!.copyWith(
        wallet: '',
        error: '',
        accountSub: null,
        accountStreamSub: null,
        nameAccount: '',
        oldNameAccount: '',
        isConnected: false,
        endpoint: '',
        genesisAddress: '',
      );
      state = state.copyWith(wallet: wallet);
    }
  }
}

abstract class RefundFormProvider {
  static final refundForm = _refundFormNotifierProvider;
}

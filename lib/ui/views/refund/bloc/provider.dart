import 'dart:async';

import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/contracts/evm_htlc_erc.dart';
import 'package:aebridge/application/contracts/evm_htlc_native.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:aebridge/domain/usecases/refund_archethic.usecase.dart';
import 'package:aebridge/domain/usecases/refund_evm.usecase.dart';
import 'package:aebridge/infrastructure/hive/preferences.hive.dart';
import 'package:aebridge/infrastructure/pools.repository.dart';
import 'package:aebridge/ui/views/refund/bloc/state.dart';
import 'package:aebridge/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aebridge/util/browser_util_web.dart';
import 'package:aebridge/util/service_locator.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webthree/webthree.dart' as webthree;

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
    ref.read(SessionProviders.session.notifier).cancelAllWalletsConnection();

    ref.onDispose(() {
      connectionStatusSubscription?.cancel();
    });

    return const RefundFormState();
  }

  Future<void> setContractAddress(String htlcAddress) async {
    state = state.copyWith(
      htlcAddressFilled: htlcAddress,
      failure: null,
    );
    await setAddressType(null);
    if (state.wallet == null || state.wallet!.isConnected == false) {
      await _controlAddress();
    }
  }

  Future<void> setStatusArchethic() async {
    if (state.wallet == null || state.wallet!.isConnected == false) {
      return;
    }

    state = state.copyWith(
      processRefund: null,
      refundTxAddress: null,
      isAlreadyRefunded: false,
      isAlreadyWithdrawn: false,
    );

    final archethicContract = ArchethicContract();
    if (await control()) {
      try {
        final htlcInfo = await archethicContract.getHTLCInfo(
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

        final poolAddress = await archethicContract.getPoolFromHTLC(
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
            .getSymbolFromPoolAddress(chainId, poolAddress);
        if (symbol != null) {
          setAmountCurrency(symbol);
        }
        setFee(htlcInfo.estimatedProtocolFees ?? 0);
        setAmount(htlcInfo.amount ?? 0);
        state = state.copyWith(
          htlcCanRefund: true,
          processRefund: ProcessRefund.signed,
          htlcDateLock: htlcInfo.endTime ?? 0,
          blockchainTo: 'EVM',
          chainId: chainId,
        );
      } catch (e) {
        if (e is aedappfm.Failure == false) {
          setFailure(aedappfm.Failure.other(cause: e.toString()));
        } else {
          setFailure(e as aedappfm.Failure);
        }
        return;
      }
    }
  }

  Future<void> setStatusEVM() async {
    if (state.wallet == null || state.wallet!.isConnected == false) {
      return;
    }

    state = state.copyWith(
      refundTxAddress: null,
      isAlreadyRefunded: false,
      isAlreadyWithdrawn: false,
    );

    final chainId = aedappfm.sl.get<EVMWalletProvider>().currentChain ?? 0;

    if (await control()) {
      final evmHTLC = EVMHTLC(
        state.wallet!.providerEndpoint,
        state.htlcAddressFilled,
        chainId,
      );

      int? status;
      try {
        status = await evmHTLC.getStatus();
      } catch (e) {
        setFailure(const aedappfm.Failure.notHTLC());
        return;
      }
      if (status == 2) {
        final refundTxAddress = await evmHTLC.getTxRefund();

        state = state.copyWith(
          refundTxAddress: refundTxAddress,
          isAlreadyRefunded: true,
        );
        return;
      }
      if (status == 1) {
        state = state.copyWith(
          isAlreadyWithdrawn: true,
        );
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

      final resultAmount = await evmHTLC.getAmount();
      resultAmount.map(
        success: (amount) {
          setAmount(amount);
        },
        failure: setFailure,
      );

      final blockchain = await ref.read(
        BridgeBlockchainsProviders.getBlockchainFromChainId(chainId).future,
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

      if (state.isERC20 != null && state.isERC20!) {
        final evmHTLCERC = EVMHTLCERC(
          state.wallet!.providerEndpoint!,
          state.htlcAddressFilled,
          chainId,
        );
        final resultFee = await evmHTLCERC.getFee();
        resultFee.map(
          success: (_resultFee) {
            setFee(_resultFee.fee);
            state = state.copyWith(
              processRefund: _resultFee.isChargeable == null
                  ? null
                  : _resultFee.isChargeable == true
                      ? ProcessRefund.chargeable
                      : ProcessRefund.signed,
            );
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
          success: (_resultFee) {
            setFee(_resultFee.fee);
            state = state.copyWith(
              processRefund: _resultFee.isChargeable == null
                  ? null
                  : _resultFee.isChargeable == true
                      ? ProcessRefund.chargeable
                      : ProcessRefund.signed,
            );
          },
          failure: setFailure,
        );
      }
    }
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

  Future<({bool result, aedappfm.Failure? failure})> _controlAddress() async {
    state = state.copyWith(
      processRefund: null,
    );

    if (state.htlcAddressFilled.isEmpty) {
      return (
        result: false,
        failure: const aedappfm.Failure.other(
          cause: 'Please enter a contract address.',
        ),
      );
    }

    if (state.htlcAddressFilled.length != kArchethicAddressLength &&
        state.htlcAddressFilled.length != kEvmAddressLength) {
      return (
        result: false,
        failure: const aedappfm.Failure.other(cause: 'Malformated address.'),
      );
    }

    if (state.htlcAddressFilled.length == kArchethicAddressLength) {
      if (archethic.Address(address: state.htlcAddressFilled).isValid() ==
          false) {
        return (
          result: false,
          failure: const aedappfm.Failure.other(cause: 'Malformated address.'),
        );
      } else {
        await setAddressType(AddressType.archethic);
      }
    }
    if (state.htlcAddressFilled.length == kEvmAddressLength) {
      try {
        webthree.EthereumAddress.fromHex(state.htlcAddressFilled);
        await setAddressType(AddressType.evm);
      } catch (e) {
        return (
          result: false,
          failure: const aedappfm.Failure.other(cause: 'Malformated address.'),
        );
      }
    }

    return (result: true, failure: null);
  }

  Future<bool> control() async {
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

    final controlAddress = await _controlAddress();
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

  Future<aedappfm.Result<void, aedappfm.Failure>> connectToEVMWallet() async {
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
            BridgeBlockchainsProviders.getBlockchainFromChainId(
              currentChainId,
            ).future,
          );
          await evmWalletProvider.connect(currentChainId);
          if (evmWalletProvider.walletConnected) {
            evmWallet = evmWallet.copyWith(
              wallet: kEVMWallet,
              isConnected: true,
              error: '',
              nameAccount: evmWalletProvider.accountName!,
              genesisAddress: evmWalletProvider.currentAddress!,
              endpoint: bridgeBlockchain!.name,
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
            await setStatusEVM();
          }
        } catch (e) {
          throw const aedappfm.Failure.connectivityEVM();
        }
      },
    );
  }

  Future<aedappfm.Result<void, aedappfm.Failure>>
      connectToArchethicWallet() async {
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
            error: 'Please, open your Archethic Wallet.',
          );
          state = state.copyWith(wallet: archethicWallet);
          throw const aedappfm.Failure.connectivityArchethic();
        },
        success: (result) async {
          var chainId = 0;
          switch (state.wallet!.endpoint) {
            case 'https://mainnet.archethic.net':
              chainId = -1;
              break;
            case 'https://testnet.archethic.net':
              chainId = -2;
              break;
            default:
              chainId = -3;
              break;
          }
          final bridgeBlockchain = await ref.read(
            BridgeBlockchainsProviders.getBlockchainFromChainId(
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
                      error: 'Please, open your Archethic Wallet.',
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
                error: failure.message ?? 'Connection failed',
              );
              state = state.copyWith(wallet: archethicWallet);
              throw aedappfm.Failure.other(cause: archethicWallet.error);
            },
          );
        },
      );

      await setStatusArchethic();
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

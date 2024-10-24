import 'dart:async';

import 'package:aebridge/application/app_embedded.dart';
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/evm_htlc.dart';
import 'package:aebridge/application/contracts/evm_lp.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
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
  StreamSubscription? _connectionStatusSubscription;
  final __evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();

  @override
  RefundFormState build() {
    ref.read(sessionNotifierProvider.notifier).cancelAllWalletsConnection();

    ref.onDispose(() {
      _connectionStatusSubscription?.cancel();
    });

    return const RefundFormState();
  }

  Future<EVMWalletProvider> get _evmWalletProvider async {
    if (!__evmWalletProvider.isInit) {
      await __evmWalletProvider.init(
        ref.read(bridgeBlockchainsRepositoryProvider),
        ref.read(isAppEmbeddedProvider),
      );
    }
    return __evmWalletProvider;
  }

  void setBlockchain(BridgeBlockchain blockchain) {
    state = state.copyWith(blockchain: blockchain);
  }

  Future<void> setChainId(int chainId) async {
    final blockchainsList = await ref
        .watch(bridgeBlockchainsRepositoryProvider)
        .getBlockchainsListConf();

    final blockchain = await ref
        .watch(bridgeBlockchainsRepositoryProvider)
        .getBlockchainFromChainId(blockchainsList, chainId);
    if (blockchain != null) {
      setBlockchain(blockchain);
    }
  }

  Future<void> setContractAddress(
    AppLocalizations appLocalizations,
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
      await _controlAddress(appLocalizations);
    }
  }

  void setRequestTooLong(bool requestTooLong) {
    state = state.copyWith(requestTooLong: requestTooLong);
  }

  Future<void> setStatusArchethic(AppLocalizations appLocalizations) async {
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
    if (await control(appLocalizations)) {
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

  Future<void> setStatusEVM(AppLocalizations appLocalizations) async {
    if (state.wallet == null || state.wallet!.isConnected == false) {
      return;
    }

    state = state.copyWith(
      defineStatusInProgress: true,
      refundTxAddress: null,
      isAlreadyRefunded: false,
      isAlreadyWithdrawn: false,
    );

    final chainId = state.blockchain?.chainId ?? 0;

    if (await control(appLocalizations)) {
      final evmHTLC = EVMHTLC(
        state.htlcAddressFilled,
      );

      state = state.copyWith(isERC20: null);
      final resultSymbol =
          await evmHTLC.getSymbol(state.blockchain!.nativeCurrency);
      resultSymbol.map(
        success: (result) {
          setAmountCurrency(result.symbol);
          state = state.copyWith(
            isERC20: result.isERC20,
            tokenAddress: result.tokenAddress,
          );
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

      final evmLP = EVMLP();
      final swapByOwnerResult = await evmLP.getSwapsByOwner(
        poolAddress ?? '',
        state.wallet!.genesisAddress,
        chainId,
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
        setFailure(
          aedappfm.Failure.other(
            cause: appLocalizations.refundNotOwner,
          ),
        );

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
        state.isERC20! ? state.tokenAddress ?? '' : '',
      );

      final resultAmount = await evmHTLC.getAmount(decimal);
      resultAmount.map(
        success: (amount) {
          setAmount(amount);
        },
        failure: setFailure,
      );
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
    AppLocalizations appLocalizations,
  ) async {
    state = state.copyWith(
      processRefund: null,
    );

    if (state.htlcAddressFilled.isEmpty) {
      return (
        result: false,
        failure: aedappfm.Failure.other(
          cause: appLocalizations.refundControlAddressEmpty,
        ),
      );
    }

    if (state.htlcAddressFilled.length != kArchethicAddressLength &&
        state.htlcAddressFilled.length != kEvmAddressLength) {
      return (
        result: false,
        failure: aedappfm.Failure.other(
          cause: appLocalizations.refundControlMalformatedAddress,
        ),
      );
    }

    if (state.htlcAddressFilled.length == kArchethicAddressLength) {
      if (archethic.Address(address: state.htlcAddressFilled).isValid() ==
          false) {
        return (
          result: false,
          failure: aedappfm.Failure.other(
            cause: appLocalizations.refundControlMalformatedAddress,
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
            cause: appLocalizations.refundControlMalformatedAddress,
          ),
        );
      }
    }

    return (result: true, failure: null);
  }

  Future<bool> control(AppLocalizations appLocalizations) async {
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

    final controlAddress = await _controlAddress(appLocalizations);
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
          state.htlcAddressFilled,
          state.chainId!,
          state.isERC20!,
        );
        break;
      case AddressType.archethic:
        final dappClient =
            await aedappfm.sl.getAsync<awc.ArchethicDAppClient>();
        await RefundArchethicCase(dappClient: dappClient)
            .run(ref, state.wallet!.nameAccount, state.htlcAddressFilled);
        break;
      case null:
        break;
    }
  }

  Future<aedappfm.Result<void, aedappfm.Failure>> connectToEVMWallet(
    AppLocalizations appLocalizations,
  ) async {
    return aedappfm.Result.guard(
      () async {
        var evmWallet = const BridgeWallet();
        evmWallet = evmWallet.copyWith(
          isConnected: false,
          error: '',
        );
        state = state.copyWith(wallet: evmWallet);

        try {
          final bridgeBlockchain = state.blockchain!;
          final evmWalletProvider = await _evmWalletProvider;
          await evmWalletProvider.connect(state.blockchain!);
          if (evmWalletProvider.walletConnected) {
            evmWallet = evmWallet.copyWith(
              wallet: kEVMWallet,
              isConnected: true,
              error: '',
              nameAccount: evmWalletProvider.currentAddress!,
              genesisAddress: evmWalletProvider.currentAddress!,
              endpoint: bridgeBlockchain.name,
              env: bridgeBlockchain.env,
            );
            state = state.copyWith(
              wallet: evmWallet,
              chainId: bridgeBlockchain.chainId,
            );

            await setStatusEVM(appLocalizations);
          }
        } catch (e) {
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'connectivityEVM Error : $e',
                level: aedappfm.LogLevel.error,
                name: 'refund - connectToEVMWallet',
              );
          throw const aedappfm.Failure.connectivityEVM();
        }
      },
    );
  }

  Future<aedappfm.Result<void, aedappfm.Failure>> connectToArchethicWallet(
    AppLocalizations appLocalizations,
  ) async {
    return aedappfm.Result.guard(() async {
      var archethicWallet = const BridgeWallet();
      archethicWallet = archethicWallet.copyWith(
        isConnected: false,
        error: '',
      );
      state = state.copyWith(wallet: archethicWallet);
      final archethicDAppClient =
          await aedappfm.sl.getAsync<awc.ArchethicDAppClient>();

      final endpointResponse = await archethicDAppClient.getEndpoint();
      await endpointResponse.when(
        failure: (failure) {
          archethicWallet = archethicWallet.copyWith(
            isConnected: false,
            error: appLocalizations.failureConnectivityArchethic,
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
          _connectionStatusSubscription =
              archethicDAppClient.connectionStateStream.listen((event) {
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
          await setupServiceLocatorApiService(result.endpointUrl);

          final preferences = await HivePreferencesDatasource.getInstance();
          aedappfm.sl.get<aedappfm.LogManager>().remoteLogsEnabled =
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
                      error: appLocalizations.failureConnectivityArchethic,
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

      await setStatusArchethic(appLocalizations);
    });
  }

  Future<void> cancelWalletsConnection() async {
    await aedappfm.sl.resetLazySingleton<awc.ArchethicDAppClient>();

    if (aedappfm.sl.isRegistered<archethic.ApiService>()) {
      await aedappfm.sl.unregister<archethic.ApiService>();
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

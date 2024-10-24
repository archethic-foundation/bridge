/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/app_embedded.dart';
import 'package:aebridge/application/bridge_blockchain.dart';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/application/session/state.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_blockchain_environment.dart';
import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:aebridge/infrastructure/hive/preferences.hive.dart';
import 'package:aebridge/util/service_locator.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wagmi_flutter_web/wagmi_flutter_web.dart' as wagmi;

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class SessionNotifier extends _$SessionNotifier {
  StreamSubscription? _archethicConnectionStatusSubscription;
  wagmi.WatchAccountReturnType? _watchAccountUnsubscribe;

  final __evmWalletProvider = aedappfm.sl.get<EVMWalletProvider>();
  final _logger = Logger('SessionNotifier');

  @override
  Session build() {
    ref.onDispose(() {
      _archethicConnectionStatusSubscription?.cancel();
      _unwatchEVMAccount();
    });
    return const Session();
  }

  Future<EVMWalletProvider> get _evmWalletProvider async {
    if (!__evmWalletProvider.isInit) {
      _logger.info('Initializing EVM Wallet Provider');
      await __evmWalletProvider.init(
        ref.read(bridgeBlockchainsRepositoryProvider),
        ref.read(isAppEmbeddedProvider),
      );
    }
    return __evmWalletProvider;
  }

  Future<aedappfm.Result<void, aedappfm.Failure>> connectToEVMWallet(
    BridgeBlockchain blockchain,
    bool from,
    AppLocalizations appLocalizations,
  ) async {
    return aedappfm.Result.guard(
      () async {
        _unwatchEVMAccount();

        var bridgeWallet = const BridgeWallet();
        bridgeWallet = bridgeWallet.copyWith(
          isConnected: false,
          error: '',
        );
        _fillState(bridgeWallet, from);

        try {
          final evmWalletProvider = await _evmWalletProvider;
          await evmWalletProvider.connect(blockchain);
          if (evmWalletProvider.walletConnected) {
            bridgeWallet = bridgeWallet.copyWith(
              wallet: kEVMWallet,
              isConnected: true,
              error: '',
              nameAccount: evmWalletProvider.currentAddress!,
              genesisAddress: evmWalletProvider.currentAddress!,
              endpoint: blockchain.name,
            );
          }

          _fillState(bridgeWallet, from);

          await _watchEVMAccount(
            onChange: (wagmi.Account account, wagmi.Account prevAccount) async {
              if (account.address?.toUpperCase() ==
                  prevAccount.address?.toUpperCase()) {
                return;
              }
              _logger.finer('Account updated: ${account.address}');

              if (account.address == null || account.isConnected == false) {
                bridgeWallet = bridgeWallet.copyWith(
                  oldNameAccount: bridgeWallet.nameAccount,
                  nameAccount: '',
                  error: appLocalizations.failureConnectivityEVM,
                  isConnected: false,
                );
                _fillState(bridgeWallet, from);
                return;
              }
              bridgeWallet = bridgeWallet.copyWith(
                oldNameAccount: bridgeWallet.nameAccount,
                genesisAddress: account.address!,
                nameAccount: account.address!,
              );
              _fillState(bridgeWallet, from);
            },
          );
        } catch (e) {
          // if (e is EthereumChainSwitchNotSupported) {
          //   throw const aedappfm.Failure.chainSwitchNotSupported();
          // }
          if (e.toString().toLowerCase().contains('unrecognized chain')) {
            throw const aedappfm.Failure.paramEVMChain();
          }
          aedappfm.sl.get<aedappfm.LogManager>().log(
                'connectivityEVM Error : $e',
                level: aedappfm.LogLevel.error,
                name: 'session - connectToEVMWallet',
              );
          throw const aedappfm.Failure.connectivityEVM();
        }
      },
    );
  }

  Future<aedappfm.Result<void, aedappfm.Failure>> connectToArchethicWallet(
    AppLocalizations localizations,
    bool from,
    BridgeBlockchain blockchain,
  ) async {
    return aedappfm.Result.guard(() async {
      var bridgeWallet = const BridgeWallet();
      bridgeWallet = bridgeWallet.copyWith(
        isConnected: false,
        error: '',
      );
      _fillState(bridgeWallet, from);

      final archethicDAppClient =
          await aedappfm.sl.getAsync<awc.ArchethicDAppClient>();

      final endpointResponse = await archethicDAppClient.getEndpoint();
      await endpointResponse.when(
        failure: (failure) {
          bridgeWallet = bridgeWallet.copyWith(
            isConnected: false,
            error: localizations.failureConnectivityArchethic,
          );
          _fillState(bridgeWallet, from);
          throw const aedappfm.Failure.connectivityArchethic();
        },
        success: (result) async {
          switch (blockchain.env) {
            case BridgeBlockchainEnvironment.mainnet:
              if (result.endpointUrl != 'https://mainnet.archethic.net') {
                bridgeWallet = bridgeWallet.copyWith(
                  isConnected: false,
                  error: localizations.failureConnectivityArchethicMainnet,
                );
                _fillState(bridgeWallet, from);
                throw aedappfm.Failure.wrongNetwork(bridgeWallet.error);
              }
              break;
            case BridgeBlockchainEnvironment.testnet:
              if (result.endpointUrl != 'https://testnet.archethic.net') {
                bridgeWallet = bridgeWallet.copyWith(
                  isConnected: false,
                  error: localizations.failureConnectivityArchethicTestnet,
                );
                _fillState(bridgeWallet, from);
                throw aedappfm.Failure.wrongNetwork(bridgeWallet.error);
              }
              break;
            case BridgeBlockchainEnvironment.devnet:
              if (result.endpointUrl == 'https://testnet.archethic.net' ||
                  result.endpointUrl == 'https://mainnet.archethic.net') {
                bridgeWallet = bridgeWallet.copyWith(
                  isConnected: false,
                  error: localizations.failureConnectivityArchethicDevnet,
                );
                _fillState(bridgeWallet, from);
                throw aedappfm.Failure.wrongNetwork(bridgeWallet.error);
              }
              break;
          }

          bridgeWallet = bridgeWallet.copyWith(endpoint: result.endpointUrl);
          _archethicConnectionStatusSubscription =
              archethicDAppClient.connectionStateStream.listen((event) {
            event.when(
              disconnected: () {
                bridgeWallet = bridgeWallet.copyWith(
                  wallet: '',
                  endpoint: '',
                  error: '',
                  genesisAddress: '',
                  nameAccount: '',
                  oldNameAccount: '',
                  isConnected: false,
                );
                _fillState(bridgeWallet, from);
              },
              connected: () {
                bridgeWallet = bridgeWallet.copyWith(
                  wallet: kArchethicWallet,
                  isConnected: true,
                  error: '',
                );
                _fillState(bridgeWallet, from);
              },
              disconnecting: () {},
              connecting: () {
                bridgeWallet = bridgeWallet.copyWith(
                  wallet: '',
                  endpoint: '',
                  error: '',
                  genesisAddress: '',
                  nameAccount: '',
                  oldNameAccount: '',
                  isConnected: false,
                );
                _fillState(bridgeWallet, from);
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
              bridgeWallet = bridgeWallet.copyWith(
                accountSub: success,
                error: '',
                isConnected: true,
                wallet: kArchethicWallet,
                accountStreamSub: success.updates.listen((event) {
                  if (event.name.isEmpty && event.genesisAddress.isEmpty) {
                    bridgeWallet = bridgeWallet.copyWith(
                      oldNameAccount: bridgeWallet.nameAccount,
                      genesisAddress: event.genesisAddress,
                      nameAccount: event.name,
                      error: localizations.failureConnectivityArchethic,
                      isConnected: false,
                    );
                    _fillState(bridgeWallet, from);
                    return;
                  }
                  bridgeWallet = bridgeWallet.copyWith(
                    oldNameAccount: bridgeWallet.nameAccount,
                    genesisAddress: event.genesisAddress,
                    nameAccount: event.name,
                  );
                  _fillState(bridgeWallet, from);
                }),
              );
              _fillState(bridgeWallet, from);
            },
            failure: (failure) {
              bridgeWallet = bridgeWallet.copyWith(
                isConnected: false,
                error: failure.message,
              );
              _fillState(bridgeWallet, from);
              throw aedappfm.Failure.other(cause: bridgeWallet.error);
            },
          );
        },
      );
    });
  }

  void _fillState(BridgeWallet bridgeWallet, bool from) {
    if (from) {
      state = state.copyWith(walletFrom: bridgeWallet);
    } else {
      state = state.copyWith(walletTo: bridgeWallet);
    }
  }

  void setOldNameAccount() {
    BridgeWallet? walletArchethic;
    if (state.walletFrom != null &&
        state.walletFrom!.wallet == kArchethicWallet) {
      walletArchethic = state.walletFrom;
      walletArchethic = walletArchethic!
          .copyWith(oldNameAccount: walletArchethic.nameAccount);
      state = state.copyWith(walletFrom: walletArchethic);
    } else {
      if (state.walletTo != null &&
          state.walletTo!.wallet == kArchethicWallet) {
        walletArchethic = state.walletTo;
        walletArchethic = walletArchethic!
            .copyWith(oldNameAccount: walletArchethic.nameAccount);
        state = state.copyWith(walletTo: walletArchethic);
      }
    }
  }

  Future<void> cancelAllWalletsConnection() async {
    await cancelArchethicConnection();
    await cancelEVMWalletConnection();
  }

  Future<void> cancelArchethicConnection() async {
    await aedappfm.sl.resetLazySingleton<awc.ArchethicDAppClient>();

    if (aedappfm.sl.isRegistered<ApiService>()) {
      await aedappfm.sl.unregister<ApiService>();
    }

    if (state.walletFrom != null &&
        state.walletFrom!.wallet == kArchethicWallet) {
      var walletFrom = state.walletFrom;

      walletFrom = walletFrom!.copyWith(
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
      state = state.copyWith(walletFrom: walletFrom);
    } else {
      if (state.walletTo != null &&
          state.walletTo!.wallet == kArchethicWallet) {
        var walletTo = state.walletTo;

        walletTo = walletTo!.copyWith(
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
        state = state.copyWith(walletTo: walletTo);
      }
    }
  }

  Future<void> cancelEVMWalletConnection() async {
    final evmWalletProvider = await _evmWalletProvider;
    await evmWalletProvider.disconnect();

    if (state.walletFrom != null && state.walletFrom!.wallet == kEVMWallet) {
      var walletFrom = state.walletFrom;

      walletFrom = walletFrom!.copyWith(
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
      state = state.copyWith(walletFrom: walletFrom);
    } else {
      if (state.walletTo != null && state.walletTo!.wallet == kEVMWallet) {
        var walletTo = state.walletFrom;

        walletTo = walletTo!.copyWith(
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
        state = state.copyWith(walletTo: walletTo);
      }
    }
  }

  Future<void> _watchEVMAccount({
    required void Function(wagmi.Account, wagmi.Account) onChange,
  }) async {
    _unwatchEVMAccount();
    _logger.finer('Watching Account updates');
    final watchAccountParameters = wagmi.WatchAccountParameters(
      onChange: onChange,
    );
    _watchAccountUnsubscribe = await wagmi.Core.watchAccount(
      watchAccountParameters,
    );
  }

  void _unwatchEVMAccount() {
    _logger.finer('Unwatching Account updates');

    if (_watchAccountUnsubscribe != null) {
      _watchAccountUnsubscribe?.call();
      _watchAccountUnsubscribe = null;
    }
  }
}

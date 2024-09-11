/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/application/session/state.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:aebridge/infrastructure/hive/preferences.hive.dart';
import 'package:aebridge/util/service_locator.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class _SessionNotifier extends _$SessionNotifier {
  StreamSubscription? _connectionStatusSubscription;

  @override
  Session build() {
    ref.onDispose(() {
      _connectionStatusSubscription?.cancel();
    });
    return const Session();
  }

  Future<aedappfm.Result<void, aedappfm.Failure>> connectToEVMWallet(
    BridgeBlockchain blockchain,
    bool from,
  ) async {
    return aedappfm.Result.guard(
      () async {
        var bridgeWallet = const BridgeWallet();
        bridgeWallet = bridgeWallet.copyWith(
          isConnected: false,
          error: '',
        );
        _fillState(bridgeWallet, from);

        final evmWalletProvider = EVMWalletProvider();

        try {
          await evmWalletProvider.connect(blockchain);
          if (evmWalletProvider.walletConnected) {
            bridgeWallet = bridgeWallet.copyWith(
              wallet: kEVMWallet,
              isConnected: true,
              error: '',
              nameAccount: evmWalletProvider.accountName!,
              genesisAddress: evmWalletProvider.currentAddress!,
              endpoint: blockchain.name,
            );
            if (aedappfm.sl.isRegistered<EVMWalletProvider>()) {
              await aedappfm.sl.unregister<EVMWalletProvider>();
            }
            aedappfm.sl.registerLazySingleton<EVMWalletProvider>(
              () => evmWalletProvider,
            );
          }

          _fillState(bridgeWallet, from);
        } catch (e) {
          // if (e is EthereumChainSwitchNotSupported) {
          //   throw const aedappfm.Failure.chainSwitchNotSupported();
          // }
          if (e.toString().toLowerCase().contains('unrecognized chain')) {
            throw const aedappfm.Failure.paramEVMChain();
          }
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
          bridgeWallet = bridgeWallet.copyWith(
            isConnected: false,
            error: localizations.failureConnectivityArchethic,
          );
          _fillState(bridgeWallet, from);
          throw const aedappfm.Failure.connectivityArchethic();
        },
        success: (result) async {
          switch (blockchain.env) {
            case '1-mainnet':
              if (result.endpointUrl != 'https://mainnet.archethic.net') {
                bridgeWallet = bridgeWallet.copyWith(
                  isConnected: false,
                  error: localizations.failureConnectivityArchethicMainnet,
                );
                _fillState(bridgeWallet, from);
                throw aedappfm.Failure.wrongNetwork(bridgeWallet.error);
              }
              break;
            case '2-testnet':
              if (result.endpointUrl != 'https://testnet.archethic.net') {
                bridgeWallet = bridgeWallet.copyWith(
                  isConnected: false,
                  error: localizations.failureConnectivityArchethicTestnet,
                );
                _fillState(bridgeWallet, from);
                throw aedappfm.Failure.wrongNetwork(bridgeWallet.error);
              }
              break;
            case '3-devnet':
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
            default:
              bridgeWallet = bridgeWallet.copyWith(
                isConnected: false,
                error: localizations.failureConnectivityArchethiRightNetwork,
              );
              _fillState(bridgeWallet, from);
              throw aedappfm.Failure.wrongNetwork(bridgeWallet.error);
          }

          bridgeWallet = bridgeWallet.copyWith(endpoint: result.endpointUrl);
          _connectionStatusSubscription =
              archethicDAppClient!.connectionStateStream.listen((event) {
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
    if (aedappfm.sl.isRegistered<awc.ArchethicDAppClient>()) {
      await aedappfm.sl.get<awc.ArchethicDAppClient>().close();
      await aedappfm.sl.unregister<awc.ArchethicDAppClient>();
    }

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
    if (aedappfm.sl.isRegistered<EVMWalletProvider>()) {
      await aedappfm.sl.get<EVMWalletProvider>().disconnect();
      await aedappfm.sl.unregister<EVMWalletProvider>();
    }
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
}

abstract class SessionProviders {
  static final session = _sessionNotifierProvider;
}

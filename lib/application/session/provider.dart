/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/application/session/state.dart';
import 'package:aebridge/domain/repositories/features_flags.dart';
import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:aebridge/model/bridge_wallet.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:aebridge/util/service_locator.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class _SessionNotifier extends Notifier<Session> {
  StreamSubscription? connectionStatusSubscription;

  @override
  Session build() {
    ref.onDispose(() {
      debugPrint('dispose SessionNotifier');
      connectionStatusSubscription?.cancel();
    });
    return const Session();
  }

/*
  Future<void> connectToMWalletConnect(BridgeBlockchain blockchain) async {
    try {
      final walletConnectProvider = WalletConnectProvider();

      await walletConnectProvider.connect(blockchain.chainId);
      if (walletConnectProvider.walletConnected) {
        debugPrint('Connected to ${blockchain.name}');

        state = state.copyWith(
          wallet: 'evmWallet',
          isConnected: true,
          error: '',
          nameAccount: walletConnectProvider.session!.accounts[0],
          genesisAddress: walletConnectProvider.session!.accounts[0],
          endpoint: blockchain.name,
        );
        if (sl.isRegistered<WalletConnectProvider>()) {
          sl.unregister<WalletConnectProvider>();
        }
        sl.registerLazySingleton<WalletConnectProvider>(
          () => walletConnectProvider,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      state = state.copyWith(
        isConnected: false,
        error: 'Please, open your WalletConnect.',
      );
    }
  }
*/
  Future<void> connectToEVMWallet(
    BridgeBlockchain blockchain,
    bool from,
  ) async {
    var bridgeWallet = const BridgeWallet();
    bridgeWallet = bridgeWallet.copyWith(
      isConnected: false,
      error: '',
    );
    _fillState(bridgeWallet, from);

    final evmWalletProvider = EVMWalletProvider();

    await evmWalletProvider.connect(blockchain.chainId);
    if (evmWalletProvider.walletConnected) {
      debugPrint('Connected to ${blockchain.name}');

      bridgeWallet = bridgeWallet.copyWith(
        wallet: 'evmWallet',
        isConnected: true,
        error: '',
        nameAccount: evmWalletProvider.accountName!,
        genesisAddress: evmWalletProvider.currentAddress!,
        endpoint: blockchain.name,
      );
      if (sl.isRegistered<EVMWalletProvider>()) {
        await sl.unregister<EVMWalletProvider>();
      }
      sl.registerLazySingleton<EVMWalletProvider>(
        () => evmWalletProvider,
      );
    }

    _fillState(bridgeWallet, from);
  }

  Future<void> connectToArchethicWallet(bool from) async {
    var bridgeWallet = const BridgeWallet();
    bridgeWallet = bridgeWallet.copyWith(
      isConnected: false,
      error: '',
    );
    _fillState(bridgeWallet, from);
    try {
      final archethicDAppClient = awc.ArchethicDAppClient.auto(
        origin: const awc.RequestOrigin(
          name: 'aebridge',
        ),
        replyBaseUrl: 'aebridge://archethic.tech',
      );

      final endpointResponse = await archethicDAppClient.getEndpoint();
      endpointResponse.when(
        failure: (failure) {
          switch (failure.code) {
            case 4901:
              bridgeWallet = bridgeWallet.copyWith(
                isConnected: false,
                error: 'Please, open your Archethic Wallet.',
              );
              _fillState(bridgeWallet, from);
              break;
            default:
              debugPrint(failure.message ?? 'Connection failed');
              bridgeWallet = bridgeWallet.copyWith(
                isConnected: false,
                error: 'Please, open your Archethic Wallet.',
              );
              _fillState(bridgeWallet, from);
          }
          throw Exception(bridgeWallet.error);
        },
        success: (result) async {
          debugPrint('DApp is connected to archethic wallet.');

          if (FeatureFlags.mainnetActive == false &&
              result.endpointUrl == 'https://mainnet.archethic.net') {
            bridgeWallet = bridgeWallet.copyWith(
              isConnected: false,
              error:
                  'aebridge is not currently available on the Archethic mainnet.',
            );
            _fillState(bridgeWallet, from);
            throw Exception(bridgeWallet.error);
          }

          bridgeWallet = bridgeWallet.copyWith(endpoint: result.endpointUrl);
          connectionStatusSubscription =
              archethicDAppClient.connectionStateStream.listen((event) {
            event.when(
              disconnected: () {
                debugPrint('Disconnected');
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
                debugPrint('Connected');
                bridgeWallet = bridgeWallet.copyWith(
                  wallet: 'archethic',
                  isConnected: true,
                  error: '',
                );
                _fillState(bridgeWallet, from);
              },
              connecting: () {
                debugPrint('Connecting');
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
          if (sl.isRegistered<ApiService>()) {
            await sl.unregister<ApiService>();
          }
          if (sl.isRegistered<OracleService>()) {
            await sl.unregister<OracleService>();
          }
          if (sl.isRegistered<awc.ArchethicDAppClient>()) {
            await sl.unregister<awc.ArchethicDAppClient>();
          }
          sl.registerLazySingleton<awc.ArchethicDAppClient>(
            () => archethicDAppClient,
          );
          setupServiceLocatorApiService(result.endpointUrl);
          final subscription =
              await archethicDAppClient.subscribeCurrentAccount();

          subscription.when(
            success: (success) async {
              bridgeWallet = bridgeWallet.copyWith(
                accountSub: success,
                error: '',
                isConnected: true,
                accountStreamSub: success.updates.listen((event) {
                  if (event.name.isEmpty && event.genesisAddress.isEmpty) {
                    bridgeWallet = bridgeWallet.copyWith(
                      oldNameAccount: bridgeWallet.nameAccount,
                      genesisAddress: event.genesisAddress,
                      nameAccount: event.name,
                      error: 'Please, open your Archethic Wallet.',
                      isConnected: false,
                    );
                    _fillState(bridgeWallet, from);
                    return;
                  }
                  debugPrint('event.genesisAddress ${event.genesisAddress}');
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
                error: failure.message ?? 'Connection failed',
              );
              _fillState(bridgeWallet, from);
              throw Exception(bridgeWallet.error);
            },
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      bridgeWallet = bridgeWallet.copyWith(
        isConnected: false,
        error: 'Please, open your Archethic Wallet.',
      );
      _fillState(bridgeWallet, from);
      throw Exception(bridgeWallet.error);
    }
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
    if (state.walletFrom != null && state.walletFrom!.wallet == 'archethic') {
      walletArchethic = state.walletFrom;
      walletArchethic = walletArchethic!
          .copyWith(oldNameAccount: walletArchethic.nameAccount);
      state = state.copyWith(walletFrom: walletArchethic);
    } else {
      if (state.walletTo != null && state.walletTo!.wallet == 'archethic') {
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
    if (sl.isRegistered<awc.ArchethicDAppClient>()) {
      await sl.get<awc.ArchethicDAppClient>().close();
      await sl.unregister<awc.ArchethicDAppClient>();
    }

    if (sl.isRegistered<ApiService>()) {
      await sl.unregister<ApiService>();
    }

    if (state.walletFrom != null && state.walletFrom!.wallet == 'archethic') {
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
      if (state.walletTo != null && state.walletTo!.wallet == 'archethic') {
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

  Future<void> cancelEVMWalletConnection() async {
    if (sl.isRegistered<EVMWalletProvider>()) {
      await sl.get<EVMWalletProvider>().disconnect();
    }
    if (state.walletFrom != null && state.walletFrom!.wallet == 'evmWallet') {
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
      if (state.walletTo != null && state.walletTo!.wallet == 'evmWallet') {
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

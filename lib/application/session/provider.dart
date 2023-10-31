/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;

import 'package:aebridge/application/evm_wallet.dart';
import 'package:aebridge/application/session/state.dart';
import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_wallet.dart';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/domain/repositories/features_flags.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:aebridge/util/service_locator.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart' as awc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class _SessionNotifier extends Notifier<Session> {
  StreamSubscription? connectionStatusSubscription;

  @override
  Session build() {
    ref.onDispose(() {
      connectionStatusSubscription?.cancel();
    });
    return const Session();
  }

  Future<Result<void, Failure>> connectToEVMWallet(
    BridgeBlockchain blockchain,
    bool from,
  ) async {
    return Result.guard(
      () async {
        var bridgeWallet = const BridgeWallet();
        bridgeWallet = bridgeWallet.copyWith(
          isConnected: false,
          error: '',
        );
        _fillState(bridgeWallet, from);

        final evmWalletProvider = EVMWalletProvider();

        try {
          await evmWalletProvider.connect(blockchain.chainId);
          if (evmWalletProvider.walletConnected) {
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
        } catch (e) {
          throw const Failure.connectivityEVM();
        }
      },
    );
  }

  Future<Result<void, Failure>> connectToArchethicWallet(
    bool from,
    BridgeBlockchain blockchain,
  ) async {
    return Result.guard(() async {
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
        dev.log('$e', stackTrace: stackTrace);
        throw const Failure.connectivityArchethic();
      }

      final endpointResponse = await archethicDAppClient.getEndpoint();
      await endpointResponse.when(
        failure: (failure) {
          bridgeWallet = bridgeWallet.copyWith(
            isConnected: false,
            error: 'Please, open your Archethic Wallet.',
          );
          _fillState(bridgeWallet, from);
          throw const Failure.connectivityArchethic();
        },
        success: (result) async {
          switch (blockchain.env) {
            case '1-mainnet':
              if (result.endpointUrl != 'https://mainnet.archethic.net') {
                bridgeWallet = bridgeWallet.copyWith(
                  isConnected: false,
                  error:
                      'Please, connect your Archethic wallet to the Mainnet network.',
                );
                _fillState(bridgeWallet, from);
                throw Failure.wrongNetwork(bridgeWallet.error);
              }
              break;
            case '2-testnet':
              if (result.endpointUrl != 'https://testnet.archethic.net') {
                bridgeWallet = bridgeWallet.copyWith(
                  isConnected: false,
                  error:
                      'Please, connect your Archethic wallet to the Testnet network.',
                );
                _fillState(bridgeWallet, from);
                throw Failure.wrongNetwork(bridgeWallet.error);
              }
              break;
            case '3-devnet':
              if (result.endpointUrl == 'https://testnet.archethic.net' ||
                  result.endpointUrl == 'https://mainnet.archethic.net') {
                bridgeWallet = bridgeWallet.copyWith(
                  isConnected: false,
                  error:
                      'Please, connect your Archethic wallet to the Devnet network.',
                );
                _fillState(bridgeWallet, from);
                throw Failure.wrongNetwork(bridgeWallet.error);
              }
              break;
            default:
              bridgeWallet = bridgeWallet.copyWith(
                isConnected: false,
                error:
                    'Please, connect your Archethic wallet to the right network.',
              );
              _fillState(bridgeWallet, from);
              throw Failure.wrongNetwork(bridgeWallet.error);
          }

          if (FeatureFlags.mainnetActive == false &&
              result.endpointUrl == 'https://mainnet.archethic.net') {
            bridgeWallet = bridgeWallet.copyWith(
              isConnected: false,
              error:
                  'AEBridge is not currently available on the Archethic mainnet.',
            );
            _fillState(bridgeWallet, from);
            throw Failure.other(cause: bridgeWallet.error);
          }

          bridgeWallet = bridgeWallet.copyWith(endpoint: result.endpointUrl);
          connectionStatusSubscription =
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
                  wallet: 'archethic',
                  isConnected: true,
                  error: '',
                );
                _fillState(bridgeWallet, from);
              },
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
          if (sl.isRegistered<ApiService>()) {
            await sl.unregister<ApiService>();
          }
          if (sl.isRegistered<awc.ArchethicDAppClient>()) {
            await sl.unregister<awc.ArchethicDAppClient>();
          }
          sl.registerLazySingleton<awc.ArchethicDAppClient>(
            () => archethicDAppClient!,
          );
          setupServiceLocatorApiService(result.endpointUrl);
          final subscription =
              await archethicDAppClient.subscribeCurrentAccount();

          subscription.when(
            success: (success) {
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
              throw Failure.other(cause: bridgeWallet.error);
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

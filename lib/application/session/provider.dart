/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:aebridge/application/metamask.dart';
import 'package:aebridge/application/session/state.dart';
import 'package:aebridge/domain/repositories/features_flags.dart';
import 'package:aebridge/model/bridge_blockchain.dart';
import 'package:aebridge/model/contracts/htlc_eth.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:aebridge/util/service_locator.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart';
import 'package:crypto/crypto.dart';
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

  Future<void> connectToMetamask(BridgeBlockchain blockchain) async {
    try {
      final metamaskProvider = MetaMaskProvider();

      await metamaskProvider.connect(blockchain.chainId);
      if (metamaskProvider.walletConnected) {
        debugPrint('Connected to ${blockchain.name}');

        state = state.copyWith(
          wallet: 'metamask',
          isConnected: true,
          error: '',
          nameAccount: metamaskProvider.accountName!,
          genesisAddress: metamaskProvider.currentAddress!,
          endpoint: blockchain.name,
        );
        if (sl.isRegistered<MetaMaskProvider>()) {
          sl.unregister<MetaMaskProvider>();
        }
        sl.registerLazySingleton<MetaMaskProvider>(
          () => metamaskProvider,
        );
      }

      final secret = Uint8List.fromList(
        List<int>.generate(32, (int i) => Random.secure().nextInt(256)),
      );

      HTLCEthContract().deployHTLC(
        '0xCF026E727C1A5A71058316D223cA5BDb51c962A6',
        '0x26006236eaB6409D9FDECb16ed841033d6B4A6bC',
        sha256.convert(secret).toString(),
        BigInt.from(10),
      );
    } catch (e) {
      debugPrint(e.toString());
      state = state.copyWith(
        isConnected: false,
        error: 'Please, open your Metamask.',
      );
    }
  }

  Future<void> connectToArchethicWallet() async {
    try {
      state = state.copyWith(
        isConnected: false,
        error: '',
      );

      final archethicDAppClient = ArchethicDAppClient.auto(
        origin: const RequestOrigin(
          name: 'aebridge',
        ),
        replyBaseUrl: 'aebridge://archethic.tech',
      );

      final endpointResponse = await archethicDAppClient.getEndpoint();
      endpointResponse.when(
        failure: (failure) {
          switch (failure.code) {
            case 4901:
              state = state.copyWith(
                isConnected: false,
                error: 'Please, open your Archethic Wallet.',
              );
              break;
            default:
              debugPrint(failure.message ?? 'Connection failed');
              state = state.copyWith(
                isConnected: false,
                error: 'Please, open your Archethic Wallet.',
              );
          }
        },
        success: (result) async {
          debugPrint('DApp is connected to archethic wallet.');

          if (FeatureFlags.mainnetActive == false &&
              result.endpointUrl == 'https://mainnet.archethic.net') {
            state = state.copyWith(
              isConnected: false,
              error:
                  'aebridge is not currently available on the Archethic mainnet.',
            );
            return;
          }

          state = state.copyWith(endpoint: result.endpointUrl);
          connectionStatusSubscription =
              archethicDAppClient.connectionStateStream.listen((event) {
            event.when(
              disconnected: () {
                debugPrint('Disconnected');
                state = state.copyWith(
                  wallet: '',
                  endpoint: '',
                  error: '',
                  genesisAddress: '',
                  nameAccount: '',
                  oldNameAccount: '',
                  isConnected: false,
                );
              },
              connected: () async {
                debugPrint('Connected');
                state = state.copyWith(
                  wallet: 'archethic',
                  isConnected: true,
                  error: '',
                );
              },
              connecting: () {
                debugPrint('Connecting');
                state = state.copyWith(
                  wallet: '',
                  endpoint: '',
                  error: '',
                  genesisAddress: '',
                  nameAccount: '',
                  oldNameAccount: '',
                  isConnected: false,
                );
              },
            );
          });
          if (sl.isRegistered<ApiService>()) {
            sl.unregister<ApiService>();
          }
          if (sl.isRegistered<OracleService>()) {
            sl.unregister<OracleService>();
          }
          if (sl.isRegistered<ArchethicDAppClient>()) {
            sl.unregister<ArchethicDAppClient>();
          }
          sl.registerLazySingleton<ArchethicDAppClient>(
            () => archethicDAppClient,
          );
          setupServiceLocatorApiService(result.endpointUrl);
          final subscription =
              await archethicDAppClient.subscribeCurrentAccount();

          subscription.when(
            success: (success) async {
              state = state.copyWith(
                accountSub: success,
                error: '',
                isConnected: true,
                accountStreamSub: success.updates.listen((event) {
                  if (event.name.isEmpty && event.genesisAddress.isEmpty) {
                    state = state.copyWith(
                      oldNameAccount: state.nameAccount,
                      genesisAddress: event.genesisAddress,
                      nameAccount: event.name,
                      error: 'Please, open your Archethic Wallet.',
                      isConnected: false,
                    );
                    return;
                  }
                  state = state.copyWith(
                    oldNameAccount: state.nameAccount,
                    genesisAddress: event.genesisAddress,
                    nameAccount: event.name,
                  );
                }),
              );
            },
            failure: (failure) {
              state = state.copyWith(
                isConnected: false,
                error: failure.message ?? 'Connection failed',
              );
            },
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      state = state.copyWith(
        isConnected: false,
        error: 'Please, open your Archethic Wallet.',
      );
    }
  }

  void setOldNameAccount() {
    state = state.copyWith(oldNameAccount: state.nameAccount);
  }

  Future<void> cancelConnection() async {
    await sl.get<ArchethicDAppClient>().close();
    if (sl.isRegistered<ApiService>()) {
      sl.unregister<ApiService>();
    }

    state = state.copyWith(
      accountSub: null,
      accountStreamSub: null,
      nameAccount: '',
      genesisAddress: '',
    );
  }
}

abstract class SessionProviders {
  static final session = _sessionNotifierProvider;
}

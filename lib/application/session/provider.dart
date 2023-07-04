/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer';
import 'package:aebridge/application/metamask.dart';
import 'package:aebridge/application/session/state.dart';
import 'package:aebridge/domain/repositories/features_flags.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:aebridge/util/service_locator.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_wallet_client/archethic_wallet_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
class _SessionNotifier extends Notifier<Session> {
  StreamSubscription? connectionStatusSubscription;

  @override
  Session build() {
    ref.onDispose(() {
      log('dispose SessionNotifier');
      connectionStatusSubscription?.cancel();
    });
    return const Session();
  }

  Future<void> connectToMetamask() async {
    try {
      final metamaskProvider = MetaMaskProvider();
      if (metamaskProvider.isEnabled == false) {
        state = state.copyWith(
          isConnected: false,
          error: 'Metamask is not available.',
        );
        return;
      }
      await metamaskProvider.connect();
      if (metamaskProvider.isConnected) {
        log('Connected', name: 'Wallet connection');

        var chainIdLabel = '';
        switch (metamaskProvider.currentChain) {
          case 1:
            chainIdLabel = 'Ethereum Mainnet';
            break;
          case 80001:
            chainIdLabel = 'Mumbai Polygon Testnet';
            break;
          case 137:
            chainIdLabel = 'Polygon Mainnet';
            break;
          case 97:
            chainIdLabel = 'BSC Testnet';
            break;
          case 56:
            chainIdLabel = 'BSC Mainnet';
            break;
          case 5:
            chainIdLabel = 'Goerli Ethereum Testnet';
            break;
          case 1337:
            chainIdLabel = 'Ethereum Devnet';
            break;
          default:
            chainIdLabel = 'Unknown';
            break;
        }

        state = state.copyWith(
          wallet: 'metamask',
          isConnected: true,
          error: '',
          nameAccount: metamaskProvider.account,
          genesisAddress: metamaskProvider.currentAddress,
          endpoint: chainIdLabel,
        );
        if (sl.isRegistered<MetaMaskProvider>()) {
          sl.unregister<MetaMaskProvider>();
        }
        sl.registerLazySingleton<MetaMaskProvider>(
          () => metamaskProvider,
        );
      }
    } catch (e) {
      log(e.toString());
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
              log(failure.message ?? 'Connection failed');
              state = state.copyWith(
                isConnected: false,
                error: 'Please, open your Archethic Wallet.',
              );
          }
        },
        success: (result) async {
          log('DApp is connected to archethic wallet.');

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
                log('Disconnected', name: 'Wallet connection');
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
                log('Connected', name: 'Wallet connection');
                state = state.copyWith(
                  wallet: 'archethic',
                  isConnected: true,
                  error: '',
                );
              },
              connecting: () {
                log('Connecting', name: 'Wallet connection');
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
      log(e.toString());
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
    log('Unregister', name: 'ApiService');
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

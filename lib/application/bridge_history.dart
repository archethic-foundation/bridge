import 'package:aebridge/domain/models/bridge_history.dart';
import 'package:aebridge/domain/repositories/bridge_history.repository.dart';
import 'package:aebridge/infrastructure/bridge_history.respository.dart';
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
Future<void> _clearBridgesList(_ClearBridgesListRef ref) async {
  ref.watch(_bridgeHistoryRepositoryProvider).clearBridgesList();
  ref.invalidate(BridgeHistoryProviders.fetchBridgesList);
  return;
}

abstract class BridgeHistoryProviders {
  static final fetchBridgeHistory = _fetchBridgeHistoryProvider;
  static const fetchBridgesList = _fetchBridgesListProvider;
  static final bridgeHistoryRepository = _bridgeHistoryRepositoryProvider;
  static final clearBridgesList = _clearBridgesListProvider;
}

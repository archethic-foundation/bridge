import 'package:aebridge/domain/models/bridge_history.dart';
import 'package:aebridge/domain/repositories/bridge_history.repository.dart';
import 'package:aebridge/infrastructure/bridge_history.respository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bridge_history.g.dart';

@riverpod
BridgeHistoryRepository bridgeHistoryRepository(
  BridgeHistoryRepositoryRef ref,
) =>
    BridgeHistoryRepositoryImpl();

@riverpod
Future<BridgeHistory?> fetchBridgeHistory(FetchBridgeHistoryRef ref) async {
  return ref.watch(bridgeHistoryRepositoryProvider).fetchBridgeHistory();
}

@riverpod
Future<List<Map<String, dynamic>>> fetchBridgesList(
  FetchBridgesListRef ref, {
  bool asc = true,
}) async {
  return ref.watch(bridgeHistoryRepositoryProvider).fetchBridgesList(asc: asc);
}

@riverpod
Future<void> clearBridgesList(ClearBridgesListRef ref) async {
  await ref.watch(bridgeHistoryRepositoryProvider).clearBridgesList();
  ref.invalidate(fetchBridgesListProvider);
  return;
}

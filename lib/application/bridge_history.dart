import 'package:aebridge/domain/models/bridge_history.dart';
import 'package:aebridge/domain/repositories/bridge_history.repository.dart';
import 'package:aebridge/infrastructure/bridge_history.respository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bridge_history.g.dart';

@riverpod
BridgeHistoryRepository bridgeHistoryRepository(
  Ref ref,
) =>
    BridgeHistoryRepositoryImpl();

@riverpod
Future<BridgeHistory?> fetchBridgeHistory(Ref ref) async {
  return ref.watch(bridgeHistoryRepositoryProvider).fetchBridgeHistory();
}

@riverpod
Future<List<Map<String, dynamic>>> fetchBridgesList(
  Ref ref, {
  bool asc = true,
}) async {
  return ref.watch(bridgeHistoryRepositoryProvider).fetchBridgesList(asc: asc);
}

@riverpod
Future<void> clearBridgesList(Ref ref) async {
  await ref.watch(bridgeHistoryRepositoryProvider).clearBridgesList();
  ref.invalidate(fetchBridgesListProvider);
  return;
}

import 'package:aebridge/domain/repositories/datasources/bridge_local_datasource.dart';
import 'package:aebridge/model/hive/bridge_history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bridge_history.g.dart';

@riverpod
BridgeHistoryRepository _bridgeHistoryRepository(
  _BridgeHistoryRepositoryRef ref,
) =>
    BridgeHistoryRepository();

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

class BridgeHistoryRepository {
  Future<BridgeHistory?> fetchBridgeHistory() async {
    final hiveBridgeDatasource = await HiveBridgeDatasource.getInstance();
    return hiveBridgeDatasource.getBridgeHistory();
  }

  Future<List<Map<String, dynamic>>> fetchBridgesList({bool asc = true}) async {
    final bridgeHistory = await fetchBridgeHistory();
    if (bridgeHistory == null || bridgeHistory.bridgeList == null) return [];
    if (asc == false) {
      return bridgeHistory.bridgeList!.reversed.toList();
    }
    return bridgeHistory.bridgeList!;
  }

  Future<void> clearBridgesList() async {
    final hiveBridgeDatasource = await HiveBridgeDatasource.getInstance();
    await hiveBridgeDatasource.clearBridgesList();
    return;
  }
}

abstract class BridgeHistoryProviders {
  static final fetchBridgeHistory = _fetchBridgeHistoryProvider;
  static const fetchBridgesList = _fetchBridgesListProvider;
  static final bridgeHistoryRepository = _bridgeHistoryRepositoryProvider;
  static final clearBridgesList = _clearBridgesListProvider;
}

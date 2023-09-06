/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aebridge/domain/models/bridge_history.dart';
import 'package:aebridge/domain/repositories/bridge_history.repository.dart';
import 'package:aebridge/infrastructure/bridge_history.hive.dto.dart';
import 'package:aebridge/infrastructure/hive/bridge.hive.datasource.dart';

class BridgeHistoryRepositoryImpl implements BridgeHistoryRepository {
  @override
  Future<BridgeHistory?> fetchBridgeHistory() async {
    final hiveBridgeDatasource = await HiveBridgeDatasource.getInstance();
    final dto = await hiveBridgeDatasource.getBridgeHistory();
    return dto?.toModel;
  }

  @override
  Future<List<Map<String, dynamic>>> fetchBridgesList({bool asc = true}) async {
    final bridgeHistory = await fetchBridgeHistory();
    if (bridgeHistory == null || bridgeHistory.bridgeList == null) return [];
    if (asc == false) {
      return bridgeHistory.bridgeList!.reversed.toList();
    }
    return bridgeHistory.bridgeList!;
  }

  @override
  Future<void> clearBridgesList() async {
    final hiveBridgeDatasource = await HiveBridgeDatasource.getInstance();
    await hiveBridgeDatasource.clearBridgesList();
    return;
  }

  @override
  Future<void> addBridge({required Map<String, dynamic> bridge}) async {
    final hiveBridgeDatasource = await HiveBridgeDatasource.getInstance();

    var bridgeHistory = await hiveBridgeDatasource.getBridgeHistory();
    if (bridgeHistory != null) {
      if (bridgeHistory.bridgeList == null) {
        final bridgeList = <Map<String, dynamic>>[bridge];
        bridgeHistory.bridgeList!.addAll(bridgeList);
      } else {
        bridgeHistory = bridgeHistory
            .copyWith(bridgeList: [...bridgeHistory.bridgeList!, bridge]);
      }
      await hiveBridgeDatasource.setBridgeHistory(
        bridgeHistory: bridgeHistory,
      );
    } else {
      await hiveBridgeDatasource.setBridgeHistory(
        bridgeHistory: BridgeHistory(
          bridgeList: <Map<String, dynamic>>[bridge],
        ).toDTO,
      );
    }
  }

  @override
  Future<void> setBridge({required Map<String, dynamic> bridge}) async {
    final hiveBridgeDatasource = await HiveBridgeDatasource.getInstance();

    final bridgeHistory = await hiveBridgeDatasource.getBridgeHistory();
    if (bridgeHistory == null ||
        bridgeHistory.bridgeList == null ||
        bridgeHistory.bridgeList!.isEmpty) {
      throw Exception("Bridge can't be updated in the box");
    }
    final bridgeList = [...?bridgeHistory.bridgeList]
      ..removeWhere(
        (element) => element['timestampExec'] == bridge['timestampExec'],
      )
      ..add(bridge);
    await hiveBridgeDatasource.setBridgeHistory(
      bridgeHistory: bridgeHistory.copyWith(bridgeList: bridgeList),
    );
  }
}

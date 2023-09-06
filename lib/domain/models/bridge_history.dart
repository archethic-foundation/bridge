/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bridge_history.freezed.dart';

@freezed
class BridgeHistory with _$BridgeHistory {
  const factory BridgeHistory({
    List<Map<String, dynamic>>? bridgeList,
  }) = _BridgeHistory;
  const BridgeHistory._();
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_blockchain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BridgeBlockchain _$$_BridgeBlockchainFromJson(Map<String, dynamic> json) =>
    _$_BridgeBlockchain(
      name: json['name'] as String? ?? '',
      chainId: json['chainId'] as int?,
      urlExplorer: json['urlExplorer'] as String? ?? '',
      urlIcon: json['urlIcon'] as String? ?? '',
    );

Map<String, dynamic> _$$_BridgeBlockchainToJson(_$_BridgeBlockchain instance) =>
    <String, dynamic>{
      'name': instance.name,
      'chainId': instance.chainId,
      'urlExplorer': instance.urlExplorer,
      'urlIcon': instance.urlIcon,
    };

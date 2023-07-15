// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_blockchain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BridgeBlockchain _$$_BridgeBlockchainFromJson(Map<String, dynamic> json) =>
    _$_BridgeBlockchain(
      name: json['name'] as String? ?? '',
      chainId: json['chainId'] as int? ?? 0,
      env: json['env'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      urlExplorer: json['urlExplorer'] as String? ?? '',
      providerEndpoint: json['providerEndpoint'] as String? ?? '',
      isArchethic: json['isArchethic'] as bool? ?? false,
    );

Map<String, dynamic> _$$_BridgeBlockchainToJson(_$_BridgeBlockchain instance) =>
    <String, dynamic>{
      'name': instance.name,
      'chainId': instance.chainId,
      'env': instance.env,
      'icon': instance.icon,
      'urlExplorer': instance.urlExplorer,
      'providerEndpoint': instance.providerEndpoint,
      'isArchethic': instance.isArchethic,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bridge_blockchain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BridgeBlockchainImpl _$$BridgeBlockchainImplFromJson(
        Map<String, dynamic> json) =>
    _$BridgeBlockchainImpl(
      name: json['name'] as String? ?? '',
      chainId: (json['chainId'] as num?)?.toInt() ?? 0,
      env: json['env'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      urlExplorerAddress: json['urlExplorerAddress'] as String? ?? '',
      urlExplorerTransaction: json['urlExplorerTransaction'] as String? ?? '',
      urlExplorerChain: json['urlExplorerChain'] as String? ?? '',
      explorerApi: json['explorerApi'] as String? ?? '',
      providerEndpoint: json['providerEndpoint'] as String? ?? '',
      isArchethic: json['isArchethic'] as bool? ?? false,
      nativeCurrency: json['nativeCurrency'] as String? ?? '',
      htlcAddress: json['htlcAddress'] as String?,
      archethicFactoryAddress: json['archethicFactoryAddress'] as String?,
    );

Map<String, dynamic> _$$BridgeBlockchainImplToJson(
        _$BridgeBlockchainImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'chainId': instance.chainId,
      'env': instance.env,
      'icon': instance.icon,
      'urlExplorerAddress': instance.urlExplorerAddress,
      'urlExplorerTransaction': instance.urlExplorerTransaction,
      'urlExplorerChain': instance.urlExplorerChain,
      'explorerApi': instance.explorerApi,
      'providerEndpoint': instance.providerEndpoint,
      'isArchethic': instance.isArchethic,
      'nativeCurrency': instance.nativeCurrency,
      'htlcAddress': instance.htlcAddress,
      'archethicFactoryAddress': instance.archethicFactoryAddress,
    };

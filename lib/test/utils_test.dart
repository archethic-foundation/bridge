// ignore_for_file: avoid_redundant_argument_values

library test.utils_test;

import 'package:aebridge/domain/models/bridge_blockchain.dart';
import 'package:aebridge/domain/models/bridge_token.dart';
import 'package:aebridge/ui/views/bridge/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';
import 'package:webthree/webthree.dart';

void main() {
  group('Other', () {
    test('Test 1', () {
      const amount = 120139.69456927;
      final bigIntValue = Decimal.parse(amount.toString()) *
          Decimal.parse('1000000000000000000');
      final ethAmount =
          EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue.toBigInt());

      expect(ethAmount.getValueInUnit(EtherUnit.ether), amount);
    });
  });

  group('Generate url test Mone', () {
    test('Test 1', () {
      final bridgeFormState = BridgeFormState(
        resumeProcess: true,
        processStep: aedappfm.ProcessStep.confirmation,
        blockchainFrom: BridgeBlockchain.fromJson(
          {
            'name': 'Polygon (PoS)',
            'chainId': 137,
            'env': '1-mainnet',
            'icon': 'Polygon.svg',
            'urlExplorerAddress': 'https://polygonscan.com/address/',
            'urlExplorerTransaction': 'https://polygonscan.com/tx/',
            'urlExplorerChain': 'https://polygonscan.com/address/',
            'providerEndpoint':
                'https://polygon-mainnet.g.alchemy.com/v2/DynWKvz6PUFaeZNmlxPXNiV1nK4Ac_2D',
            'isArchethic': false,
            'nativeCurrency': 'MATIC'
          },
        ),
        blockchainTo: BridgeBlockchain.fromJson(
          {
            'name': 'Archethic',
            'chainId': -1,
            'env': '1-mainnet',
            'icon': 'Archethic.svg',
            'urlExplorerAddress':
                'https://mainnet.archethic.net/explorer/transaction/',
            'urlExplorerTransaction':
                'https://mainnet.archethic.net/explorer/transaction/',
            'urlExplorerChain':
                'https://mainnet.archethic.net/explorer/chain?address=',
            'isArchethic': true,
            'archethicFactoryAddress':
                '0000eeb877e7a3ffd7e81f9a1c4d5eedde7f881866c3154b99b78a9a54e3dfbdccd9',
            'providerEndpoint': 'https://mainnet.archethic.net',
            'nativeCurrency': 'UCO'
          },
        ),
        tokenToBridge: BridgeToken.fromJson(
          {
            'name': 'EURe (Monerium)',
            'symbol': 'EURe',
            'targetTokenName': 'Archethic aeEURe',
            'targetTokenSymbol': 'aeEURe',
            'poolAddressFrom': '0x39C9DBD60B0eAF256Ebc509D2b837d508dD4F2Da',
            'poolAddressTo':
                '0000e12f075156da85fdb175d0899eb84c3ffe8d854d5fa4b01063035aecf16e8777',
            'typeSource': 'Wrapped',
            'typeTarget': 'Wrapped',
            'tokenAddressSource': '0x18ec0A6E18E5bc3784fDd3a3634b31245ab704F6',
            'tokenAddressTarget':
                '0000BC30E877B99FCA564DC07AF6A905EB2A85F6BB01CD270D0B3BAF056303A7759E',
          },
        ),
        tokenToBridgeAmount: 200,
        targetAddress: '0x5ba1d8dc7e0bac18d7dd7664aab59998fc6d3229',
        tokenBridgedBalance: 120,
        tokenToBridgeBalance: 200,
        poolTargetBalance: 0,
        tokenToBridgeDecimals: 8,
        failure: null,
        isTransferInProgress: false,
        walletConfirmation: null,
        bridgeOk: false,
        currentStep: 0,
        changeDirectionInProgress: false,
        timestampExec: null,
        archethicOracleUCO: null,
        archethicProtocolFeesAddress:
            '0000749D250560BF06C079832E0E9A24509B1E440A45C33BD9448B41B6A056FC6201',
        archethicProtocolFeesRate: 0.3,
        archethicTransactionFees: 0,
        safetyModuleFeesAddress: '',
        safetyModuleFeesRate: 0,
        consentDateTime: null,
      );
      final helper = aedappfm.QueryParameterHelper();
      final initialStateEncoded = helper.encodeQueryParameter(bridgeFormState);

      final url = 'bridge?initialState=$initialStateEncoded';
      print(url);
      expect(true, true);
    });
  });
}

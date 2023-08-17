/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:convert';

import 'package:aebridge/application/contracts/archethic_contract.dart';
import 'package:aebridge/application/contracts/lp_erc_contract.dart';
import 'package:aebridge/application/session/provider.dart';
import 'package:aebridge/model/secret.dart';
import 'package:aebridge/ui/views/bridge/bloc/provider.dart';
import 'package:aebridge/util/date_util.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BridgeArchethicToEVMUseCase {
  Future<void> run(
    WidgetRef ref,
    BuildContext context,
  ) async {
    final bridge = ref.watch(BridgeFormProvider.bridgeForm);
    final session = ref.read(SessionProviders.session);
    final walletFrom = session.walletFrom;

    // 1) Deploy Archethic HTLC Contract
    var endTime =
        DateTime.now().add(const Duration(minutes: 720)).millisecondsSinceEpoch;
    endTime = DateUtil().roundToNearestMinute(endTime) ~/ 1000;

    final archethicHTLCAddress = await ArchethicContract().deploySignedHTLC(
      bridge.tokenToBridge!.poolAddressFrom,
      walletFrom!.genesisAddress,
      endTime,
      bridge.tokenToBridgeAmount,
      bridge.tokenToBridge!.tokenAddress,
    );

    debugPrint('htlc contract: $archethicHTLCAddress');

    // 2) Provision Archethic HTLC Contract
    await ArchethicContract().provisionSignedHTLC(
      archethicHTLCAddress!,
      bridge.tokenToBridgeAmount,
    );

    // 3) Get Secret Hash from API
    final secretHashFromFct =
        await sl.get<archethic.ApiService>().callSCFunction(
              jsonRPCRequest: archethic.SCCallFunctionRequest(
                method: 'contract_fun',
                params: archethic.SCCallFunctionParams(
                  contract: archethicHTLCAddress,
                  function: 'get_secret_hash',
                  args: [],
                ),
              ),
            );
    debugPrint('secretHashFromFct: $secretHashFromFct');
    final secretHashMap = jsonDecode(secretHashFromFct);
    final secretHash = SecretHash(
      secretHash: secretHashMap['secret_hash'],
      secretHashSignature: SecretHashSignature(
        r: secretHashMap['secret_hash_signature']['r'],
        s: secretHashMap['secret_hash_signature']['s'],
        v: secretHashMap['secret_hash_signature']['v'],
      ),
    );

    // 4) Deploy EVM HTLC Contract + Provision
    final lpercContract = LPERCContract(bridge.blockchainTo!.providerEndpoint);
    debugPrint(
      'bridge.blockchainTo!.providerEndpoint ${bridge.blockchainTo!.providerEndpoint}',
    );
    debugPrint(
      'bridge.tokenToBridge!.poolAddressTo: ${bridge.tokenToBridge!.poolAddressTo}',
    );
    debugPrint('bridge.blockchainTo!.chainId: ${bridge.blockchainTo!.chainId}');

    final htlcEVMContract = await lpercContract.deployAndProvisionSignedHTLC(
      bridge.tokenToBridge!.poolAddressTo,
      secretHash,
      BigInt.from(bridge.tokenToBridgeAmount),
      chainId: bridge.blockchainTo!.chainId,
    );
    if (htlcEVMContract == null) {
      return;
    }

    // 5) Request Secret from Archethic LP
    await ArchethicContract().requestSecretFromSignedHTLC(
      walletFrom.nameAccount,
      archethicHTLCAddress,
      bridge.tokenToBridge!.poolAddressFrom,
    );

    // 5) Reveal Secret
    final secretFromFct = await sl.get<archethic.ApiService>().callSCFunction(
          jsonRPCRequest: archethic.SCCallFunctionRequest(
            method: 'contract_fun',
            params: archethic.SCCallFunctionParams(
              contract: archethicHTLCAddress,
              function: 'get_secret',
              args: [],
            ),
          ),
        );
    debugPrint('secret: $secretFromFct');
    final secretMap = jsonDecode(secretFromFct);
    final secret = Secret(
      secret: secretMap['secret'],
      secretSignature: SecretSignature(
        r: secretMap['secret_signature']['r'],
        s: secretMap['secret_signature']['s'],
        v: secretMap['secret_signature']['v'],
      ),
    );

    // 6) Reveal Secret EVM (Withdraw)
    await lpercContract.withdrawSignedHTLC(
      htlcEVMContract,
      secret,
      chainId: bridge.blockchainFrom!.chainId,
    );
  }
}

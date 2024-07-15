/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class ArchethicFactory {
  ArchethicFactory(this.factoryAddress);

  final String factoryAddress;

  Future<({double rate, String address})> calculateArchethicProtocolFees(
    ApiService apiService,
  ) async {
    var rate = 0.0;
    var address = '';

    final resultArchethicProtocolFeeRate = await _getProtocolFeeRate(
      apiService,
    );
    await resultArchethicProtocolFeeRate.map(
      success: (archethicProtocolFeeRate) async {
        rate = archethicProtocolFeeRate;
      },
      failure: (failure) {},
    );
    final resultArchethicProtocolFeeAddress =
        await _getProtocolAddress(apiService);
    await resultArchethicProtocolFeeAddress.map(
      success: (archethicProtocolFeeAddress) async {
        address = archethicProtocolFeeAddress;
      },
      failure: (failure) {},
    );
    return (rate: rate, address: address);
  }

  Future<aedappfm.Result<double, aedappfm.Failure>> _getProtocolFeeRate(
    ApiService apiService,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final protocolFeeRate = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_protocol_fee',
              args: [],
            ),
          ),
        );
        try {
          final protocolFeeRateValue = double.parse(protocolFeeRate.toString());
          return protocolFeeRateValue;
        } catch (e) {
          throw const aedappfm.Failure.other(
            cause: 'Protocol fees could not be recovered',
          );
        }
      },
    );
  }

  Future<aedappfm.Result<String, aedappfm.Failure>> _getProtocolAddress(
    ApiService apiService,
  ) async {
    return aedappfm.Result.guard(
      () async {
        final protocolAddress = await apiService.callSCFunction(
          jsonRPCRequest: SCCallFunctionRequest(
            method: 'contract_fun',
            params: SCCallFunctionParams(
              contract: factoryAddress.toUpperCase(),
              function: 'get_protocol_fee_address',
              args: [],
            ),
          ),
        );
        return protocolAddress.toString();
      },
    );
  }
}

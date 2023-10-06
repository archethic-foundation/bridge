/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'package:aebridge/domain/models/failures.dart';
import 'package:aebridge/domain/models/result.dart';
import 'package:aebridge/util/generic/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';

class ArchethicFactory {
  ArchethicFactory(this.factoryAddress);

  final String factoryAddress;

  Future<({double rate, String address})>
      calculateArchethicProtocolFees() async {
    var rate = 0.0;
    var address = '';

    final resultArchethicProtocolFeeRate = await _getProtocolFeeRate();
    await resultArchethicProtocolFeeRate.map(
      success: (archethicProtocolFeeRate) async {
        rate = archethicProtocolFeeRate;
      },
      failure: (failure) {},
    );
    final resultArchethicProtocolFeeAddress = await _getProtocolAddress();
    await resultArchethicProtocolFeeAddress.map(
      success: (archethicProtocolFeeAddress) async {
        address = archethicProtocolFeeAddress;
      },
      failure: (failure) {},
    );
    return (rate: rate, address: address);
  }

  Future<Result<double, Failure>> _getProtocolFeeRate() async {
    return Result.guard(
      () async {
        final protocolFeeRate = await sl.get<ApiService>().callSCFunction(
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
          throw const Failure.other(
            cause: 'Protocol fees could not be recovered',
          );
        }
      },
    );
  }

  Future<Result<String, Failure>> _getProtocolAddress() async {
    return Result.guard(
      () async {
        final protocolAddress = await sl.get<ApiService>().callSCFunction(
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

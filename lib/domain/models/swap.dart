import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap.freezed.dart';

enum SwapProcess { chargeable, signed }

@freezed
class Swap with _$Swap {
  const factory Swap({
    String? htlcContractAddressEVM,
    String? htlcContractAddressAE,
    SwapProcess? swapProcess,
  }) = _Swap;

  const Swap._();
}

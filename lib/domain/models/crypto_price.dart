import 'package:freezed_annotation/freezed_annotation.dart';

part 'crypto_price.freezed.dart';
part 'crypto_price.g.dart';

@freezed
class CryptoPrice with _$CryptoPrice {
  factory CryptoPrice({
    // Used UCIDs
    @Default(0.0) double polygon, // 3890
    @Default(0.0) double ethereum, // 1027
    @Default(0.0) double bsc, // 1839
  }) = _CryptoPrice;

  factory CryptoPrice.fromJson(Map<String, dynamic> json) =>
      _$CryptoPriceFromJson(json);
}

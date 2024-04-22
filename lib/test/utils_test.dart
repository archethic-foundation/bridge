library test.utils_test;

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
}

import 'dart:math';

import 'package:bytebank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Should return value when create a transaction", () {
    var transaction = Transaction(null, 200, null);
    expect(transaction.value, 200);
  });

  test("Should error when create a transaction with value less than zero", () {
    expect(() => Transaction(null, -1, null), throwsAssertionError);
  });
}

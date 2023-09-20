import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> clickTransferFeature(WidgetTester tester) async {
  final transferFeature = find.byWidgetPredicate(
      (widget) => widget is FeatureItem && widget.name == "Transfer");

  expect(transferFeature, findsOneWidget);

  return await tester.tap(transferFeature);
}

import 'dart:math';

import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/contact_dao.dart';
import '../mocks/transaction_web_client.dart';

void main() {
  MockContactDao contactDao;
  TransactionWebClient webClient;

  setUp(() async {
    contactDao = MockContactDao();
    webClient = MockTransactionWebClient();
  });

  group("When Dashboard is open", () {
    testWidgets("Should display main image When dashboard is open",
        (WidgetTester tester) async {
      await tester.pumpWidget(BytebankApp(
        contactDao: contactDao,
        webClient: webClient,
      ));
      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    });

    testWidgets("Should display the transfer feature when dashboard is open ",
        (WidgetTester tester) async {
      await tester.pumpWidget(BytebankApp(contactDao: contactDao));
      final transferFeature =
          find.widgetWithIcon(FeatureItem, Icons.monetization_on);
      expect(transferFeature, findsOneWidget);
    });

    testWidgets("Should display the transaction feature when dashboard is open",
        (WidgetTester tester) async {
      await tester.pumpWidget(BytebankApp(contactDao: contactDao));
      final transactionFeature =
          find.widgetWithText(FeatureItem, "Transaction Feed");
      expect(transactionFeature, findsOneWidget);
    });

    testWidgets("Verificando with widget predicate",
        (WidgetTester tester) async {
      await tester.pumpWidget(BytebankApp(contactDao: contactDao));
      final transferFeatureItem = find.byWidgetPredicate((widget) =>
          widget is FeatureItem &&
          widget.name == "Transfer" &&
          widget.icon == Icons.monetization_on);

      final transactionFeature = find.byWidgetPredicate((widget) =>
          widget is FeatureItem && widget.name == "Transaction Feed");

      expect(transferFeatureItem, findsOneWidget);
      expect(transactionFeature, findsOneWidget);
    });
  });
}

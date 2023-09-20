import 'dart:math';

import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../actions/actions.dart';
import '../mocks/contact_dao.dart';
import '../mocks/transaction_web_client.dart';

void main() {
  testWidgets("Should save contact", (tester) async {
    final mockDao = MockContactDao();
    var webClient = MockTransactionWebClient();

    await tester.pumpWidget(BytebankApp(
      contactDao: mockDao,
      webClient: webClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickTransferFeature(tester);
    await tester.pumpAndSettle();

    final contactList = find.byType(ContactsList);
    expect(contactList, findsOneWidget);

    verify(mockDao.findAll()).called(1);

    final actionButton = find.byType(FloatingActionButton);
    expect(actionButton, findsOneWidget);

    await tester.tap(actionButton);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTexField = find.byWidgetPredicate((widget) =>
        widget is TextField && widget.decoration.labelText == "Full name");
    expect(nameTexField, findsOneWidget);

    final accountTexField = find.byWidgetPredicate((widget) =>
        widget is TextField && widget.decoration.labelText == "Account number");
    expect(accountTexField, findsOneWidget);

    await tester.enterText(nameTexField, "Leonardo Leite");
    await tester.enterText(accountTexField, "123456");

    final createButton = find.widgetWithText(ElevatedButton, "Create");
    expect(createButton, findsOneWidget);

    when(mockDao.save(any)).thenAnswer((_) async => 2);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockDao.save(Contact(0, "Leonardo Leite", 123456)));

    final contactListBack = find.byType(ContactsList);
    expect(contactListBack, findsOneWidget);
    verify(mockDao.findAll()).called(1);
  });
}

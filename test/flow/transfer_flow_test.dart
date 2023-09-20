import 'dart:math';

import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../actions/actions.dart';
import '../mocks/contact_dao.dart';
import '../mocks/transaction_web_client.dart';

void main() {
  ContactDao mockDao;
  Contact mockContact;
  TransactionWebClient webClient;

  //Run before the test starts
  setUp(() async {
    mockDao = MockContactDao();
    mockContact = Contact(0, "Leo", 1234);
    webClient = MockTransactionWebClient();
  });

  // Run when the test finish
  tearDown(() async {});

  testWidgets("Should Transfer to a contact", (tester) async {
    when(mockDao.findAll()).thenAnswer((invocation) async => [mockContact]);

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

    final contactItem = find.byWidgetPredicate(
        (widget) => widget is ContactItem && widget.contact.name == "Leo");

    expect(contactItem, findsOneWidget);

    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final contactName = find.text("Leo");
    expect(contactName, findsOneWidget);

    final accountNumber = find.text("1234");
    expect(accountNumber, findsOneWidget);

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final valueTextField = find.byWidgetPredicate((widget) =>
        widget is TextField && widget.decoration.labelText == "Value");

    expect(valueTextField, findsOneWidget);
    await tester.enterText(valueTextField, '200');

    final transferButton =
        find.byWidgetPredicate((widget) => widget is ElevatedButton);
    expect(transferButton, findsOneWidget);

    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final dialog = find.byType(TransactionAuthDialog);
    expect(dialog, findsOneWidget);
  });
}

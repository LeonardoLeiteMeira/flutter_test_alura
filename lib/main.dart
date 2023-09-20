import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/appDependecies.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'http/webclients/transaction_webclient.dart';

void main() {
  runApp(BytebankApp(
    contactDao: ContactDao(),
    webClient: TransactionWebClient(),
  ));
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient webClient;

  const BytebankApp(
      {Key key, @required this.contactDao, @required this.webClient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      webClient: webClient,
      contactDao: contactDao,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: Dashboard(),
      ),
    );
  }
}

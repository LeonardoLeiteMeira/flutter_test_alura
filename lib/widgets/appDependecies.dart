import 'package:flutter/widgets.dart';

import '../database/dao/contact_dao.dart';
import '../http/webclients/transaction_webclient.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient webClient;

  AppDependencies(
      {@required this.contactDao,
      @required this.webClient,
      @required Widget child})
      : super(child: child);

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) =>
      this.contactDao != oldWidget.contactDao &&
      this.webClient != oldWidget.webClient;
}

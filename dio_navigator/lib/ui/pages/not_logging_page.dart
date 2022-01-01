import 'package:flutter/material.dart';

class NotLoggingPage extends StatelessWidget {
  const NotLoggingPage({Key? key}) : super(key: key);
  static const ValueKey keyPage = ValueKey('not_logging_page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Non sei loggato'),
    ));
  }
}

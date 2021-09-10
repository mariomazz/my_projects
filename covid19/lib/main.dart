import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercovid19/screens/data-covid/data_covid_screen.dart';
import 'package:fluttercovid19/services/data-covid/service_covid.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ServiceDataCovid.create(),
      dispose: (_, ServiceDataCovid service) => service.client.dispose(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green.shade300,
          secondaryHeaderColor: Color.fromRGBO(125, 125, 125, 1),
        ),
        title: 'App',
        debugShowCheckedModeBanner: false,
        home: DataCovidScreen(),
      ),
    );
  }
}

import 'package:dio_navigator2_authentication/core/providers/providers.dart';
import 'package:dio_navigator2_authentication/core/routing/my_route_information_parser.dart';
import 'package:dio_navigator2_authentication/core/routing/my_router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MyProviders().getProviders,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'MY_APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routeInformationParser: MyRouteInformationParser(),
        routerDelegate: MyRouterDelegate(),
      ),
    );
  }
}

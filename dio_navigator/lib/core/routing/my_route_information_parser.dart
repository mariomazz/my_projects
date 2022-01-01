import 'package:flutter/material.dart';

class MyRouteInformationParser implements RouteInformationParser<Object> {
  @override
  Future<Object> parseRouteInformation(
      RouteInformation routeInformation) async {
    return routeInformation;
  }

  @override
  RouteInformation restoreRouteInformation(Object configuration) {
    throw UnimplementedError();
  }
}

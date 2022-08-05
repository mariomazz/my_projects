import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../providers/base_listenable.dart';

class RoutingProvider {
  const RoutingProvider();
  final _initialRoute = "/";

  late final GoRouter _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: _listenable,
    debugLogDiagnostics: true,
    initialLocation: _initialRoute,
    routes: [
      GoRoute(path: "path"),
    ],
    redirect: (state) {
      return null;
    },
  );

  GoRouter get router => _router;

  RouteInformationParser<Object> get parser => _router.routeInformationParser;
  RouterDelegate<Object> get delegate => _router.routerDelegate;
  RouteInformationProvider get provider => _router.routeInformationProvider;

  final _listenable = BaseProvider();
}

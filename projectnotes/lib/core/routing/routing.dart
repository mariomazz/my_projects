import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/pages/home.dart';
import '../../ui/pages/login.dart';
import '../../ui/pages/not_found.dart';
import '../../ui/pages/notes.dart';
import '../../ui/widgets/navigation.dart';
import '../../ui/widgets/page.dart';
import '../authentication/authentication.dart';
import '../providers/base_listenable.dart';
import 'configurations/routes.dart';

class Routing {
  final AuthProvider authProvider;
  Routing({required this.authProvider}) {
    initListeners(authProvider);
  }

  late final GoRouter _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: _listenable,
    debugLogDiagnostics: true,
    initialLocation: Routes.root,
    routes: [
      GoRoute(
        name: Routes.rootN,
        path: Routes.root,
        redirect: (state) => state.namedLocation(Routes.homeN),
      ),
      GoRoute(
        path: '/:screen(${Routes.homeN}|${Routes.notesN})',
        builder: (ctx, state) {
          final String routeName = state.params['screen']!;
          return Navigation(
            routeName: routeName,
            home: const Home(),
            notes: const Notes(),
            homeRouteName: Routes.homeN,
            notesRouteName: Routes.notesN,
            defaultIndex: 0,
            defaultRoute: Routes.homeN,
          );
        },
      ),
      GoRoute(
        name: Routes.homeN,
        path: Routes.home,
        redirect: (state) => state.namedLocation(
          Routes.root,
          params: {"screen": Routes.homeN},
        ),
      ),
      GoRoute(
        name: Routes.notesN,
        path: Routes.notes,
        redirect: (state) => state.namedLocation(
          Routes.root,
          params: {"screen": Routes.notesN},
        ),
      ),
      GoRoute(
        name: Routes.loginN,
        path: Routes.login,
        builder: (ctx, state) {
          return LoginPage();
        },
      ),
    ],
    redirect: (state) {
      final loggedIn = authProvider.isAuth;

      if (loggedIn == false && state.subloc != Routes.login) {
        return state.namedLocation(Routes.loginN);
      }
      if (loggedIn == true && state.subloc == Routes.login) {
        return state.namedLocation(Routes.rootN);
      }

      return null;
    },
    errorBuilder: (ctx, state) {
      return const NotFound();
    },
    errorPageBuilder: (ctx, state) {
      return const PageI(child: NotFound());
    },
  );

  GoRouter get router => _router;

  RouteInformationParser<Object> get parser => router.routeInformationParser;
  RouterDelegate<Object> get delegate => router.routerDelegate;
  RouteInformationProvider get provider => router.routeInformationProvider;

  final _listenable = BaseProvider();

  void initListeners(AuthProvider authProvider) {
    authProvider.addListener(() {
      _listenable.notify();
    });
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:project_model/core/connectivity/provider/connectivity_status_provider.dart';
import 'package:project_model/core/networking_service/api/portici_api/authentiation/portici_authentication_provider.dart';
import 'package:project_model/core/routing/page_model.dart';
import 'package:project_model/core/routing/provider/navigation_provider.dart';
import 'package:project_model/ui/pages/home_page.dart';
import 'package:project_model/ui/pages/pages.dart';
import 'package:project_model/ui/widgets/my_material_page.dart';
import 'package:provider/provider.dart';

class MyRouterDelegate extends RouterDelegate<Object> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "main_navigator");

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final MyPageModel currentPage =
            Provider.of<NavigatorProvider>(context).getPage;

        final isLogged =
            Provider.of<PorticiAutenticationProvider>(context).getIsLogged;

        final bool internetConnectionAvailable =
            Provider.of<ConnectivityStatusProvider>(context).getHasConnection;

        log(currentPage.page.toString());
        log(isLogged.toString());

        return Navigator(
          key: navigatorKey,
          pages:
              createPages(currentPage, isLogged, internetConnectionAvailable),
          onPopPage: (route, result) {
            return route.didPop(result);
          },
        );
      },
    );
  }

  List<Page> createPages(MyPageModel currentPage, bool isLogged,
      bool internetConnectionAvailable) {
    List<Page> pages = [];

    if (currentPage.page == Pages.HOME) {
      pages.add(
        MyMaterialPage(
          child: const HomePage(),
          key: HomePage.keyPage,
        ),
      );
    }

    return pages;
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  Future<bool> popRoute() {
    throw UnimplementedError();
  }

  @override
  void removeListener(VoidCallback listener) {}

  @override
  Future<void> setNewRoutePath(configuration) async {}
}

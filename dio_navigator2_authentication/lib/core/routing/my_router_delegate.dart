import 'dart:developer';
import 'package:dio_navigator2_authentication/core/routing/page_model.dart';
import 'package:dio_navigator2_authentication/core/routing/provider/navigation_provider.dart';
import 'package:dio_navigator2_authentication/ui/pages/home_page.dart';
import 'package:dio_navigator2_authentication/ui/pages/pages.dart';
import 'package:dio_navigator2_authentication/ui/widgets/my_material_page.dart';
import 'package:flutter/material.dart';
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

        log(currentPage.page.toString());

        return Navigator(
          key: navigatorKey,
          pages: createPages(currentPage),
          onPopPage: (route, result) {
            return route.didPop(result);
          },
        );
      },
    );
  }

  List<Page> createPages(MyPageModel currentPage) {
    List<Page> pages = [];

    if (currentPage.page == Pages.HOME) {
      pages.add(
        MyMaterialPage(
          HomePage(),
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

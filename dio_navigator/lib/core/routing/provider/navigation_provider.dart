import 'package:flutter/material.dart';
import 'package:project_model/core/routing/page_model.dart';
import 'package:project_model/ui/pages/pages.dart';

class NavigatorProvider extends ChangeNotifier {
  NavigatorProvider();

  Pages _page = Pages.HOME;

  Object _navigationData = {};

  void setPage(Pages index, {Object data = ''}) {
    this._navigationData = data;
    this._page = index;
    notifyListeners();
  }

  void reset() {
    this._page = Pages.HOME;
    this._navigationData = {};
  }

  MyPageModel get getPage => MyPageModel(page: _page, data: _navigationData);
}

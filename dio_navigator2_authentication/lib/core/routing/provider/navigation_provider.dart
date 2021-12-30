import 'package:dio_navigator2_authentication/core/routing/page_model.dart';
import 'package:dio_navigator2_authentication/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class NavigatorProvider extends ChangeNotifier {
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

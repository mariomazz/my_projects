import 'package:flutter/material.dart';

class BaseProvider with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

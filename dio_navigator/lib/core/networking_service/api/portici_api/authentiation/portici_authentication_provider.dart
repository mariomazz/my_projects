import 'package:flutter/material.dart';
import 'package:project_model/core/networking_service/api/portici_api/authentiation/portici_authentication_service.dart';

class PorticiAutenticationProvider extends ChangeNotifier {
  PorticiAuthenticationService _porticiAuthService =
      PorticiAuthenticationService();

  bool _isLogged = true;
  bool get getIsLogged => _isLogged;

  set setAuth(bool isLogged) {
    this._isLogged = isLogged;
    notifyListeners();
  }

  Future<void> authenticationStatusChange() async =>
      this._isLogged ? await this.logout() : await this.login();

  Future<void> login() async {
    final bool isLogged = await _porticiAuthService.login();
    if (isLogged) {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final bool isNotLogged = await _porticiAuthService.logout();
    if (isNotLogged) {
      notifyListeners();
    }
  }

  Future<bool> refreshToken() async {
    return await _porticiAuthService.refreshToken();
  }
}

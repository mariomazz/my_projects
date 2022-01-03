import 'package:flutter/material.dart';
import 'package:project_model/core/networking_service/api/portici_api/authentiation/portici_authentication_service.dart';

class PorticiAutenticationProvider extends ChangeNotifier {
  final PorticiAuthenticationService _porticiAuthService =
      PorticiAuthenticationService();

  bool _isLogged = true;
  bool get getIsLogged => _isLogged;

  set setAuth(bool isLogged) {
    _isLogged = isLogged;
    notifyListeners();
  }

  String _accessToken = '';

  String get getAccessToken => _accessToken;

  set setAccessToken(String accessToken) {
    _accessToken = accessToken;
  }

  Future<void> authenticationStatusChange() async =>
      _isLogged ? await logout() : await login();

  Future<void> login() async {
    final loginResponse = await _porticiAuthService.login();
    if (loginResponse.item1) {
      setAccessToken = loginResponse.item2!;
      _isLogged = true;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final bool isNotLogged = await _porticiAuthService.logout();
    if (isNotLogged) {
      setAccessToken = '';

      _isLogged = false;
      notifyListeners();
    }
  }

  Future<bool> refreshToken() async {
    final refreshResponse = await _porticiAuthService.refreshToken();
    if (refreshResponse.item2 != null) {
      setAccessToken = refreshResponse.item2!;
    }

    return refreshResponse.item1;
  }
}

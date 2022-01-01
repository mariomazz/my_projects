import 'dart:developer';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:project_model/core/networking_service/api/portici_api/authentiation/login_configurations.dart';
import 'package:project_model/core/storage/secure_storage_configurations.dart';
import 'package:project_model/core/storage/secure_storage_sevice.dart';

class PorticiAuthenticationService {
  final SecureStorageService _secureStorageService = SecureStorageService();
  final LoginPorticiConfigurations _loginPorticiConfiguration =
      LoginPorticiConfigurations();
  final FlutterAppAuth _appAuth = FlutterAppAuth();

  Future<bool> login() async {
    try {
      final AuthorizationTokenResponse? requestLogin =
          await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _loginPorticiConfiguration.getClientId,
          _loginPorticiConfiguration.getRedirectUrl,
          scopes: _loginPorticiConfiguration.getScopes,
          issuer: _loginPorticiConfiguration.getIssuer,
          preferEphemeralSession: false,
          serviceConfiguration:
              _loginPorticiConfiguration.getServiceConfiguration,
          additionalParameters: _loginPorticiConfiguration.getParameter,
        ),
      );

      if (requestLogin != null &&
          requestLogin.accessToken != null &&
          requestLogin.refreshToken != null &&
          requestLogin.accessTokenExpirationDateTime != null &&
          requestLogin.idToken != null) {
        await _secureStorageService.saveTokensIntoDB(
          accessToken: requestLogin.accessToken!,
          refreshToken: requestLogin.refreshToken!,
          expiryDate: requestLogin.accessTokenExpirationDateTime!.toString(),
          idToken: requestLogin.idToken!,
        );
      } else {
        throw Exception(
            'Alcuni parametri non sono arrivati dalla richiesta di LOGIN');
      }
      return true;
    } catch (e) {
      log('ERRORE LOGIN - PORTICI AUTENTICATION SERVICE - $e');
      return false;
    }
  }

  Future<bool> refreshToken() async {
    try {
      final refreshToken = await _secureStorageService
          .getTokenByKey(SecureStorageKeys.DATABASE_KEY_REFRESHTOKEN);

      if (refreshToken == null || refreshToken == '') {
        throw Exception(
            'Nessun refresh token trovato nel database - secure storage');
      }

      final TokenResponse? requestRefreshToken = await _appAuth.token(
        TokenRequest(
          _loginPorticiConfiguration.getClientId,
          _loginPorticiConfiguration.getRedirectUrl,
          discoveryUrl: _loginPorticiConfiguration.getDiscoveryUrl,
          refreshToken: refreshToken,
          scopes: _loginPorticiConfiguration.getScopes,
          additionalParameters: _loginPorticiConfiguration.getParameter,
        ),
      );

      if (requestRefreshToken != null &&
          requestRefreshToken.accessToken != null &&
          requestRefreshToken.refreshToken != null &&
          requestRefreshToken.accessTokenExpirationDateTime != null &&
          requestRefreshToken.idToken != null) {
        await _secureStorageService.saveTokensIntoDB(
          accessToken: requestRefreshToken.accessToken!,
          refreshToken: requestRefreshToken.refreshToken!,
          expiryDate:
              requestRefreshToken.accessTokenExpirationDateTime!.toString(),
          idToken: requestRefreshToken.idToken!,
        );
      } else {
        throw Exception(
            'Alcuni parametri non sono arrivati dalla richiesta di REFRESH_TOKEN');
      }

      return true;
    } catch (e) {
      log('ERRORE REFRESH TOKEN - PORTICI AUTENTICATION SERVICE - $e');
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      final idToken = await _secureStorageService
          .getTokenByKey(SecureStorageKeys.DATABASE_KEY_IDTOKEN);

      if (idToken == null || idToken == '') {
        throw Exception(
            'Nessun access token trovato nel database - secure storage');
      }

      final EndSessionResponse? requestLogout = await _appAuth.endSession(
        EndSessionRequest(
          idTokenHint: idToken,
          postLogoutRedirectUrl:
              _loginPorticiConfiguration.getPostLogoutRedirectUrl,
          serviceConfiguration:
              _loginPorticiConfiguration.getServiceConfiguration,
          additionalParameters: _loginPorticiConfiguration.getParameter,
        ),
      );

      if (requestLogout != null) {
        await _secureStorageService.clearALLtokensIntoDB();
      } else {
        throw Exception('errore Di server , LOGOUT non riuscito');
      }

      return true;
    } catch (e) {
      log('ERRORE LOGOUT - PORTICI AUTENTICATION SERVICE - $e');
      return false;
    }
  }
}

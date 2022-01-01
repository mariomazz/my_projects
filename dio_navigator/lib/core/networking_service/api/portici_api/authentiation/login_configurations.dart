import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:project_model/core/networking_service/api/portici_api/env.dart';

class LoginPorticiConfigurations {
  final String _clientId = 'porticomobileclient';
  final String _redirectUrl = 'it.asf.portici:/oauthredirect';
  final String _issuer =
      'https://login-$porticiApiWorkEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5';

  final List<String> _scopes = <String>[
    'asfappusers',
    'openid',
    'profile',
    'roles',
    'offline_access',
    'portico',
    'asfappcore',
  ];

  final String _discoveryUrl =
      'https://login-$porticiApiWorkEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/.well-known/openid-configuration';

  final String _postLogoutRedirectUrl = 'it.asf.portici:/';

  final AuthorizationServiceConfiguration _serviceConfiguration =
      const AuthorizationServiceConfiguration(
    authorizationEndpoint:
        'https://login-$porticiApiWorkEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/authorize',
    tokenEndpoint:
        'https://login-$porticiApiWorkEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/token',
    endSessionEndpoint:
        'https://login-$porticiApiWorkEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/endsession',
  );
  final Map<String, String> _parameter = {'authorityId': porticiApiAuthorityId};

  String get getClientId => _clientId;
  String get getRedirectUrl => _redirectUrl;
  String get getIssuer => _issuer;
  List<String> get getScopes => _scopes;
  String get getDiscoveryUrl => _discoveryUrl;
  String get getPostLogoutRedirectUrl => _postLogoutRedirectUrl;
  AuthorizationServiceConfiguration get getServiceConfiguration =>
      _serviceConfiguration;

  Map<String, String> get getParameter => _parameter;
}

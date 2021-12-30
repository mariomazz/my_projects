import 'package:dio_navigator2_authentication/core/networking_service/api/portici_api/env.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class LoginPorticiConfigurations {
  final String clientId = 'porticomobileclient';
  final String redirectUrl = 'it.asf.portici:/oauthredirect';
  final String issuer =
      'https://login-$porticiApiWorkEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5';

  final List<String> scopes = <String>[
    'asfappusers',
    'openid',
    'profile',
    'roles',
    'offline_access',
    'portico',
    'asfappcore',
  ];

  final String discoveryUrl =
      'https://login-$porticiApiWorkEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/.well-known/openid-configuration';

  final String postLogoutRedirectUrl = 'it.asf.portici:/';

  final AuthorizationServiceConfiguration serviceConfiguration =
      const AuthorizationServiceConfiguration(
    authorizationEndpoint:
        'https://login-$porticiApiWorkEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/authorize',
    tokenEndpoint:
        'https://login-$porticiApiWorkEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/token',
    endSessionEndpoint:
        'https://login-$porticiApiWorkEnvironmentName.asfweb.it/e5283a46-4b45-4cc6-864a-74063f8cc7b5/connect/endsession',
  );
  final Map<String, String> parameter = {'authorityId': porticiApiAuthorityId};
}

import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:project_model/core/providers/providers.dart';
import 'package:project_model/core/storage/secure_storage_configurations.dart';
import 'package:project_model/core/storage/secure_storage_sevice.dart';

class PorticiApiInterceptors extends Interceptor {
  final SecureStorageService secureStorageService = SecureStorageService();

  @override
  FutureOr<dynamic> onRequest(
      // ignore: avoid_renaming_method_parameters
      RequestOptions request,
      RequestInterceptorHandler handler) async {
    log('REQUEST[${request.method}] => PATH: ${request.path}');

    final String accessToken = porticiAuthProvider.getAccessToken;

    if (accessToken == '') {
      final accessToken = await secureStorageService
          .getTokenByKey(SecureStorageKeys.DATABASE_KEY_ACCESSTOKEN);

      if (accessToken != null) {
        porticiAuthProvider.setAccessToken = accessToken;
        request.headers['Authorization'] = 'Bearer $accessToken';
      }
    } else {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }


    log('HEADERS : ${request.headers}');

    return super.onRequest(request, handler);
  }

  @override
  FutureOr<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log('RESPONSE[${response.statusCode}] => BODY: ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  FutureOr<dynamic> onError(
      DioError err, ErrorInterceptorHandler handler) async {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      if (err.requestOptions.headers['Authorization'] == '' ||
          err.requestOptions.headers['Authorization'] == null) {
        porticiAuthProvider.setAuth = false;
      } else {
        final bool refreshTokenIsUpdate =
            await porticiAuthProvider.refreshToken();
        if (refreshTokenIsUpdate) {
          return await _retryRequest(err.requestOptions);
        } else {
          porticiAuthProvider.setAuth = false;
        }
      }
    }

    return super.onError(err, handler);
  }

  Future<dynamic> _retryRequest(RequestOptions requestOptions) async {
    final Options options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return apiServiceProvider.getApiPortici.dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}

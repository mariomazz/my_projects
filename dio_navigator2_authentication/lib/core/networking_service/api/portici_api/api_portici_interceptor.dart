import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';

class PorticiApiInterceptors extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions request, RequestInterceptorHandler handler) async {
    log('REQUEST[${request.method}] => PATH: ${request.path}');

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

    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {}

    return super.onError(err, handler);
  }

  // ignore: unused_element
  Future<dynamic> _retryRequest() async {}
}

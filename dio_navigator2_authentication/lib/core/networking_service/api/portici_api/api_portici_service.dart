import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_navigator2_authentication/core/networking_service/API/portici_api/api_portici_interceptor.dart';
import 'package:dio_navigator2_authentication/core/networking_service/api/portici_api/env.dart';

class ApiPorticiService {
  // inizialization
  ApiPorticiService() {
    this._dio = Dio()..interceptors.add(PorticiApiInterceptors());
  }

  String baseUrl =
      'https://api-$porticiApiWorkEnvironmentName.smartpa.cloud/portico';

  late Dio _dio;

  Dio get dio => this._dio;
  // end inizialization

  Future<dynamic> getTransaction(
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get<dynamic>(
        '$baseUrl/v1/warnings',
        queryParameters: queryParameters,
      );

      return response.data;
    } catch (e) {
      log('ERRORE GET TRANSACTION : ' + e.toString());
    }
  }
}

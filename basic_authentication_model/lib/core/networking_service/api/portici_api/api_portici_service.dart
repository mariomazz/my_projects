import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:project_model/core/networking_service/api/api_interceptors.dart';
import 'package:project_model/core/networking_service/api/portici_api/env.dart';

class ApiPorticiService {
  // inizialization
  ApiPorticiService() {
    _dio = Dio()..interceptors.add(ApiInterceptors.apiPorticiInterceptors);
  }

  final String _baseUrl =
      'https://api-$porticiApiWorkEnvironmentName.smartpa.cloud/portico';

  late Dio _dio;

  Dio get dio => _dio;
  // end inizialization

  final Options options = Options(headers: {'AuthorityId': porticiApiAuthorityId});

  Future<dynamic> getTransaction(
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get<dynamic>(
        '$_baseUrl/v1/warnings',
        queryParameters: queryParameters,
        options: options,
      );

      return response.data;
    } catch (e) {
      log('ERRORE GET TRANSACTION : ' + e.toString());
    }
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apiservice.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ApiService extends ApiService {
  _$ApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ApiService;

  @override
  Future<Response<dynamic>> uploadFile(http.MultipartFile file) {
    final $url = '/receive-file';
    final $headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final $parts = <PartValue>[PartValueFile<http.MultipartFile>('file', file)];
    final $request = Request('POST', $url, client.baseUrl,
        parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> allFiles() {
    final $url = '/allFiles';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<String>, String>($request);
  }
}

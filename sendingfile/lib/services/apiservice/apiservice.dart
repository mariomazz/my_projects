import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

part 'apiservice.chopper.dart';

@ChopperApi(baseUrl: '/')
abstract class ApiService extends ChopperService {
  @Post(
    headers: {"Content-Type": "application/x-www-form-urlencoded"},
    path: 'receive-file',
  )
  @multipart
  Future<Response> uploadFile(
    @PartFile("file") http.MultipartFile file,
  );

  @Get(path: 'allFiles')
  Future<Response> allFiles();

  static ApiService create() {
    final client = ChopperClient(
      baseUrl: 'http://homeserver-mario.ddns.net:3000',
      services: [
        _$ApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$ApiService(client);
  }
}

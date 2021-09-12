import 'dart:io';

import 'package:AddFile/models/my%20file/my_file.dart';
import 'package:AddFile/services/apiservice/myfile_converter.dart';
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
  Future<Response<List<MyFile>>> allFiles();

  static ApiService create() {
    final client = ChopperClient(
      baseUrl: 'http://homeserver-mario.ddns.net:3000',
      services: [
        _$ApiService(),
      ],
      converter: MyFileConverter(),
      errorConverter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$ApiService(client);
  }
}

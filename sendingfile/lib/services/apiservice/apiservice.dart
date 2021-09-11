import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;

part 'apiservice.chopper.dart';

@ChopperApi(baseUrl: 'receive-file')
abstract class ApiService extends ChopperService {
//send files to server

  @Post(headers: {"Content-Type": "application/x-www-form-urlencoded"})
  @multipart
  Future<Response> uploadFile(
    @PartFile("file") http.MultipartFile file,
  );

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

import 'package:chopper/chopper.dart';
import 'package:fluttercovid19/models/data-covid/covid.dart';
import 'package:fluttercovid19/services/data-covid/model_datacovid_converter.dart';

part 'service_covid.chopper.dart';

@ChopperApi(
    baseUrl:
        '/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json')
abstract class ServiceDataCovid extends ChopperService {
  @Get()
  Future<Response<List<DataCovid>>> getDataCovid();

  static ServiceDataCovid create() {
    final client = ChopperClient(
      baseUrl: 'https://raw.githubusercontent.com',
      services: [
        _$ServiceDataCovid(),
      ],
      converter: ModelDataCovidConverter(),
      errorConverter: JsonConverter(),
    );

    return _$ServiceDataCovid(client);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_covid.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ServiceDataCovid extends ServiceDataCovid {
  _$ServiceDataCovid([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ServiceDataCovid;

  @override
  Future<Response<List<DataCovid>>> getDataCovid() {
    final $url =
        '/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<DataCovid>, DataCovid>($request);
  }
}

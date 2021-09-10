import 'package:json_annotation/json_annotation.dart';

part 'covid.g.dart';

@JsonSerializable()
class DataCovid {
  factory DataCovid.fromJson(Map<String, dynamic> json) =>
      _$DataCovidFromJson(json);

  Map<String, dynamic> toJson() => _$DataCovidToJson(this);

  String data;
  String stato;
  int ricoverati_con_sintomi;
  int terapia_intensiva;
  int totale_ospedalizzati;
  int isolamento_domiciliare;
  int totale_positivi;
  int variazione_totale_positivi;
  int nuovi_positivi;
  int dimessi_guariti;
  int deceduti;

  int totale_casi;
  int tamponi;

  DataCovid(
      {required this.data,
      required this.deceduti,
      required this.dimessi_guariti,
      required this.isolamento_domiciliare,
      required this.nuovi_positivi,
      required this.ricoverati_con_sintomi,
      required this.stato,
      required this.tamponi,
      required this.terapia_intensiva,
      required this.totale_casi,
      required this.totale_ospedalizzati,
      required this.totale_positivi,
      required this.variazione_totale_positivi});
}

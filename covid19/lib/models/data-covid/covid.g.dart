// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCovid _$DataCovidFromJson(Map<String, dynamic> json) {
  return DataCovid(
    data: json['data'] as String,
    deceduti: json['deceduti'] as int,
    dimessi_guariti: json['dimessi_guariti'] as int,
    isolamento_domiciliare: json['isolamento_domiciliare'] as int,
    nuovi_positivi: json['nuovi_positivi'] as int,
    ricoverati_con_sintomi: json['ricoverati_con_sintomi'] as int,
    stato: json['stato'] as String,
    tamponi: json['tamponi'] as int,
    terapia_intensiva: json['terapia_intensiva'] as int,
    totale_casi: json['totale_casi'] as int,
    totale_ospedalizzati: json['totale_ospedalizzati'] as int,
    totale_positivi: json['totale_positivi'] as int,
    variazione_totale_positivi: json['variazione_totale_positivi'] as int,
  );
}

Map<String, dynamic> _$DataCovidToJson(DataCovid instance) => <String, dynamic>{
      'data': instance.data,
      'stato': instance.stato,
      'ricoverati_con_sintomi': instance.ricoverati_con_sintomi,
      'terapia_intensiva': instance.terapia_intensiva,
      'totale_ospedalizzati': instance.totale_ospedalizzati,
      'isolamento_domiciliare': instance.isolamento_domiciliare,
      'totale_positivi': instance.totale_positivi,
      'variazione_totale_positivi': instance.variazione_totale_positivi,
      'nuovi_positivi': instance.nuovi_positivi,
      'dimessi_guariti': instance.dimessi_guariti,
      'deceduti': instance.deceduti,
      'totale_casi': instance.totale_casi,
      'tamponi': instance.tamponi,
    };

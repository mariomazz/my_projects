// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyFile _$MyFileFromJson(Map<String, dynamic> json) {
  return MyFile(
    name: json['nameFile'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$MyFileToJson(MyFile instance) => <String, dynamic>{
      'id': instance.id,
      'nameFile': instance.name,
    };

import 'package:json_annotation/json_annotation.dart';

part 'my_file.g.dart';

@JsonSerializable()
class MyFile {
  factory MyFile.fromJson(Map<String, dynamic> json) => _$MyFileFromJson(json);

  Map<String, dynamic> toJson() => _$MyFileToJson(this);
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'nameFile')
  String name;

  MyFile({required this.name, required this.id});
}

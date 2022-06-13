import 'package:json_annotation/json_annotation.dart';
part 'notes.g.dart';

@JsonSerializable()
class Note {
  static const fromJsonFactory = _$NoteFromJson;
  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
  final String id;
  final String? uid;
  final String? body;
  final String? title;
  final DateTime? updateAt;

  Note({
    required this.id,
    this.uid,
    this.body,
    this.title,
    this.updateAt,
  });
}

/* import 'dart:convert';

class Note {
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

  Note copyWith({
    String? id,
    String? uid,
    String? body,
    String? title,
    DateTime? updateAt,
  }) {
    return Note(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      body: body ?? this.body,
      title: title ?? this.title,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'body': body,
      'title': title,
      'updateAt': updateAt?.toString(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] ?? '',
      uid: map['uid'],
      body: map['body'],
      title: map['title'],
      updateAt:
          map['updateAt'] != null ? DateTime.parse(map['updateAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Note(id: $id, uid: $uid, body: $body, title: $title, updateAt: $updateAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.id == id &&
        other.uid == uid &&
        other.body == body &&
        other.title == title &&
        other.updateAt == updateAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        body.hashCode ^
        title.hashCode ^
        updateAt.hashCode;
  }
} */
class Notes{}

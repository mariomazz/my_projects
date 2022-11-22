// ignore_for_file: annotate_overrides

import 'dart:convert';
import 'notes.dart';

class RapidNotes extends Notes {
  RapidNotes({
    required super.id,
    required super.title,
    required super.body,
    required super.createdAt,
    required super.userId,
  });

  factory RapidNotes.fromMap(Map<String, dynamic> map) {
    return RapidNotes(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      userId: map['userId'] ?? '',
    );
  }

  Notes copyWith({
    String? id,
    String? title,
    String? body,
    DateTime? createdAt,
    String? userId,
  }) {
    return Notes(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt.toString(),
      'userId': userId,
    };
  }

  String toJson() => json.encode(toMap());

  factory RapidNotes.fromJson(String source) =>
      RapidNotes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notes(id: $id, title: $title, body: $body, createdAt: $createdAt, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Notes &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.createdAt == createdAt &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        createdAt.hashCode ^
        userId.hashCode;
  }
}

import 'dart:convert';

class Notes {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  final String userId;
  Notes({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.userId,
  });

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

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) => Notes.fromMap(json.decode(source));

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

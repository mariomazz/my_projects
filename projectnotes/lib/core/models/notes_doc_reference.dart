import 'dart:convert';
import 'notes.dart';

class NotesDocReference {
  final Notes todo;
  final String docId;
  NotesDocReference({
    required this.todo,
    required this.docId,
  });

  NotesDocReference copyWith({
    Notes? todo,
    String? docId,
  }) {
    return NotesDocReference(
      todo: todo ?? this.todo,
      docId: docId ?? this.docId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'todo': todo.toMap(),
      'docId': docId,
    };
  }

  factory NotesDocReference.fromMap(Map<String, dynamic> map) {
    return NotesDocReference(
      todo: Notes.fromMap(map['todo']),
      docId: map['docId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesDocReference.fromJson(String source) =>
      NotesDocReference.fromMap(json.decode(source));

  @override
  String toString() => 'NotesDocReference(todo: $todo, docId: $docId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotesDocReference &&
        other.todo == todo &&
        other.docId == docId;
  }

  @override
  int get hashCode => todo.hashCode ^ docId.hashCode;
}

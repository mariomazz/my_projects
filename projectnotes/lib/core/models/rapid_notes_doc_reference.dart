import 'dart:convert';

import 'rapid_notes.dart';

class RapidNotesDocReference {
  final RapidNotes todo;
  final String docId;
  RapidNotesDocReference({
    required this.todo,
    required this.docId,
  });

  RapidNotesDocReference copyWith({
    RapidNotes? todo,
    String? docId,
  }) {
    return RapidNotesDocReference(
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

  factory RapidNotesDocReference.fromMap(Map<String, dynamic> map) {
    return RapidNotesDocReference(
      todo: RapidNotes.fromMap(map['todo']),
      docId: map['docId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RapidNotesDocReference.fromJson(String source) => RapidNotesDocReference.fromMap(json.decode(source));

  @override
  String toString() => 'RapidNotesDocReference(todo: $todo, docId: $docId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RapidNotesDocReference &&
      other.todo == todo &&
      other.docId == docId;
  }

  @override
  int get hashCode => todo.hashCode ^ docId.hashCode;
}

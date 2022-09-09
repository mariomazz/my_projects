import 'dart:convert';
import 'todos.dart';

class TodosDocReference {
  final Todos todo;
  final String docId;
  TodosDocReference({
    required this.todo,
    required this.docId,
  });

  TodosDocReference copyWith({
    Todos? todo,
    String? docId,
  }) {
    return TodosDocReference(
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

  factory TodosDocReference.fromMap(Map<String, dynamic> map) {
    return TodosDocReference(
      todo: Todos.fromMap(map['todo']),
      docId: map['docId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TodosDocReference.fromJson(String source) =>
      TodosDocReference.fromMap(json.decode(source));

  @override
  String toString() => 'TodosDocReference(todo: $todo, docId: $docId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodosDocReference &&
        other.todo == todo &&
        other.docId == docId;
  }

  @override
  int get hashCode => todo.hashCode ^ docId.hashCode;
}

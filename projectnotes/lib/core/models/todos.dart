import 'dart:convert';

class Todos {
  final String id;
  final int number;
  final String title;
  final String body;
  final TodosState state;
  final DateTime createdAt;
  final String userId;
  Todos({
    required this.id,
    required this.number,
    required this.title,
    required this.body,
    required this.state,
    required this.createdAt,
    required this.userId,
  });

  Todos copyWith({
    String? id,
    int? number,
    String? title,
    String? body,
    TodosState? state,
    DateTime? createdAt,
    String? userId,
  }) {
    return Todos(
      id: id ?? this.id,
      number: number ?? this.number,
      title: title ?? this.title,
      body: body ?? this.body,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'title': title,
      'body': body,
      'state': state.name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'userId': userId,
    };
  }

  factory Todos.fromMap(Map<String, dynamic> map) {
    return Todos(
      id: map['id'] ?? '',
      number: map['number']?.toInt() ?? 0,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      state: TodosState.any.fromString(map['state']),
      createdAt: DateTime.parse(map['createdAt']),
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Todos.fromJson(String source) => Todos.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todos(id: $id, number: $number, title: $title, body: $body, state: $state, createdAt: $createdAt, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todos &&
        other.id == id &&
        other.number == number &&
        other.title == title &&
        other.body == body &&
        other.state == state &&
        other.createdAt == createdAt &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        number.hashCode ^
        title.hashCode ^
        body.hashCode ^
        state.hashCode ^
        createdAt.hashCode ^
        userId.hashCode;
  }
}

enum TodosState {
  any,
  completed,
  inProgress,
}

extension ExTodosState on TodosState {
  TodosState fromString(String value) {
    if (value == TodosState.completed.name) {
      return TodosState.completed;
    }
    if (value == TodosState.inProgress.name) {
      return TodosState.inProgress;
    }

    return TodosState.any;
  }
}

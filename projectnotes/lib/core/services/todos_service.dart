import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todos.dart';
import '../models/todos_doc_reference.dart';

class TodosService {
  static const todosCollection = "todos";
  Stream<List<TodosDocReference>> getAll() {
    return FirebaseFirestore.instance
        .collection(todosCollection)
        .orderBy(
          "createdAt",
          descending: false,
        )
        .snapshots()
        .map<List<TodosDocReference>>(
          (dr) => dr.docs
              .map((e) =>
                  TodosDocReference(docId: e.id, todo: Todos.fromMap(e.data())))
              .toList(),
        );
  }

  Future<void> putTodo(TodosDocReference todoDR) async =>
      await FirebaseFirestore.instance
          .collection(todosCollection)
          .doc(todoDR.docId)
          .set(todoDR.todo.toMap());

  Future<void> addTodo(Todos todo) async {
    await FirebaseFirestore.instance
        .collection(todosCollection)
        .add(todo.toMap());
    return;
  }

  Future<void> delete(String docId) async => await FirebaseFirestore.instance
      .collection(todosCollection)
      .doc(docId)
      .delete();
}

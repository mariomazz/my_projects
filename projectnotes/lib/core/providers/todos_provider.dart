import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todos.dart';
import '../models/todos_doc_reference.dart';

class TodosProvider {
  static const todosCollection = "todos";
  Stream<List<TodosDocReference>> getAll() {
    return FirebaseFirestore.instance
        .collection(todosCollection)
        .snapshots()
        .map<List<TodosDocReference>>((sn) {
      final List<TodosDocReference> todos = [];
      for (var e in sn.docs) {
        final docId = e.id;
        todos.add(
            TodosDocReference(docId: docId, todo: Todos.fromMap(e.data())));
      }
      return todos;
    });
  }

  Future<void> putTodo(TodosDocReference todoDR) async {
    return await FirebaseFirestore.instance
        .collection(todosCollection)
        .doc(todoDR.docId)
        .set(todoDR.todo.toMap());
  }

  Future<void> addTodo(Todos todo) async {
    await FirebaseFirestore.instance
        .collection(todosCollection)
        .add(todo.toMap());
    return;
  }

  Future<void> delete(String docId) async {
    return await FirebaseFirestore.instance
        .collection(todosCollection)
        .doc(docId)
        .delete();
  }
}

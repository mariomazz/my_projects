import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/notes.dart';
import '../models/notes_doc_reference.dart';

class NotesService {
  static const todosCollection = "notes";
  Stream<List<NotesDocReference>> getAll({Object? field}) => FirebaseFirestore
      .instance
      .collection(todosCollection)
      .orderBy(field ?? '', descending: false)
      .snapshots()
      .map<List<NotesDocReference>>(
        (dr) => dr.docs
            .map((e) =>
                NotesDocReference(docId: e.id, todo: Notes.fromMap(e.data())))
            .toList(),
      );

  Future<void> putTodo(NotesDocReference todoDR) async =>
      await FirebaseFirestore.instance
          .collection(todosCollection)
          .doc(todoDR.docId)
          .set(todoDR.todo.toMap());

  Future<void> addTodo(Notes todo) async {
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

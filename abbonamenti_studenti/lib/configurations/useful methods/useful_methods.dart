import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:abbonamenti_studenti/storage/database/database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// unique id   --  int - string --

// with UniqueKey
String idString_() {
  return UniqueKey().toString();
}

int idInt_() {
  return UniqueKey().hashCode;
}
// end with UniqueKey

// with uuid
String idString() {
  return Uuid().v1();
}

int idInt() {
  return Uuid().v1().hashCode;
}
// end with uuid

// end unique id   --  int - string --

// students db

Future<List<Student>> readStudentDB() async {
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();

  final List<Student> students = await database.studentDAO.getAllStudents();

  return students;
}

void deleteSingleStudent(int id) async {
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();

await database.studentDAO.getAllStudents();
}

void deleteAllStudentDB() async {
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();

  await database.studentDAO.getAllStudents();
}
// read students db

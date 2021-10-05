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

  await database.studentDAO.deleteStudentById(id);
}

void deleteAllStudentDB() async {
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();

  await database.studentDAO.deleteStudents();
}

void addStudent(Student student) async {
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();

  await database.studentDAO.insertStudent(student);
}

void addMultipleStudents(List<Student> students) async {
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();

  await database.studentDAO.insertAllStudents(students);
}

void setAllStudents(List<Student> students) async {
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();

  await database.studentDAO.deleteStudents();

  await database.studentDAO.insertAllStudents(students);
}

// end students db

// reset pagamenti

void resetAllPagaments() async {
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();

  final List<Student> students = await database.studentDAO.getAllStudents();

  final List<Student> studentsResetPagaments = students.map((student) {
    return Student(
      id: student.id,
      name: student.name,
      surname: student.surname,
      activeSubscription: 1,
      subscriptionDate: student.subscriptionDate,
      placeOfResidence: student.placeOfResidence,
    );
  }).toList();

  setAllStudents(studentsResetPagaments);
}

// end reset pagamenti

// modifica pagamento studente

void setPagamentStudent(
    {required int id, required bool activeSubscription}) async {
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('database.db').build();

  final Student? oldStudent = await database.studentDAO.getStudentbyId(id);

  await database.studentDAO.deleteStudentById(id);

  if (oldStudent != null) {
    final Student newStudent = Student(
      id: oldStudent.id,
      name: oldStudent.name,
      surname: oldStudent.surname,
      activeSubscription: activeSubscription ? 0 : 1,
      subscriptionDate: oldStudent.subscriptionDate,
      placeOfResidence: oldStudent.placeOfResidence,
    );

    await database.studentDAO.insertStudent(newStudent);
  }
}

// end modifica pagamento studenti

// confirm message

Future<bool?> showConfirmationDialog(BuildContext context, String message) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      );
    },
  );
}

// end confirm message

// warning message
void scaffoldMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(
        milliseconds: 500,
      ),
    ),
  );
}
// end warning message
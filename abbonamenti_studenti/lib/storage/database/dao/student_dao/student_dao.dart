import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:floor/floor.dart';

@dao
abstract class StudentDao {
  @Query('SELECT * FROM Student')
  Future<List<Student>> getAllStudents();

  @Query('SELECT * FROM Student WHERE id=:id')
  Future<Student?> getStudentbyId(int id);

  @Query('DELETE FROM Student')
  Future<void> deleteStudents();

  @Query('DELETE FROM Student WHERE id=:id')
  Future<void> deleteStudentById(int id);

  @insert
  Future<void> insertAllStudents(List<Student> students);
  @insert
  Future<void> insertStudent(Student student);
}

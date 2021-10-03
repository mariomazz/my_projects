import 'dart:async';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:abbonamenti_studenti/storage/database/dao/student_dao/student_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
part 'database.g.dart';

@Database(version: 1, entities: [Student])
abstract class AppDatabase extends FloorDatabase {
  StudentDao get studentDAO;
}

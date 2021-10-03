import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/configurations/useful%20methods/useful_methods.dart';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:abbonamenti_studenti/ui/widgets/app%20bar/app_bar.dart';
import 'package:abbonamenti_studenti/ui/widgets/student%20card/student_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('studenti'),
        backgroundColor: MyColors.colorOne,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                FontAwesomeIcons.user,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Student>>(
        future: readStudentDB(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Student> students = snapshot.data ?? [];

            if (students.isEmpty) {
              return Center(
                child: Text(
                  'nessun elemento presente',
                  style: TextStyle(
                    fontSize: MyFontSize.primaryText,
                  ),
                ),
              );
            } else if (students.isNotEmpty) {
              return listStudents(context, students);
            }
            return Center(
              child: Text(
                'errore non definito',
                style: TextStyle(
                  fontSize: MyFontSize.primaryText,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            Center(
              child: Text(
                'errore\n${snapshot.error}',
                style: TextStyle(
                  fontSize: MyFontSize.primaryText,
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(
              color: MyColors.colorFour,
            ),
          );
        },
      ),
    );
  }

  Widget listStudents(context, List<Student> students) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: () {},
            child: StudentCard(
              student: students[index],
            ),
          ),
        );
      },
      itemCount: students.length,
    );
  }
}

import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/configurations/useful%20methods/useful_methods.dart';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:abbonamenti_studenti/ui/widgets/app%20bar/app_bar.dart';
import 'package:abbonamenti_studenti/ui/widgets/student%20card/student_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClearStudentsScreen extends StatefulWidget {
  const ClearStudentsScreen({Key? key}) : super(key: key);

  @override
  State<ClearStudentsScreen> createState() => _ClearStudentsScreenState();
}

class _ClearStudentsScreenState extends State<ClearStudentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('studenti'),
        backgroundColor: MyColors.colorOne,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () async {
              final bool? delete = await showConfirmationDialog(
                  context, 'eliminare tutti gli studenti?');

              if (delete!) {
                setState(() {
                  deleteAllStudentDB();
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                FontAwesomeIcons.trashAlt,
              ),
            ),
          ),
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
          child: Dismissible(
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Color(0xFFAB2426),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      FontAwesomeIcons.trashAlt,
                      color: Colors.white,
                    ),
                    Text(
                      'Cancella',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            confirmDismiss: (DismissDirection dismissDirection) async {
              return await showConfirmationDialog(
                  context, 'rimuovere questo studente ?');
            },
            onDismissed: (direction) {
              setState(() {
                deleteSingleStudent(students[index].id);
              });
            },
            key: Key(students[index].id.toString()),
            child: Stack(
              children: [
                StudentCard(
                  student: students[index],
                ),
                Positioned(
                  top: -10,
                  right: 0,
                  child: IconButton(
                    onPressed: () async {
                      final bool? delete = await showConfirmationDialog(
                          context, 'eliminare questo studente?');

                      if (delete!) {
                        setState(() {
                          deleteSingleStudent(students[index].id);
                        });
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.userTimes,
                      color: Colors.red.shade300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: students.length,
    );
  }
}

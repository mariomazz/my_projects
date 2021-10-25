import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/configurations/useful%20methods/useful_methods.dart';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:abbonamenti_studenti/ui/widgets/student%20card/student_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Studenti',
            style: TextStyle(
              fontSize: MyFontSize.primaryText,
            ),
          ),
          bottom: TabBar(
            indicatorColor: MyColors.colorFour,
            tabs: [
              Tab(
                child: Text(
                  'In attesa',
                  style: TextStyle(
                    fontSize: MyFontSize.secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Paganti',
                  style: TextStyle(
                    fontSize: MyFontSize.secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.colorOne,
          elevation: 0,
          actions: [
            InkWell(
              onTap: () => Navigator.of(context)
                  .pushNamed("/info")
                  .then((value) => setState(() {})),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(FontAwesomeIcons.ellipsisV),
              ),
            ),
          ],
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            FutureBuilder<List<Student>>(
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
                    final List<Student> inactiveStudents = students
                        .where((student) => student.activeSubscription == 1)
                        .toList();

                    inactiveStudents.sort((a, b) =>
                        a.subscriptionDate.compareTo(b.subscriptionDate));

                    if (inactiveStudents.isNotEmpty) {
                      return listStudents(
                        context,
                        inactiveStudents,
                      );
                    }

                    if (inactiveStudents.isEmpty) {
                      return Center(
                        child: Icon(
                          FontAwesomeIcons.check,
                          color: Colors.lightGreen,
                          size: MyIconSize.bigIcon,
                        ),
                      );
                    }

                    return Center(
                      child: Text(
                        'errore',
                        style: TextStyle(
                          fontSize: MyFontSize.primaryText,
                        ),
                      ),
                    );
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
            FutureBuilder<List<Student>>(
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
                    final List<Student> activeStudents = students
                        .where((student) => student.activeSubscription == 0)
                        .toList();

                    activeStudents.sort((a, b) =>
                        a.subscriptionDate.compareTo(b.subscriptionDate));

                    if (activeStudents.isNotEmpty) {
                      return listStudents(
                        context,
                        activeStudents,
                      );
                    }

                    if (activeStudents.isEmpty) {
                      return Center(
                        child: Icon(
                          FontAwesomeIcons.userClock,
                          color: Colors.grey,
                          size: MyIconSize.bigIcon,
                        ),
                      );
                    }

                    return Center(
                      child: Text(
                        'errore',
                        style: TextStyle(
                          fontSize: MyFontSize.primaryText,
                        ),
                      ),
                    );
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
          ],
        ),
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
            onTap: () => Navigator.of(context)
                .pushNamed('/detail/student', arguments: students[index])
                .then((value) => setState(() {})),
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

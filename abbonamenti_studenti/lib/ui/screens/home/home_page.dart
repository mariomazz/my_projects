import 'dart:convert';
import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:abbonamenti_studenti/ui/widgets/app%20bar/app_bar.dart';
import 'package:abbonamenti_studenti/ui/widgets/student%20card/student_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // cupertino segment control
  Object segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = <int, Widget>{
    0: Text(
      "In attesa",
      style: TextStyle(
        fontSize: MyFontSize.secondaryText,
      ),
    ),
    1: Text(
      "Paganti",
      style: TextStyle(
        fontSize: MyFontSize.secondaryText,
      ),
    ),
  };
  // end cupertino segment control

  // load students
  Future<List<Student>> readJsonStudents(BuildContext context) async {
    final String data = await DefaultAssetBundle.of(context)
        .loadString("assets/file json/students.json");
    final List jsonResult = jsonDecode(data);

    final List<Student> students =
        jsonResult.map((student) => Student.fromJson(student)).toList();

    return students;
  }
  // end load students

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: Text(
          'Studenti',
          style: TextStyle(
            fontSize: MyFontSize.primaryText,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.colorOne,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: CupertinoSlidingSegmentedControl(
              groupValue: segmentedControlGroupValue,
              children: myTabs,
              onValueChanged: (i) {
                setState(
                  () {
                    segmentedControlGroupValue = i!;
                  },
                );
              },
            ),
          ),
          FutureBuilder<List<Student>>(
            future: readJsonStudents(context),
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
                      .where((student) => student.activeSubscription)
                      .toList();

                  final List<Student> inactiveStudents = students
                      .where((student) => !student.activeSubscription)
                      .toList();

                  inactiveStudents.sort((a, b) =>
                      a.subscriptionDate.compareTo(b.subscriptionDate));

                  activeStudents.sort((a, b) =>
                      a.subscriptionDate.compareTo(b.subscriptionDate));

                  if (segmentedControlGroupValue == 0) {
                    return Expanded(
                      child: listStudents(
                        context,
                        inactiveStudents,
                      ),
                    );
                  } else if (segmentedControlGroupValue == 1) {
                    return Expanded(
                      child: listStudents(
                        context,
                        activeStudents,
                      ),
                    );
                  }
                  return Center(
                    child: Text('errore'),
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
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget listStudents(context, List<Student> students) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: StudentCard(
            student: students[index],
          ),
        );
      },
      itemCount: students.length,
    );
  }
}

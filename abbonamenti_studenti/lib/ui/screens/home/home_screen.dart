import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/configurations/useful%20methods/useful_methods.dart';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:abbonamenti_studenti/ui/widgets/app%20bar/app_bar.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.grey[100]!,
            Colors.grey[200]!,
            Colors.grey[300]!,
            Colors.grey[400]!,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
              future: readStudentDB(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final List<Student> students = snapshot.data ?? [];

                  if (students.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          'nessun elemento presente',
                          style: TextStyle(
                            fontSize: MyFontSize.primaryText,
                          ),
                        ),
                      ),
                    );
                  } else if (students.isNotEmpty) {
                    final List<Student> activeStudents = students
                        .where((student) => student.activeSubscription == 0)
                        .toList();

                    final List<Student> inactiveStudents = students
                        .where((student) => student.activeSubscription == 1)
                        .toList();

                    inactiveStudents.sort((a, b) =>
                        a.subscriptionDate.compareTo(b.subscriptionDate));

                    activeStudents.sort((a, b) =>
                        a.subscriptionDate.compareTo(b.subscriptionDate));

                    if (segmentedControlGroupValue == 0 &&
                        inactiveStudents.isNotEmpty) {
                      return Expanded(
                        child: listStudents(
                          context,
                          inactiveStudents,
                        ),
                      );
                    } else if (segmentedControlGroupValue == 1 &&
                        activeStudents.isNotEmpty) {
                      return Expanded(
                        child: listStudents(
                          context,
                          activeStudents,
                        ),
                      );
                    }

                    if (inactiveStudents.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.check,
                            color: Colors.lightGreen,
                            size: MyIconSize.bigIcon,
                          ),
                        ),
                      );
                    }

                    if (activeStudents.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Icon(
                            FontAwesomeIcons.userClock,
                            color: Colors.grey,
                            size: MyIconSize.bigIcon,
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      child: Center(
                        child: Text(
                          'errore',
                          style: TextStyle(
                            fontSize: MyFontSize.primaryText,
                          ),
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: Center(
                      child: Text(
                        'errore non definito',
                        style: TextStyle(
                          fontSize: MyFontSize.primaryText,
                        ),
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

                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: MyColors.colorFour,
                    ),
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

import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:abbonamenti_studenti/ui/widgets/app%20bar/app_bar.dart';
import 'package:abbonamenti_studenti/ui/widgets/student%20card/student_card.dart';
import 'package:flutter/material.dart';

class DetailStudent extends StatelessWidget {
  const DetailStudent({Key? key, required this.student}) : super(key: key);

  final Student student;

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
        appBar: MyAppBar(
          title: Text('${student.name} ${student.surname}'),
          backgroundColor: MyColors.colorOne,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: StudentCard(
                student: student,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

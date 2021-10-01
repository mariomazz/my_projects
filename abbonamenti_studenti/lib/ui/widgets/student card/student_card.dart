import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({Key? key, required this.student}) : super(key: key);
  final Student student;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300.withOpacity(0.5),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex:2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${student.name}\n${student.surname}',
                maxLines: 2,
                style: TextStyle(
                  fontSize: MyFontSize.secondaryText,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${student.placeOfResidence}\n${student.subscriptionDate}',
                maxLines: 2,
                style: TextStyle(
                  fontSize: MyFontSize.secondaryText,
                ),
              ),
            ),
          ),
          student.activeSubscription
              ? Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.check,
                      color: Colors.lightGreen,
                      size: MyIconSize.standard,
                    ),
                  ),
              )
              : Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.exclamation,
                      color: Colors.red.withOpacity(0.5),
                      size: MyIconSize.standard,
                    ),
                  ),
              ),
        ],
      ),
    );
  }
}
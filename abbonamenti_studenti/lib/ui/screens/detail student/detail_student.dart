import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/configurations/useful%20methods/useful_methods.dart';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:abbonamenti_studenti/ui/widgets/app%20bar/app_bar.dart';
import 'package:abbonamenti_studenti/ui/widgets/student%20card/student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailStudent extends StatefulWidget {
  const DetailStudent({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  State<DetailStudent> createState() => _DetailStudentState();
}

class _DetailStudentState extends State<DetailStudent> {
  bool isToggled = false;

  Student? studentOutput;

  @override
  void initState() {
    studentOutput = Student(
      id: widget.student.id,
      name: widget.student.name,
      surname: widget.student.surname,
      activeSubscription: widget.student.activeSubscription,
      subscriptionDate: widget.student.subscriptionDate,
      placeOfResidence: widget.student.placeOfResidence,
    );

    if (widget.student.activeSubscription == 0) {
      isToggled = true;
    } else if (widget.student.activeSubscription == 1) {
      isToggled = false;
    }

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
        appBar: MyAppBar(
          title: Text('${widget.student.name} ${widget.student.surname}'),
          backgroundColor: MyColors.colorOne,
          elevation: 0,
          actions: [
            InkWell(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(FontAwesomeIcons.exclamation),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: StudentCard(
                  student: studentOutput!,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlutterSwitch(
                  height: 40.0,
                  width: 80.0,
                  padding: 16.0,
                  borderRadius: 20.0,
                  activeColor: MyColors.colorTwo,
                  value: isToggled,
                  onToggle: (value) {
                    setState(() {
                      isToggled = value;

                      studentOutput = Student(
                        id: widget.student.id,
                        name: widget.student.name,
                        surname: widget.student.surname,
                        activeSubscription: isToggled ? 0 : 1,
                        subscriptionDate: widget.student.subscriptionDate,
                        placeOfResidence: widget.student.placeOfResidence,
                      );
                    });
                  },
                ),
                isToggled ? Text('pagato') : Text('non pagato'),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: MyColors.colorOne,
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                textStyle: TextStyle(
                  fontSize: MyFontSize.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                setPagamentStudent(
                  id: widget.student.id,
                  activeSubscription:
                      studentOutput!.activeSubscription == 0 ? true : false,
                );

                scaffoldMessage(context, 'salvato');
              },
              child: Text('Salva'),
            ),
          ],
        ),
      ),
    );
  }
}

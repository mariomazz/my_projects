import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/configurations/useful%20methods/useful_methods.dart';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  // text filed controller

  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  TextEditingController residenceController = TextEditingController();

  // end text filed controller

  // switch

  bool isToggled = false;

  // end switch

  @override
  void initState() {
    nameController.addListener(() {});
    surnameController.addListener(() {});
    residenceController.addListener(() {});

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    residenceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('aggiungi studente'),
        backgroundColor: MyColors.colorOne,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
                hintText: 'Inserisci nome',
              ),
              controller: nameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cognome',
                hintText: 'Inserisci cognome',
              ),
              controller: surnameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Residenza',
                hintText: 'inderisci residenza',
              ),
              controller: residenceController,
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
              if (nameController.text != '' &&
                  surnameController.text != '' &&
                  residenceController.text != '') {
                final bool? confirm =
                    await showConfirmationDialog(context, 'inserire studente?');

                if (confirm!) {
                  final Student student = Student(
                    id: idInt(),
                    name: nameController.text,
                    surname: surnameController.text,
                    activeSubscription: isToggled ? 0 : 1,
                    subscriptionDate: DateTime.now().toString(),
                    placeOfResidence: residenceController.text,
                  );
                  addStudent(student);
                  Navigator.of(context).pop();
                }
              }
            },
            child: Text('Inserisci'),
          ),
        ],
      ),
    );
  }
}

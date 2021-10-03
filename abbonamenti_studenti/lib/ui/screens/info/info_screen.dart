import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/configurations/useful%20methods/useful_methods.dart';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:abbonamenti_studenti/storage/database/database.dart';
import 'package:abbonamenti_studenti/ui/widgets/app%20bar/app_bar.dart';
import 'package:abbonamenti_studenti/ui/widgets/info%20card/info%20_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  void addStudent() async {
    final Student student = Student(
      id: idInt(),
      name: 'Mario',
      surname: 'Mazzarelli',
      activeSubscription: 0,
      subscriptionDate: '2020-12-19',
      placeOfResidence: 'Vitulano',
    );

    final AppDatabase database =
        await $FloorAppDatabase.databaseBuilder('database.db').build();

    await database.studentDAO.insertStudent(student);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('menu'),
        backgroundColor: MyColors.colorOne,
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InfoCard(
                text: InkWell(
                  onTap: () => Navigator.of(context).pushNamed('/students'),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'lista studenti',
                      style: TextStyle(
                        fontSize: MyFontSize.secondaryText,
                      ),
                    ),
                  ),
                ),
                icon: InkWell(
                  onTap: () => Navigator.of(context).pushNamed('/students'),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      FontAwesomeIcons.chevronRight,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InfoCard(
                text: InkWell(
                  onTap: () => addStudent(),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'aggiungi studente',
                      style: TextStyle(
                        fontSize: MyFontSize.secondaryText,
                      ),
                    ),
                  ),
                ),
                icon: InkWell(
                  onTap: () => addStudent(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.chevronRight,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InfoCard(
                text: InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed('/clear/students'),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'pulisci lista studenti',
                      style: TextStyle(
                        fontSize: MyFontSize.secondaryText,
                      ),
                    ),
                  ),
                ),
                icon: InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed('/clear/students'),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ),
                    child: Icon(
                      FontAwesomeIcons.chevronRight,
                      color: Colors.red.shade300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

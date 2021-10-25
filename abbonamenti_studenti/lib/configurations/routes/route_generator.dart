import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/models/student/student.dart';
import 'package:abbonamenti_studenti/ui/screens/add%20student/add_student.dart';
import 'package:abbonamenti_studenti/ui/screens/clear%20students/clear_students.dart';
import 'package:abbonamenti_studenti/ui/screens/detail%20student/detail_student.dart';
import 'package:abbonamenti_studenti/ui/screens/home/home_screen.dart';
import 'package:abbonamenti_studenti/ui/screens/info/info_screen.dart';
import 'package:abbonamenti_studenti/ui/screens/students/students_screen.dart';
import 'package:abbonamenti_studenti/ui/widgets/app%20bar/app_bar.dart';
import 'package:abbonamenti_studenti/ui/widgets/navigation%20effect/bouncy_page_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) {
            return HomeScreen();
          },
        );

      case '/detail/student':
        if (args is Student) {
          return BouncyPageRoute(
            widget: DetailStudent(student: args),
          );
        }
        return _errorRoute();

      case '/info':
        return MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) {
            return InfoScreen();
          },
        );
      case '/clear/students':
        return MaterialPageRoute(
          builder: (_) {
            return ClearStudentsScreen();
          },
        );

      case '/students':
        return MaterialPageRoute(
          builder: (_) {
            return StudentsScreen();
          },
        );

      case '/add/students':
        return MaterialPageRoute(
          builder: (_) {
            return AddStudent();
          },
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: MyAppBar(
          title: const Text('error'),
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.colorOne,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Error... ',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'page not found',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

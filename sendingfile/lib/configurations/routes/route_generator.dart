import 'package:AddFile/configurations/constants/constants.dart';
import 'package:AddFile/screens/all%20files/all_files_screen.dart';
import 'package:AddFile/screens/home/home_screen.dart';
import 'package:AddFile/screens/initial%20load/initial_load.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) {
          return InitialLoad();
        });
      case '/home':
        return MaterialPageRoute(builder: (_) {
          return HomeScreen();
        });
      case '/allFiles':
        return MaterialPageRoute(builder: (_) {
          return AllFilesScreen();
        });

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primary,
          automaticallyImplyLeading: false,
          title: Text(
            'page not found',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error... ',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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

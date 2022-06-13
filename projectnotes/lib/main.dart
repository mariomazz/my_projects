import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:routing_gr/routing_gr.dart';
import 'core/routing/routing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ProjectNotes.init();
}

class ProjectNotes extends StatelessWidget {
  const ProjectNotes({Key? key}) : super(key: key);
  static const title = "project_notes";

  static Future<void> init() async {
    await Firebase.initializeApp();
    Routing.init(configurations: EnableRouting.configurations);
    runApp(const ProjectNotes());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      routeInformationParser: Routing().parser,
      routerDelegate: Routing().delegate,
    );
  }
}

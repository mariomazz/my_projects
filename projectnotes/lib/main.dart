import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/routing/routing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProjectNotes());
}

class ProjectNotes extends StatelessWidget {
  const ProjectNotes({Key? key}) : super(key: key);
  final RoutingProvider routing = RoutingProvider();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      routeInformationParser: routing.parser,
      routerDelegate: routing.delegate,
      routeInformationProvider: routing.provider,
    );
  }
}

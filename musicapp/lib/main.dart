import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'ui/screens/home.dart';
import 'ui/theme/custom_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    CustomTheme.theme.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    CustomTheme.theme.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const HomePage(),
      theme: CustomTheme.theme.lightTheme,
      darkTheme: CustomTheme.theme.darkTheme,
      themeMode: CustomTheme.theme.currentTheme,
    );
  }
}

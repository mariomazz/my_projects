import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/firebase/options.dart';
import 'core/providers/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseI.options);
  runApp(const ProviderScope(child: ProjectNotes()));
}

class ProjectNotes extends ConsumerWidget {
  const ProjectNotes({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routing = ref.read(Providers.routing);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'NotoSans'),
      routeInformationParser: routing.parser,
      routerDelegate: routing.delegate,
      routeInformationProvider: routing.provider,
    );
  }
}

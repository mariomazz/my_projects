import 'package:AddFile/configurations/routes/route_generator.dart';
import 'package:AddFile/services/apiservice/apiservice.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

// interceptors
void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    printWarning('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
// end interceptors

void main() {
  _setupLogging();
  runApp(SendFileServer());
}

class SendFileServer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ApiService.create(),
      dispose: (_, ApiService service) => service.client.dispose(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        title: 'Send File Server',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

void printWarning(text) {
  print('\x1B[33m$text\x1B[0m');
}

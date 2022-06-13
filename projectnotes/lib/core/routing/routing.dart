import 'package:extension_methods/extension_methods.dart';
import 'package:routing_gr/routing_gr.dart';
import '../../ui/pages/home.dart';
import '../../ui/pages/login.dart';
import '../../ui/pages/note_detail.dart';
import '../authentication/authentication.dart';

class EnableRouting {
  static final RoutingConfigurations configurations = RoutingConfigurations(
    initialPage: Pages.home.path,
    pages: Pages.values.map((e) => e.path).toList(),
    builder: (page) {
      if (page.equals(Pages.home.path)) {
        return const HomePage();
      }

      if (page.equals(Pages.noteDetail.path)) {
        return const NoteDetail();
      }

      return null;
    },
    setPathUrlStrategy: true,
    connectivityManagement: true,
    authManagement: true,
    authentication: AuthenticationService().controller,
    withoutAuthentication: const LoginPage(),
  );
}

enum Pages { home, noteDetail }

extension ExtendPages on Pages {
  String get path {
    return "/$name";
  }
}

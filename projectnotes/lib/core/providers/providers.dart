import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../authentication/authentication.dart';
import '../routing/routing.dart';
import 'models/user.dart';
import 'todos_provider.dart';

class Providers {
  
  static late final AuthProvider _authProviderIntance;

  static void setAuthProvider(AuthProvider authProvider) {
    _authProviderIntance = authProvider;
  }

  static final routing = Provider.autoDispose<Routing>(
    (ref) {
      final reference = ref.watch(authProvider);
      return Routing(authProvider: reference);
    },
  );

  static final userProvider = Provider.autoDispose<UserData>(
    (ref) {
      final reference = ref.watch(authProvider);
      return UserData(
        displayName: reference.user?.displayName,
        imageUrl: reference.user?.photoURL,
        email: reference.user?.email,
      );
    },
  );

  static final authProvider =
      ChangeNotifierProvider<AuthProvider>((ref) => _authProviderIntance);

  static final todosProvider = Provider((ref) => TodosProvider());

  static final allTodos = StreamProvider((ref) {
    final reference = ref.read(todosProvider);
    return reference.getAll();
  });

}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/authentication/authentication.dart';
import '../../core/providers/providers.dart';
import '../theme/theme.dart';
import '../widgets/main_button.dart';
import '../widgets/pop_up.dart';
import '../widgets/progress.dart';
import '../widgets/text_input.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PopUpController _loadController = PopUpController();

  LoginPage({Key? key}) : super(key: key);

  Future<void> _loginEvent({
    required AuthProvider authProvider,
    required String email,
    required String password,
  }) async {
    await authProvider.login(email: email, password: password);
  }

  Future<void> _onTapLoginButton(AuthProvider authProvider) async {
    _loadController.show();

    final email = _emailController.text;
    final password = _passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      await _loginEvent(
        authProvider: authProvider,
        email: email,
        password: password,
      );
    } else {
      if (kDebugMode) {
        print("Errore credenziali vuote");
      }
    }
    _loadController.close();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.read(Providers.authProvider);
    return PopUp(
      builder: const ProgressWidget(),
      background: Colors.transparent,
      controller: _loadController,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundPrimary,
        body: Column(
          children: [
            TextInput(
              obscureText: false,
              textInputType: TextInputType.emailAddress,
              controller: _emailController,
              labelText: "Email",
            ),
            TextInput(
              obscureText: true,
              textInputType: TextInputType.visiblePassword,
              controller: _passwordController,
              labelText: "Password",
            ),
            Expanded(
              child: Center(
                child: MainButton(
                  onTap: () async => await _onTapLoginButton(authProvider),
                  title: "Login",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

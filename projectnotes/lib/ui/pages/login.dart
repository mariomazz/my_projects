import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectnotes/ui/widgets/spacing.dart';
import '../../core/authentication/authentication.dart';
import '../../core/languages/it_lang.dart';
import '../../core/providers/providers.dart';
import '../theme/theme.dart';
import '../widgets/main_button.dart';
import '../widgets/pop_up.dart';
import '../widgets/progress.dart';
import '../widgets/text.dart';
import '../widgets/text_input.dart';
import '../widgets/toast_notification.dart';

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
      try {
        await _loginEvent(
          authProvider: authProvider,
          email: email,
          password: password,
        );
      } catch (e) {
        _passwordController.clear();
        _loadController.close();
        ShowToast.showToast(ItLang.loginError);
        return;
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
            const Spacing(),
            const TextI(
              title: ItLang.loginLabel,
              size: TextSize.large,
            ),
            const Spacing(),
            TextInput(
              obscureText: false,
              textInputType: TextInputType.emailAddress,
              controller: _emailController,
              labelText: ItLang.emailLabel,
            ),
            TextInput(
              obscureText: true,
              textInputType: TextInputType.visiblePassword,
              controller: _passwordController,
              labelText: ItLang.passwordLabel,
            ),
            Expanded(
              child: Center(
                child: MainButton(
                  onTap: () async => await _onTapLoginButton(authProvider),
                  title: ItLang.loginLabel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

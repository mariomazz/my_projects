import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';
import '../../core/authentication/authentication.dart';
import '../theme/theme.dart';
import '../widgets/padding.dart';
import '../widgets/scaffold.dart';
import '../widgets/text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PopUpController _loadController = PopUpController();
  static const _primaryLabelColor = ThemeCS.primary;

  Future<void> _loginEvent(
      {required String email, required String password}) async {
    await AuthenticationService().login(email: email, password: password);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _loadController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopUp(
      builder: const ProgressCS(color: ThemeCS.white),
      background: Colors.transparent,
      controller: _loadController,
      child: ScaffoldCS(
        appBar: AppBar(
          backgroundColor: _primaryLabelColor,
          elevation: 0,
          title: const Text("Accesso ProjectNotes"),
        ),
        body: Column(
          children: [
            PaddingCS(
              child: TextField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                  fontSize: TextSize.large.value,
                  color: ThemeCS.primaryText,
                ),
                cursorColor: ThemeCS.primaryText,
                decoration: InputDecoration(
                  labelText: "Email ...",
                  labelStyle: TextStyle(
                    fontSize: TextSize.large.value,
                    color: ThemeCS.primaryText,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: _primaryLabelColor),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: _primaryLabelColor),
                  ),
                ),
                controller: _emailController,
              ),
            ),
            PaddingCS(
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(
                  fontSize: TextSize.large.value,
                  color: ThemeCS.primaryText,
                ),
                cursorColor: ThemeCS.primaryText,
                decoration: InputDecoration(
                  labelText: "Password ...",
                  labelStyle: TextStyle(
                    fontSize: TextSize.large.value,
                    color: ThemeCS.primaryText,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: _primaryLabelColor),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: _primaryLabelColor),
                  ),
                ),
                controller: _passwordController,
              ),
            ),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(_primaryLabelColor),
                  ),
                  child: const Text("Login"),
                  onPressed: () async {
                    _loadController.show();

                    final email = _emailController.text;
                    final password = _passwordController.text;
                    if (email.isNotEmpty && password.isNotEmpty) {
                      await _loginEvent(
                        email: email,
                        password: password,
                      );
                    } else {
                      if (kDebugMode) {
                        print("Errore credenziali vuote");
                      }
                    }
                    _loadController.close();

                    _emailController.clear();
                    _passwordController.clear();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

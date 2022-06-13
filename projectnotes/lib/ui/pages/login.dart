import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets/pop_up_builder.dart';
import 'package:widgets/progress.dart';
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
  static const _primaryLabelColor = ThemeCS.primary;

  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginEvent(
      {required String email, required String password}) async {
    await AuthenticationService().login(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCS(
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
                  PopUpBuilder.showLoading(
                    context,
                    builder: const ProgressCS(
                      color: ThemeCS.white,
                    ),
                  );

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
                  if (mounted) {
                    PopUpBuilder.closeLoading(context);
                  }

                  _emailController.clear();
                  _passwordController.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

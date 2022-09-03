import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _initAuthListener();
  }

  User? get user => _user;

  User? _user;

  bool get isAuth {
    return user != null;
  }

  void _initAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen((data) {
      _setUser(data);
    });
  }

  void _setUser(User? user) {
    _user = user;
    updateUI();
  }

  Future<void> login({required String email, required String password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  void updateUI() {
    notifyListeners();
  }
}

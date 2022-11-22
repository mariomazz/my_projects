import 'dart:async';
import 'package:extension_methods/extension_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  static Future<AuthProvider> asyncInit() async {
    final instance = AuthProvider();
    instance._setUser(await instance._fetchUser());
    return instance;
  }

  AuthProvider.init() {
    _initAuthListener();
  }

  AuthProvider() {
    _initAuthListener();
  }

  User? get user => _user;

  User? _user = FirebaseAuth.instance.currentUser;

  bool get isAuth {
    return user != null;
  }

  Future<User?> _fetchUser() async =>
      FirebaseAuth.instance.authStateChanges().toFuture<User?>();

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

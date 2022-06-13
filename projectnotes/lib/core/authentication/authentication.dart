import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationService implements BaseAuthService {
  AuthenticationService._instance() {
    _init();
  }

  static final _singleton = AuthenticationService._instance();

  factory AuthenticationService() {
    return _singleton;
  }

  final StreamController<bool> _authenticationController =
      BehaviorSubject<bool>();

  final StreamController<User?> _userController = BehaviorSubject<User?>();

  StreamController<bool> get controller => _authenticationController;
  StreamController<User?> get userController => _userController;

  User? get user => _user;

  User? _user;

  _init() {
    _userController.stream.listen((event) {
      _user = event;
    });

    FirebaseAuth.instance.authStateChanges().listen((data) {
      _userController.add(data);
      if (data == null) {
        _authenticationController.add(false);
      } else {
        _authenticationController.add(true);
      }
    });
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      if (kDebugMode) {
        print("login error => $e");
      }
    }
  }

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      if (kDebugMode) {
        print("logout error => $e");
      }
    }
  }

  @override
  Future<void> refresh() async {}
}

abstract class BaseAuthService {
  Future<void> logout();
  Future<void> refresh();
}

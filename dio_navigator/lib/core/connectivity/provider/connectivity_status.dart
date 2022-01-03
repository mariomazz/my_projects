import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  late ConnectivityStatus _connectionStatus;

  bool _hasConnection = false;

  ConnectivityStatus get getConnectionStatus => _connectionStatus;

  bool get getHasConnection => _hasConnection;

  ConnectivityProvider() {
    _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      _connectionStatus = _getStatusFromResult(result);

      if (_connectionStatus != ConnectivityStatus.offline) {
        _hasConnection = await _checkConnection();
      } else {
        _hasConnection = false;
      }

      notifyListeners();
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.wiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }
  }

  Future<bool> _checkConnection() async {
    bool hasConnection = false;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    return hasConnection;
  }
}

enum ConnectivityStatus {
  wiFi,
  cellular,
  offline,
}

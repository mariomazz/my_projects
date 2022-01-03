import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityStatusProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  late ConnectivityStatus _connectionStatus;

  ConnectivityStatus get getConnectionStatus => _connectionStatus;

  bool _hasConnection = false;

  bool get getHasConnection => _hasConnection;

  ConnectivityStatusProvider() {
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
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}

enum ConnectivityStatus {
  wiFi,
  cellular,
  offline,
}

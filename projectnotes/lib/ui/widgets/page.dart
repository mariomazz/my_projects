import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PageI<T> extends Page<T> {
  final Widget child;
  const PageI({required this.child});

  @override
  Route<T> createRoute(BuildContext context) {
    final materialPage = MaterialPageRoute<T>(
      settings: this,
      builder: (ctx) {
        return child;
      },
    );
    final cupertinoPage = CupertinoPageRoute<T>(
      settings: this,
      builder: (ctx) {
        return child;
      },
    );
    if (kIsWeb) {
      return materialPage;
    }

    if (Platform.isAndroid) {
      return materialPage;
    }

    if (Platform.isIOS || Platform.isMacOS) {
      return cupertinoPage;
    }

    return materialPage;
  }
}

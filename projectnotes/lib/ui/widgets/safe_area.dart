import 'package:flutter/material.dart';

import '../theme/theme.dart';

class SafeAreaCS extends StatelessWidget {
  const SafeAreaCS({
    Key? key,
    this.color = ThemeCS.white,
    this.child = const SizedBox(),
    this.bottom = false,
  }) : super(key: key);
  final Color? color;
  final Widget child;
  final bool bottom;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SafeArea(
        bottom: bottom,
        child: child,
      ),
    );
  }
}

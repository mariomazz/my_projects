import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'safe_area.dart';

class ScaffoldCS extends StatelessWidget {
  const ScaffoldCS({
    Key? key,
    this.body = const SizedBox(),
    this.appBar,
    this.backgroundColor = ThemeCS.backgroundPrimary,
  }) : super(key: key);
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SafeAreaCS(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar,
        body: body,
      ),
    );
  }
}

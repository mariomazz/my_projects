import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'safe_area.dart';

class ScaffoldI extends StatelessWidget {
  const ScaffoldI({
    Key? key,
    this.body = const SizedBox(),
    this.appBar,
    this.backgroundColor = AppTheme.white,
  }) : super(key: key);
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SafeAreaI(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar,
        body: body,
      ),
    );
  }
}

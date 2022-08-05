import 'package:flutter/material.dart';
import '../theme/theme.dart';

class AppBarCS extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCS({
    Key? key,
    required this.title,
    this.actions = const [],
    this.backgroundColor = ThemeCS.primary,
    this.leading,
  }) : super(key: key);

  final Widget title;
  final List<Widget> actions;
  final Color backgroundColor;
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      backgroundColor: backgroundColor,
      title: title,
      elevation: 0,
      actions: actions,
    );
  }
}

/* import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'text.dart';

class CardCS extends StatelessWidget {
  const CardCS({
    Key? key,
    required this.title,
    this.subtitle,
    this.action,
    this.leading,
    this.radius,
    this.backgroundColor = ThemeCS.color4,
    this.externalPadding = false,
    this.internalPadding = false,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? action;
  final Widget? leading;
  final BorderRadiusGeometry? radius;
  final Color backgroundColor;
  final bool externalPadding;
  final bool internalPadding;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: externalPadding ? const EdgeInsets.all(10) : null,
        child: ListTile(
          contentPadding: internalPadding ? const EdgeInsets.all(10) : null,
          leading: leading,
          trailing: action,
          shape: RoundedRectangleBorder(
            borderRadius: radius ?? BorderRadius.circular(10.0),
          ),
          tileColor: backgroundColor,
          title: TextCS(title: title, size: TextSize.large),
          subtitle: subtitle != null ? TextCS(title: subtitle ?? '') : null,
        ),
      ),
    );
  }
} */

import 'package:flutter/material.dart';

class MyAppBar extends PreferredSize {
  MyAppBar({
    Key? key,
    this.actions,
    this.title,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
    this.elevation,
    this.bottom,
  }) : super(
          key: key,
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            actions: actions,
            title: title,
            backgroundColor: backgroundColor,
            automaticallyImplyLeading: automaticallyImplyLeading,
            elevation: elevation,
            bottom: bottom,
          ),
        );

  PreferredSizeWidget? bottom;
  List<Widget>? actions;
  Widget? title;
  Color? backgroundColor;
  bool automaticallyImplyLeading;
  double? elevation;
}

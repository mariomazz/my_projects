import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSafeArea extends StatelessWidget {
  CustomSafeArea(this.page, {Key? key}) : super(key: key);
  Widget page;
  final Color colorSafeArea = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorSafeArea,
      child: SafeArea(
        child: page,
      ),
    );
  }
}

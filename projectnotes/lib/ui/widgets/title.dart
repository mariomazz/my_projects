import 'package:flutter/material.dart';

class TitleCS extends StatelessWidget {
  const TitleCS({
    Key? key,
    required this.data,
    this.style = const TextStyle(
      fontSize: 35,
    ),
  }) : super(key: key);
  final String data;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}

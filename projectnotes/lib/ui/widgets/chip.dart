/* import 'package:flutter/material.dart';
import 'padding.dart';

class ChipCS extends StatelessWidget {
  const ChipCS({
    Key? key,
    this.backgroundColor = const Color(0xFFFFFFFF),
  }) : super(key: key);

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: backgroundColor,
      avatar: PaddingCS(
        child: CircleAvatar(
          backgroundColor: backgroundColor,
          child: const Text('AB'),
        ),
      ),
      label: const PaddingCS(
        child: Text('Aaron Burr'),
      ),
    );
  }
}
 */
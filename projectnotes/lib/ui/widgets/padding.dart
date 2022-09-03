import 'package:flutter/material.dart';

class PaddingI extends StatelessWidget {
  const PaddingI({Key? key, this.child, this.padding = 8.0}) : super(key: key);
  final Widget? child;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}

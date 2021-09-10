import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  RoundedCard({
    Key? key,
    required this.content,
    this.backgroundColor,
    this.internalPadding,
    this.elevation,
  }) : super(key: key);

  Widget content;
  Color? backgroundColor = Colors.white;
  EdgeInsets? internalPadding = EdgeInsets.all(10);
  double? elevation = 1;
  @override
  Widget build(BuildContext context) {
    var dataLayout = MediaQuery.of(context);

    return Card(
      color: backgroundColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          30 / 375 * dataLayout.size.width,
        ),
      ),
      child: Padding(
        padding: internalPadding ?? EdgeInsets.all(10),
        child: content,
      ),
    );
  }
}

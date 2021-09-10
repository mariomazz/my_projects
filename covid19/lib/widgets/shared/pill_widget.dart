import 'package:flutter/material.dart';

class PillWidget extends StatelessWidget {
  final String text;
  Color? color = Colors.green.shade300;
  Color? colorText = Colors.black;
  EdgeInsets? internalPadding = EdgeInsets.all(10);
  double? textSize = 15;
  void Function()? actions;
  PillWidget(
      {required this.text,
      this.color,
      this.colorText,
      this.internalPadding,
      this.textSize,
      this.actions,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: actions,
      child: Container(
        padding: internalPadding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: colorText,
              fontSize: textSize,
            ),
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}

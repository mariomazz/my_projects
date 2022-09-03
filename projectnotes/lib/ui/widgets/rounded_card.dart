import 'package:flutter/material.dart';

import 'padding.dart';

class RoundedCard extends StatelessWidget {
  const RoundedCard({
    Key? key,
    required this.data,
    this.backgroundColor = Colors.white,
    this.radius = 20.0,
    this.textColor = Colors.black,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 15,
    ),
  }) : super(key: key);

  final String data;
  final Color backgroundColor;
  final double radius;
  final Color textColor;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor == textColor
            ? backgroundColor.withOpacity(0.5)
            : backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: Stack(
        children: [
          IntrinsicHeight(
            child: Column(
              children: [
                PaddingI(
                  child: Text(
                    data,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 17,
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(""),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

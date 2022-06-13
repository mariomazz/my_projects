import 'package:flutter/material.dart';
import 'text.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({
    Key? key,
    required this.elements,
    this.noElements,
  }) : super(key: key);

  final List<Widget> elements;
  final Widget? noElements;

  @override
  Widget build(BuildContext context) {
    if (elements.isNotEmpty) {
      return SizedBox.expand(
        child: ListView.builder(
          itemCount: elements.length,
          itemBuilder: (context, index) {
            return elements.elementAt(index);
          },
        ),
      );
    }
    return SizedBox.expand(
        child: Center(
      child: noElements ??
          TextCS(
            title: "Non ci sono elementi",
          ),
    ));
  }
}

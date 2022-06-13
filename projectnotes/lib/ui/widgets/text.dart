import 'package:extension_methods/extension_methods.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

class TextCS extends StatelessWidget {
  TextCS({
    Key? key,
    required this.title,
    this.style,
    this.size = TextSize.normal,
    this.maxLines = 1,
  }) : super(key: key);

  final String title;
  final TextStyle? style;
  final TextSize size;
  final int maxLines;

  late final _textStyle = TextStyle(
    color: ThemeCS.primaryText,
    fontSize: size.value,
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      title,
      style: style ?? _textStyle,
    );
  }
}

enum TextSize { small, normal, large }

extension TextSizeExtension on TextSize {
  double? get value {
    if (name.equals("small")) {
      return 12.0;
    }
    if (name.equals("normal")) {
      return 17.0;
    }
    if (name.equals("large")) {
      return 22.0;
    }
    return null;
  }
}

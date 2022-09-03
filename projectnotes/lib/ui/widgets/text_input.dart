import 'package:flutter/material.dart';
import 'package:projectnotes/ui/widgets/text.dart';
import '../theme/theme.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType textInputType;
  final bool obscureText;
  final bool autoCorrect;
  final bool enableSuggestions;
  const TextInput({
    Key? key,
    required this.controller,
    required this.labelText,
    this.textInputType = TextInputType.text,
    this.obscureText = true,
    this.autoCorrect = false,
    this.enableSuggestions = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      enableSuggestions: enableSuggestions,
      autocorrect: autoCorrect,
      keyboardType: textInputType,
      style: TextStyle(
        fontSize: TextSize.large.value,
        color: AppTheme.textPrimary,
      ),
      cursorColor: AppTheme.textPrimary,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: TextSize.large.value,
          color: AppTheme.textPrimary,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primary),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primary),
        ),
      ),
      controller: controller,
    );
  }
}

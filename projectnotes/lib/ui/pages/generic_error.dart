import 'package:flutter/material.dart';
import '../../core/languages/it_lang.dart';
import '../widgets/scaffold.dart';
import '../widgets/text.dart';

class GenericError extends StatelessWidget {
  const GenericError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldI(
      body: Center(
        child: TextI(
          title: ItLang.error,
        ),
      ),
    );
  }
}

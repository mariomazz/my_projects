import 'package:flutter/material.dart';
import '../widgets/scaffold.dart';
import '../widgets/text.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldI(
      body: Center(child: TextI(title: "Note")),
    );
  }
}

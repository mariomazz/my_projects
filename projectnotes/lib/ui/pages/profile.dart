import 'package:flutter/material.dart';
import '../widgets/scaffold.dart';
import '../widgets/text.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldI(
      body: TextI(title: "Profilo"),
    );
  }
}

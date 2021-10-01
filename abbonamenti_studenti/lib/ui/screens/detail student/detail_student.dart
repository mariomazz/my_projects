import 'package:abbonamenti_studenti/configurations/constants/constants.dart';
import 'package:abbonamenti_studenti/ui/widgets/app%20bar/app_bar.dart';
import 'package:flutter/material.dart';

class DetailStudent extends StatelessWidget {
  const DetailStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        backgroundColor: MyColors.colorOne,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
    );
  }
}

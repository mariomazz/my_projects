import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  InfoCard({Key? key, required this.text, required this.icon})
      : super(key: key);

  Widget text;
  Widget icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: text,
          ),
          Expanded(
            flex: 1,
            child: icon,
          ),
        ],
      ),
    );
  }
}

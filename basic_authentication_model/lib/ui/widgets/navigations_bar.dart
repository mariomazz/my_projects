import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomNavBar extends StatelessWidget {
  CustomNavBar(this.index, {Key? key}) : super(key: key);
  int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
        ),
      ],
      onTap: (index) {},
    );
  }
}

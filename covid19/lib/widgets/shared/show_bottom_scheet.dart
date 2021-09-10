import 'package:flutter/material.dart';

class BottomScheet {
  static show(
      {required BuildContext context,
      required Widget widget,
      required Color color}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                ),
                child: widget,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

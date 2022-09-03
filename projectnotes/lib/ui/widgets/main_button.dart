import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'size_config.dart';
import 'text.dart';

class MainButton extends StatelessWidget {
  final dynamic Function() onTap;
  final String title;
  final double? height;
  final double? width;
  final double padding;
  const MainButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.height,
    this.width,
    this.padding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              side: BorderSide(
                color: Colors.black,
                width: Sizer.mainBorderSize,
              ),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppTheme.buttonPrimary),
        ),
        onPressed: () async {
          await onTap.call();
        },
        child: TextI(title: title),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Sizer {
  static const _height = 673;
  static const _width = 852;

  static const double drawerMainWidth = 150;
  static const double mainButtonHeight = 45;
  static const double mainBorderSize = 1;

  static double getProportionateScreenHeight(
      BuildContext context, double inputHeight) {
    final MediaQueryData mediaData = MediaQuery.of(context);
    final double screenHeight = mediaData.size.height;
    return (inputHeight / _height) * screenHeight;
  }

  static double getProportionateScreenWidth(
      BuildContext context, double inputWidth) {
    final MediaQueryData mediaData = MediaQuery.of(context);
    final double screenWidth = mediaData.size.width;
    return (inputWidth / _width) * screenWidth;
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'size_config.dart';

class ShowDialog {
  static Future<void> image(BuildContext context, String imageUrl) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SizedBox(
            width: Sizer.getProportionateScreenWidth(context, 300),
            height: Sizer.getProportionateScreenHeight(context, 600),
            child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.fill),
          ),
        );
      },
    );
  }
}

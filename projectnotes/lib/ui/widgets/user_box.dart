import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/providers.dart';
import 'size_config.dart';
import 'spacing.dart';
import 'text.dart';

class UserBox extends ConsumerWidget {
  const UserBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(Providers.userProvider);
    return Column(
      children: [
        if (user.imageUrl != null)
          CachedNetworkImage(
            width: Sizer.getProportionateScreenWidth(context, 50),
            height: Sizer.getProportionateScreenHeight(context, 50),
            fit: BoxFit.fill,
            imageUrl: user.imageUrl!,
          ),
        const Spacing(),
        if (user.displayName != null) TextI(title: user.displayName!),
        if (user.email != null) TextI(title: user.email!),
        const Spacing(),
      ],
    );
  }
}

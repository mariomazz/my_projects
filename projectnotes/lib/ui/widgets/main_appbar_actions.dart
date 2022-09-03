import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/providers/providers.dart';

class MainAppbarActions extends ConsumerWidget {
  const MainAppbarActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.user),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.arrowRightFromBracket),
          onPressed: () async {
            await ref.read(Providers.authProvider).logout();
          },
        ),
      ],
    );
  }
}

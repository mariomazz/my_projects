import 'package:flutter/material.dart';
import '../../core/languages/it_lang.dart';
import '../theme/theme.dart';
import 'app_bar.dart';
import 'main_appbar_actions.dart';
import 'text.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: const [
        Expanded(
          child: AppBarI(
            backgroundColor: AppTheme.primary,
            title: TextI(title: ItLang.mainAppBarTitle),
          ),
        ),
        MainAppbarActions(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

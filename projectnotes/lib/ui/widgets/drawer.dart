import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectnotes/ui/widgets/spacing.dart';
import '../../core/languages/it_lang.dart';
import '../../core/routing/configurations/routes.dart';
import '../theme/theme.dart';
import 'main_button.dart';
import 'size_config.dart';
import 'user_box.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: Sizer.getProportionateScreenWidth(context, Sizer.drawerMainWidth),
      decoration: const BoxDecoration(
        color: AppTheme.primary,
      ),
      child: Column(
        children: [
          const Spacing(),
          const UserBox(),
          const Spacing(),
          MainButton(
            title: ItLang.drawerButtonsTitle[0],
            onTap: () {
              context.goNamed(Routes.homeN);
            },
            width: Sizer.getProportionateScreenWidth(
              context,
              Sizer.drawerMainWidth,
            ),
            height: Sizer.getProportionateScreenHeight(
              context,
              Sizer.mainButtonHeight,
            ),
          ),
          MainButton(
            title: ItLang.drawerButtonsTitle[1],
            onTap: () {
              context.goNamed(Routes.notesN);
            },
            width: Sizer.getProportionateScreenWidth(
              context,
              Sizer.drawerMainWidth,
            ),
            height: Sizer.getProportionateScreenHeight(
              context,
              Sizer.mainButtonHeight,
            ),
          ),
        ],
      ),
    );
  }
}

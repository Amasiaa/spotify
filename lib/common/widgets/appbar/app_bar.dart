// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({
    super.key,
    this.title,
    this.action,
    this.hideBack = false,
  });

  final Widget? title;
  final Widget? action;
  final bool hideBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: title ?? const Text(''),
      actions: [action ?? Container()],
      centerTitle: true,
      leading: hideBack
          ? null
          : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.03)
                      : Colors.black.withOpacity(0.04),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : AppColors.darkGrey,
                ),
              )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

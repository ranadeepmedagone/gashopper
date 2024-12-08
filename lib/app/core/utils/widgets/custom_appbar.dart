import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gashopper/app/core/theme/app_theme.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? actionWidget;
  final Widget? customLeadingWidget;
  final bool showBackButton;
  final bool isTitleCentered;

  const CustomAppBar({
    required this.title,
    this.actionWidget,
    this.customLeadingWidget,
    this.showBackButton = false,
    this.isTitleCentered = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      centerTitle: isTitleCentered,
      leading: customLeadingWidget ??
          (showBackButton
              ? IconButton(
                  tooltip: 'Back',
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: GashopperTheme.black,
                    size: 26,
                  ),
                ).ltrbPadding(12, 0, 0, 0)
              : null),
      automaticallyImplyLeading: false,
      backgroundColor: GashopperTheme.appYellow,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: GashopperTheme.black,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
      actions: [
        if (actionWidget != null) actionWidget!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

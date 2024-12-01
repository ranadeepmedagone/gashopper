import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';
import 'custom_profile.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: <Widget>[
            const ProfileImage(
              imagePath:
                  'https://static.langimg.com/photo/imgsize-29734,msid-63682163/navbharat-times.jpg',
              size: 80,
            ).ltrbPadding(0, 0, 0, 4),
            Text(
              'ranadeepmedagone@gmail.com',
              style: GashopperTheme.fontWeightApplier(
                FontWeight.w600,
                textTheme.bodyMedium!.copyWith(
                  color: GashopperTheme.black,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              '91+ 8074635315',
              style: GashopperTheme.fontWeightApplier(
                FontWeight.w700,
                textTheme.bodyMedium!.copyWith(
                  color: GashopperTheme.black,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(
              color: GashopperTheme.grey1,
            ).ltrbPadding(0, 16, 0, 16),
            _buildDrawerItem('Home', Icons.home, () {
              Get.back();
            }),
            _buildDrawerItem('Shift', Icons.work_history_outlined, () {}),
            _buildDrawerItem('Reports', Icons.edit_document, () {}),
            _buildDrawerItem('Request / Reports', Icons.business, () {}),
            _buildDrawerItem('Settings', Icons.settings, () {}),
            const Spacer(),
            _buildDrawerItem('Logout', Icons.logout, () {}),
          ],
        ),
      ),
    );
  }
}

Widget _buildDrawerItem(String title, IconData icon, Function()? onTap) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: GashopperTheme.black,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: GashopperTheme.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    ),
  ).ltrbPadding(0, 0, 0, 12);
}

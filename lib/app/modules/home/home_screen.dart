import 'package:flutter/material.dart';
import 'package:gashopper/app/core/theme/app_theme.dart';
import 'package:gashopper/app/core/utils/helpers.dart';

import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_navbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: GashopperTheme.appBackGrounColor,
      appBar: CustomAppBar(
        isTitleCentered: true,
        title: 'Business Unit',
        customLeadingWidget: IconButton(
          color: GashopperTheme.black,
          tooltip: 'Menu',
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            size: 28,
          ),
        ).ltrbPadding(8, 0, 0, 0),
      ),
      drawer: const NavDrawer(),
    );
  }
}

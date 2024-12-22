import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/modules/list/list_controller.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_button.dart';
import '../../core/utils/widgets/custom_loader.dart';
import '../../routes/app_pages.dart';
import '../home/home_controller.dart';

class SalesListScreen extends StatelessWidget {
  SalesListScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListController>(builder: (c) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: GashopperTheme.appBackGrounColor,
        appBar: const CustomAppBar(
          isTitleCentered: true,
          title: 'Business Unit',
        ),
        body: c.isCashDropsLoading
            ? const Center(child: CustomLoader())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.mainController.getTypeNmae(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: GashopperTheme.black,
                        ),
                      ).ltrbPadding(0, 0, 0, 8),
                      CustomButton(
                        title: 'Create',
                        customTextStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: GashopperTheme.black,
                        ),
                        customBackgroundColor: GashopperTheme.appBackGrounColor,
                        customBorderSide: Border.all(
                          color: GashopperTheme.black,
                          width: 1.5,
                        ),
                        leftIcon: const Icon(
                          Icons.add,
                          color: GashopperTheme.black,
                          size: 28,
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.createScreen);
                        },
                      ).ltrbPadding(0, 0, 0, 16),
                      const Row(
                        children: [
                          Icon(
                            Icons.history,
                            color: GashopperTheme.black,
                            size: 24,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'History',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: GashopperTheme.black,
                            ),
                          ),
                        ],
                      ).ltrbPadding(0, 0, 0, 16),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: c.cashDropsList.length,
                        itemBuilder: (context, index) {
                          final cashDrop = c.cashDropsList[index];
                          return ListCard(
                            isPending: false,
                            title: cashDrop.description ?? '',
                            value: '\$ ${cashDrop.amount}',
                          ).ltrbPadding(0, 0, 0, 16);
                        },
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}

class ListCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isPending;

  const ListCard({
    super.key,
    required this.title,
    required this.value,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: isPending ? GashopperTheme.grey1.withOpacity(0.5) : GashopperTheme.black,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isPending ? GashopperTheme.grey2 : GashopperTheme.appYellow,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GashopperTheme.fontWeightApplier(
                FontWeight.w700,
                const TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                  color: GashopperTheme.black,
                ),
              ),
            ),
            Text(
              '\$ $value',
              style: GashopperTheme.fontWeightApplier(
                FontWeight.w700,
                const TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                  color: GashopperTheme.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

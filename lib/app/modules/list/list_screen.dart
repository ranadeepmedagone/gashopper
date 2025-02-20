import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_button.dart';
import '../../core/utils/widgets/custom_loader.dart';
import '../../routes/app_pages.dart';
import '../home/home_controller.dart';
import 'list_controller.dart';

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
          title: 'Business Unit',
          isTitleCentered: true,
        ),
        body: (c.isCashDropsLoading ||
                c.isStationRequestsLoading ||
                c.isFuelSalesLoading ||
                c.isExpensesLoading)
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
                      ).ltrbPadding(0, 0, 0, 16),
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
                      // ------------------------------ Cash drops ------------------------------
                      // ------------------------------ Cash drops ------------------------------
                      // ------------------------------ Cash drops ------------------------------
                      if (c.mainController.isOnPressCashDrop && c.cashDropsList.isNotEmpty)
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: c.cashDropsList.length,
                          itemBuilder: (context, index) {
                            final cashDrop = c.cashDropsList[index];
                            return ListCard(
                              isPending: false,
                              title: cashDrop.description ?? '',
                              value: '${cashDrop.amount}',
                            ).ltrbPadding(0, 0, 0, 16);
                          },
                        ),
                      // ------------------------------ Station Requests ------------------------------
                      // ------------------------------ Station Requests ------------------------------
                      // ------------------------------ Station Requests ------------------------------
                      if (c.mainController.isOnPressRequest && c.stationRequestsList.isNotEmpty)
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: c.stationRequestsList.length,
                          itemBuilder: (context, index) {
                            final stationRequest = c.stationRequestsList[index];
                            return ListCard(
                              isPending: false,
                              title: stationRequest.description ?? '',
                              value: '${stationRequest.requestTypeName}',
                            ).ltrbPadding(0, 0, 0, 16);
                          },
                        ),
                      // ------------------------------ Station Reports ------------------------------
                      // ------------------------------ Station Reports ------------------------------
                      // ------------------------------ Station Reports ------------------------------
                      if (c.mainController.isOnPressReports && c.stationReportsList.isNotEmpty)
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: c.stationRequestsList.length,
                          itemBuilder: (context, index) {
                            final stationReport = c.stationReportsList[index];
                            return ListCard(
                              isPending: false,
                              title: stationReport.description ?? '',
                              value: '${stationReport.requestTypeName}',
                            ).ltrbPadding(0, 0, 0, 16);
                          },
                        ),
                      // ------------------------------Fuel Sales ------------------------------
                      // ------------------------------Fuel Sales ------------------------------
                      // ------------------------------Fuel Sales ------------------------------
                      if (c.mainController.isOnPressSales && c.fuelSalesList.isNotEmpty)
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: c.fuelSalesList.length,
                          itemBuilder: (context, index) {
                            final fuelSale = c.fuelSalesList[index];
                            return ListCard(
                              isPending: false,
                              title: fuelSale.fuelTypeId.toString(), // TODO: FUEL NAME
                              value: '${fuelSale.addedAmount}',
                            ).ltrbPadding(0, 0, 0, 16);
                          },
                        ),
                      // ------------------------------ Expenses ------------------------------
                      // ------------------------------ Expenses ------------------------------
                      // ------------------------------ Expenses ------------------------------
                      if (c.mainController.isOnPressExpenses && c.expensesList.isNotEmpty)
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: c.expensesList.length,
                          itemBuilder: (context, index) {
                            final expenses = c.expensesList[index];
                            return ListCard(
                              isPending: false,
                              title: expenses.description ?? '',
                              value: '${expenses.addedAmount}',
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
  final Color? customValueTextColor;
  final Function()? onTap;
  final String? buttonTitle;
  final Function()? onTapButton;

  const ListCard({
    super.key,
    required this.title,
    required this.value,
    this.isPending = false,
    this.customValueTextColor,
    this.buttonTitle,
    this.onTap,
    this.onTapButton,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            color: isPending
                ? GashopperTheme.grey1.withAlphaOpacity(0.5)
                : GashopperTheme.appYellow,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Material(
            color: GashopperTheme.grey2,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onTap: onTap,
              child: Container(
                // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isPending ? GashopperTheme.grey1 : GashopperTheme.appYellow,
                    width: 1.5,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
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
                        ),
                        const Spacer(),
                        Text(
                          value,
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
                    onExpansionChanged: (bool isExpanded) {
                      controller.isExpanded = isExpanded;
                      controller.update();
                    },
                    trailing: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: GashopperTheme.appYellow,
                      ),
                      child: !controller.isExpanded
                          ? const Icon(
                              Icons.keyboard_arrow_right,
                              color: GashopperTheme.black,
                            )
                          : const Icon(
                              Icons.keyboard_arrow_down,
                              color: GashopperTheme.black,
                            ),
                    ),
                    children: [
                      if (buttonTitle != null)
                        Divider(
                          color: GashopperTheme.appYellow.withAlphaOpacity(0.2),
                          thickness: 1,
                          height: 2,
                        ),
                      if (buttonTitle != null)
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                customButtonHeight: 35,
                                title: buttonTitle!,
                                onPressed: onTapButton,
                              ),
                            ),
                          ],
                        ).ltrbPadding(20, 8, 20, 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

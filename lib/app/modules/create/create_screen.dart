import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/data/models/app_inputs.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_button.dart';
import '../../core/utils/widgets/custom_dropdown.dart';
import '../../core/utils/widgets/custom_loader.dart';
import '../../core/utils/widgets/custom_textfield.dart';
import '../home/home_controller.dart';
import 'create_controller.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Get.textTheme;

    return GetBuilder<CreateController>(builder: (c) {
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: GashopperTheme.appBackGrounColor,
        appBar: const CustomAppBar(
          title: 'Business Unit',
          isTitleCentered: true,
        ),
        bottomNavigationBar: Container(
          margin: MediaQuery.of(context).padding.bottom > 12.0
              ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom - 12.0,
                )
              : null,
          height: 80,
          decoration: BoxDecoration(color: GashopperTheme.appBackGrounColor, boxShadow: [
            BoxShadow(
              color: GashopperTheme.grey1.withAlphaOpacity(0.6),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ]),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  title: 'Cancel',
                  customBackgroundColor: GashopperTheme.appBackGrounColor,
                  customBorderSide: Border.all(
                    color: GashopperTheme.black,
                    width: 1.5,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomButton(
                  title: c.mainController.isOnPressRequest
                      ? 'Submit'
                      : c.mainController.isOnPressCashDrop
                          ? 'Drop'
                          : 'Create',
                  onPressed: () {
                    // TODO REFACTOR THIS
                    if (c.mainController.isOnPressCashDrop && !c.isCashDropsCreating) {
                      if (c.cashDropDesController.text.trim().isNotEmpty &&
                          c.cashDropAmountController.text.trim().isNotEmpty) {
                        c.listController.isEditCashDrop
                            ? c.updateCashDrop()
                            : c.createCashDrop();
                      }
                    }
                    if ((c.mainController.isOnPressReports ||
                            c.mainController.isOnPressRequest) &&
                        !c.isStationRequestsOrReportsCreating) {
                      if (c.stationRequestOrReportDesController.text.trim().isNotEmpty) {
                        c.listController.isEditStationRequest
                            ? c.updateStationRequest()
                            : c.createStationRequestOrReport();
                      }
                    }
                    if (c.mainController.isOnPressSales && !c.isSaleCreating) {
                      if (c.selectedSalePayment != null &&
                          c.selectedFuel != null &&
                          c.saleAmountController.text.trim().isNotEmpty) {
                        c.listController.isEditSale ? c.updateSale() : c.createSale();
                      }
                    }
                    if (c.mainController.isOnPressExpenses && !c.isExpensesCreating) {
                      if (c.selectedExpensePayment != null &&
                          c.expensesDesController.text.trim().isNotEmpty &&
                          c.expensesAmountController.text.trim().isNotEmpty) {
                        c.listController.isEditExpense ? c.updateExpense() : c.createExpense();
                      }
                    }
                  },
                ),
              ),
            ],
          ).ltrbPadding(16, 16, 16, 16),
        ),
        body: c.isCashDropsCreating ||
                c.isStationRequestsOrReportsCreating ||
                c.isSaleCreating ||
                c.isExpensesCreating
            ? const Center(child: CustomLoader())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create ${c.mainController.getTypeNmae()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: GashopperTheme.black,
                        ),
                      ).ltrbPadding(0, 0, 0, 16),
                      // ------------------------------ Sales ------------------------------
                      // ------------------------------ Sales ------------------------------
                      // ------------------------------ Sales ------------------------------
                      if (c.mainController.isOnPressSales) ...[
                        const Text(
                          'Fuel type',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: GashopperTheme.black,
                          ),
                        ).ltrbPadding(0, 0, 0, 8),
                        CustomDropdownButton<IdNameRecord>(
                          value: c.selectedFuel,
                          items: c.fuelTypes
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.name ?? '',
                                      style: const TextStyle(
                                        color: GashopperTheme.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          hintText: 'Select fuel type',
                          errorMessage: c.errorMessage,
                          hintStyle: GashopperTheme.fontWeightApplier(
                            FontWeight.w600,
                            const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: GashopperTheme.grey1,
                            ),
                          ),
                          onChanged: (value) {
                            // Handle selection change
                            c.selectedFuel = value;
                            c.update();
                          },
                          onSaved: (value) {
                            // Handle value save
                            c.selectedFuel = value;
                            c.update();
                          },
                          borderRadius: BorderRadius.circular(12),
                          borderColor: c.errorMessage != null
                              ? GashopperTheme.red
                              : GashopperTheme.black,
                          borderWidth: 1.5,
                          padding: const EdgeInsets.all(8),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          dropdownShadow: BoxShadow(
                            color: Colors.grey.withAlphaOpacity(0.4),
                            offset: const Offset(0, 4),
                            blurRadius: 16,
                          ),
                        ).ltrbPadding(0, 0, 0, 16),
                        const Text(
                          'Amout',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: GashopperTheme.black,
                          ),
                        ).ltrbPadding(0, 0, 0, 8),
                        CustomTextField(
                          hintText: 'Enter amount',
                          hintStyle: GashopperTheme.fontWeightApplier(
                            FontWeight.w600,
                            textTheme.bodyMedium!.copyWith(
                              color: GashopperTheme.grey1,
                              fontSize: 14,
                            ),
                          ),
                          borderRadius: 12,
                          borderColor: Colors.grey[400]!,
                          focusedBorderColor: GashopperTheme.appYellow,
                          borderWidth: 1.5,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          controller: c.saleAmountController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                        ).ltrbPadding(0, 0, 0, 16),
                        const Text(
                          'Payment type',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: GashopperTheme.black),
                        ).ltrbPadding(0, 0, 0, 8),
                        CustomDropdownButton<IdNameRecord>(
                          value: c.selectedSalePayment,
                          items: c.paymentTypes
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.name ?? '',
                                      style: const TextStyle(
                                        color: GashopperTheme.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          hintText: 'Select payment type',
                          errorMessage: c.errorMessage,
                          hintStyle: GashopperTheme.fontWeightApplier(
                            FontWeight.w600,
                            const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: GashopperTheme.grey1,
                            ),
                          ),
                          onChanged: (value) {
                            // Handle selection change
                            c.selectedSalePayment = value;
                            c.update();
                          },
                          onSaved: (value) {
                            // Handle value save
                            c.selectedSalePayment = value;
                            c.update();
                          },
                          borderRadius: BorderRadius.circular(12),
                          borderColor: c.errorMessage != null
                              ? GashopperTheme.red
                              : GashopperTheme.black,
                          borderWidth: 1.5,
                          padding: const EdgeInsets.all(8),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          dropdownShadow: BoxShadow(
                            color: Colors.grey.withAlphaOpacity(0.4),
                            offset: const Offset(0, 4),
                            blurRadius: 16,
                          ),
                        ).ltrbPadding(0, 0, 0, 16),
                      ],
                      // ------------------------------ Expenses ------------------------------
                      // ------------------------------ Expenses ------------------------------
                      // ------------------------------ Expenses ------------------------------
                      if (c.mainController.isOnPressExpenses) ...[
                        Text(
                          'Describe',
                          style: GashopperTheme.fontWeightApplier(
                            FontWeight.w700,
                            const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: GashopperTheme.black,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: GashopperTheme.grey1.withAlphaOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: c.expensesDesController,
                            minLines: 3,
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            style: const TextStyle(
                              fontSize: 16,
                              color: GashopperTheme.black,
                            ),
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              fillColor: Colors.transparent,
                              hintText: 'Enter',
                              hintStyle: TextStyle(
                                color: GashopperTheme.grey1,
                              ),
                              alignLabelWithHint: true,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                            ),
                          ),
                        ).ltrbPadding(0, 8, 0, 16),
                        const Text(
                          'Amout',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: GashopperTheme.black,
                          ),
                        ).ltrbPadding(0, 0, 0, 8),
                        CustomTextField(
                          hintText: 'Enter amount',
                          hintStyle: GashopperTheme.fontWeightApplier(
                            FontWeight.w600,
                            textTheme.bodyMedium!.copyWith(
                              color: GashopperTheme.grey1,
                              fontSize: 14,
                            ),
                          ),
                          borderRadius: 12,
                          borderColor: Colors.grey[400]!,
                          focusedBorderColor: GashopperTheme.appYellow,
                          borderWidth: 1.5,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          controller: c.expensesAmountController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                        ).ltrbPadding(0, 0, 0, 16),
                        const Text(
                          'Payment type',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: GashopperTheme.black),
                        ).ltrbPadding(0, 0, 0, 8),
                        CustomDropdownButton<IdNameRecord>(
                          value: c.selectedExpensePayment,
                          items: c.paymentTypes
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.name ?? '',
                                      style: const TextStyle(
                                        color: GashopperTheme.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          hintText: 'Select payment type',
                          errorMessage: c.errorMessage,
                          hintStyle: GashopperTheme.fontWeightApplier(
                            FontWeight.w600,
                            const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: GashopperTheme.grey1,
                            ),
                          ),
                          onChanged: (value) {
                            // Handle selection change
                            c.selectedExpensePayment = value;
                            c.update();
                          },
                          onSaved: (value) {
                            // Handle value save
                            c.selectedExpensePayment = value;
                            c.update();
                          },
                          borderRadius: BorderRadius.circular(12),
                          borderColor: c.errorMessage != null
                              ? GashopperTheme.red
                              : GashopperTheme.black,
                          borderWidth: 1.5,
                          padding: const EdgeInsets.all(8),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          dropdownShadow: BoxShadow(
                            color: Colors.grey.withAlphaOpacity(0.4),
                            offset: const Offset(0, 4),
                            blurRadius: 16,
                          ),
                        ).ltrbPadding(0, 0, 0, 16),
                      ],
                      // ------------------------------ Cash drops ------------------------------
                      // ------------------------------ Cash drops ------------------------------
                      // ------------------------------ Cash drops ------------------------------
                      if (c.mainController.isOnPressCashDrop) ...[
                        Text(
                          'Describe',
                          style: GashopperTheme.fontWeightApplier(
                            FontWeight.w700,
                            const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: GashopperTheme.black,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: GashopperTheme.grey1.withAlphaOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: c.cashDropDesController,
                            minLines: 3,
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            style: const TextStyle(
                              fontSize: 16,
                              color: GashopperTheme.black,
                            ),
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              fillColor: Colors.transparent,
                              hintText: 'Enter',
                              hintStyle: TextStyle(
                                color: GashopperTheme.grey1,
                              ),
                              alignLabelWithHint: true,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                            ),
                          ),
                        ).ltrbPadding(0, 8, 0, 16),
                        const Text(
                          'Amout',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: GashopperTheme.black,
                          ),
                        ).ltrbPadding(0, 0, 0, 8),
                        CustomTextField(
                          hintText: 'Enter amount',
                          hintStyle: GashopperTheme.fontWeightApplier(
                            FontWeight.w600,
                            textTheme.bodyMedium!.copyWith(
                              color: GashopperTheme.grey1,
                              fontSize: 14,
                            ),
                          ),
                          borderRadius: 12,
                          borderColor: Colors.grey[400]!,
                          focusedBorderColor: GashopperTheme.appYellow,
                          borderWidth: 1.5,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          controller: c.cashDropAmountController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                        ).ltrbPadding(0, 0, 0, 16),
                      ],
                      // ------------------------------ Request ------------------------------
                      // ------------------------------ Request ------------------------------
                      // ------------------------------ Request ------------------------------
                      if (c.mainController.isOnPressRequest ||
                          c.mainController.isOnPressReports) ...[
                        Text(
                          'Request Type',
                          style: GashopperTheme.fontWeightApplier(
                            FontWeight.w700,
                            const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: GashopperTheme.black,
                            ),
                          ),
                        ).ltrbPadding(0, 0, 0, 8),
                        CustomDropdownButton<IdNameRecord>(
                          value: c.selectedRequestOrReport,
                          items: c.requestTypes
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e.name ?? '',
                                      style: const TextStyle(
                                        color: GashopperTheme.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          hintText: 'Select request type',
                          errorMessage: c.errorMessage,
                          hintStyle: GashopperTheme.fontWeightApplier(
                            FontWeight.w600,
                            const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: GashopperTheme.grey1,
                            ),
                          ),
                          onChanged: (value) {
                            // Handle selection change
                            c.selectedRequestOrReport = value;
                            c.update();
                          },
                          onSaved: (value) {
                            // Handle value save
                            c.selectedRequestOrReport = value;
                            c.update();
                          },
                          borderRadius: BorderRadius.circular(12),
                          borderColor: c.errorMessage != null
                              ? GashopperTheme.red
                              : GashopperTheme.black,
                          borderWidth: 1.5,
                          padding: const EdgeInsets.all(8),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          dropdownShadow: BoxShadow(
                            color: Colors.grey.withAlphaOpacity(0.4),
                            offset: const Offset(0, 4),
                            blurRadius: 16,
                          ),
                        ).ltrbPadding(0, 0, 0, 16),
                        Text(
                          'Describe',
                          style: GashopperTheme.fontWeightApplier(
                            FontWeight.w700,
                            const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: GashopperTheme.black,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: GashopperTheme.grey1.withAlphaOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: c.stationRequestOrReportDesController,
                            minLines: 3,
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            style: const TextStyle(
                              fontSize: 16,
                              color: GashopperTheme.black,
                            ),
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                              fillColor: Colors.transparent,
                              hintText: 'Enter',
                              hintStyle: TextStyle(
                                color: GashopperTheme.grey1,
                              ),
                              alignLabelWithHint: true,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                            ),
                          ),
                        ).ltrbPadding(0, 8, 0, 16),
                        Text(
                          'Add photo',
                          style: GashopperTheme.fontWeightApplier(
                            FontWeight.w700,
                            const TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.5,
                              color: GashopperTheme.black,
                            ),
                          ),
                        ).ltrbPadding(0, 0, 0, 8),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                title: 'Camera / Gallery',
                                onPressed: () {},
                                leftIcon: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: GashopperTheme.black,
                                  size: 26,
                                ).ltrbPadding(8, 0, 24, 0),
                                rightIcon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: GashopperTheme.black,
                                  size: 18,
                                ),
                                isLeftIcon: true,
                                isRightIconEnd: true,
                              ).ltrbPadding(0, 0, 0, 16),
                            ),
                          ],
                        )
                      ],
                    ],
                  ),
                ),
              ),
      );
    });
  }
}

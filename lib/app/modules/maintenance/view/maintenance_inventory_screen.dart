import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/core/utils/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_dropdown.dart';
import '../../../core/utils/widgets/custom_loader.dart';
import '../../../data/models/app_inputs.dart';
import '../controller/maintenance_controller.dart';

class MaintenanceInventoryScreen extends StatefulWidget {
  const MaintenanceInventoryScreen({super.key});

  @override
  State<MaintenanceInventoryScreen> createState() => _MaintenanceInventoryScreenState();
}

class _MaintenanceInventoryScreenState extends State<MaintenanceInventoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);

    // final textTheme = Get.textTheme;

    return GetBuilder<MaintenanceController>(
      builder: (controller) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: GashopperTheme.appBackGrounColor,
          appBar: const CustomAppBar(
            showBackButton: true,
            title: 'Business Unit',
            isTitleCentered: true,
          ),
          body: controller.isInventoryListLoading
              ? const Center(child: CustomLoader())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Inventory',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: GashopperTheme.black,
                          ),
                        ).ltrbPadding(0, 0, 0, 16),
                        SizedBox(
                          height: 45.0,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              fillColor: GashopperTheme.grey2,
                              hintText: 'Search',
                              hintStyle: const TextStyle(fontSize: 16),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                tooltip: "Search",
                                icon: const Icon(
                                  Icons.search,
                                  color: Color(0xff6C6C6C),
                                  size: 24,
                                ),
                                onPressed: () {
                                  // Implement search functionality
                                },
                              ),
                            ),
                          ),
                        ).ltrbPadding(0, 0, 0, 16),
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: GashopperTheme.grey2,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomButton(
                                customButtonHeight: 30,
                                title: 'Add Invetory',
                                customTextStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: GashopperTheme.black,
                                ),
                                customBackgroundColor: GashopperTheme.appBackGrounColor,
                                customBorderSide: Border.all(
                                  color: GashopperTheme.black,
                                  width: 1,
                                ),
                                leftIcon: const Icon(
                                  Icons.add,
                                  color: GashopperTheme.black,
                                  size: 20,
                                ),
                                onPressed: () {
                                  controller.editInventory = false;

                                  _showEditDialog(
                                    context,
                                    null,
                                    controller,
                                  );
                                },
                              ).ltrbPadding(0, 0, 0, 8),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Item Name',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                        color: GashopperTheme.black,
                                      ),
                                    ),
                                    const Text(
                                      'Count',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                        color: GashopperTheme.black,
                                      ),
                                    ).ltrbPadding(0, 0, 40, 0),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Scrollbar(
                                  controller: _scrollController,
                                  thumbVisibility: true,
                                  thickness: 6.0,
                                  radius: const Radius.circular(4),
                                  child: SingleChildScrollView(
                                    controller: _scrollController,
                                    child: Column(
                                      children: [
                                        controller.inventoryHistory.isNotEmpty
                                            ? ListView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller.stationInventories.length,
                                                itemBuilder: (context, index) {
                                                  final stationInventory =
                                                      controller.stationInventories[index];
                                                  return InventoryItem(
                                                    name: stationInventory.name ?? '',
                                                    count: stationInventory.currentCount
                                                        .toString(),
                                                    onTap: () {
                                                      _showEditDialog(
                                                        context,
                                                        stationInventory,
                                                        controller,
                                                      );
                                                    },
                                                  ).ltrbPadding(0, 0, 12, 8);
                                                },
                                              )
                                            : Center(
                                                child: const Text('No inventory data available')
                                                    .ltrbPadding(0, mQ.size.height / 10, 0, 0),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).ltrbPadding(0, 0, 0, 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'History',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                color: GashopperTheme.black,
                              ),
                            ).ltrbPadding(0, 0, 0, 16),
                            const HistoryItem(totalSale: '11/10', name: 'Fuel', count: '234')
                                .ltrbPadding(0, 0, 0, 8),
                            const HistoryItem(totalSale: '11/10', name: 'Ultra', count: '4343')
                                .ltrbPadding(0, 0, 0, 8),
                            const HistoryItem(
                                    totalSale: '11/10', name: 'Diesel', count: '65456')
                                .ltrbPadding(0, 0, 0, 8),
                            const HistoryItem(totalSale: '11/10', name: 'Oil', count: '124214')
                                .ltrbPadding(0, 0, 0, 8),
                            const HistoryItem(
                                    totalSale: '11/10', name: 'Antifreeze', count: '42')
                                .ltrbPadding(0, 0, 0, 8),
                            const HistoryItem(totalSale: '11/10', name: 'Def', count: '4')
                                .ltrbPadding(0, 0, 0, 8),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  void _showEditDialog(
    BuildContext context,
    StationInventory? stationInventory,
    MaintenanceController controller,
  ) {
    controller.countController = TextEditingController(
      text: stationInventory?.currentCount.toString(),
    );

    final textTheme = Get.textTheme;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.editInventory ? 'Edit Inventory' : 'Add Inventory',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Colors.black,
                ),
              ).ltrbPadding(0, 0, 0, 24),
              if (!controller.editInventory)
                const Text(
                  'Inventory Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: Colors.black,
                  ),
                ).ltrbPadding(0, 0, 0, 8),
              if (!controller.editInventory)
                CustomTextField(
                  hintText: 'Inventory Name',
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  controller: controller.inventoryNameController,
                  // keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ).ltrbPadding(0, 0, 0, 16),
              const Text(
                'Count',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Colors.black,
                ),
              ).ltrbPadding(0, 0, 0, 8),
              Row(
                children: [
                  if (controller.editInventory)
                    Text(
                      stationInventory?.name ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: Colors.black,
                      ),
                    ),
                  if (controller.editInventory) const SizedBox(width: 24),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        int currentValue = int.tryParse(controller.countController.text) ?? 0;
                        if (currentValue > 0) {
                          controller.countController.text = (currentValue - 1).toString();
                        }
                      },
                      child: const Icon(
                        Icons.remove,
                        color: GashopperTheme.red,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: controller.countController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        int currentValue = int.tryParse(controller.countController.text) ?? 0;
                        controller.countController.text = (currentValue + 1).toString();
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ).ltrbPadding(0, 0, 0, 16),
              if (controller.editInventory)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reason',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: Colors.black,
                      ),
                    ).ltrbPadding(0, 0, 0, 4),
                    CustomDropdownButton<IdNameRecord>(
                      value: null,
                      items: const [],
                      hintText: 'Select reason',
                      errorMessage: '',
                      hintStyle: GashopperTheme.fontWeightApplier(
                        FontWeight.w600,
                        const TextStyle(
                          fontSize: 16,
                          letterSpacing: 0.5,
                          color: GashopperTheme.grey1,
                        ),
                      ),
                      onChanged: (value) {},
                      onSaved: (value) {},
                      borderRadius: BorderRadius.circular(12),
                      borderColor: GashopperTheme.black,
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
                    ),
                  ],
                ).ltrbPadding(0, 0, 0, 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      customButtonHeight: 50,
                      title: 'Cancel',
                      customBackgroundColor: GashopperTheme.appBackGrounColor,
                      customBorderSide: Border.all(
                        color: GashopperTheme.black,
                        width: 1.5,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      customButtonHeight: 50,
                      title: 'Save',
                      onPressed: () {
                        if (!controller.editInventory) {
                          // controller.countController.clear();
                          // controller.inventoryNameController.clear();
                          controller.createInventory();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InventoryItem extends StatelessWidget {
  final String? name;
  final String? count;
  final Function()? onTap;
  const InventoryItem({super.key, this.name, this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: GashopperTheme.appBackGrounColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              children: [
                if (name != null)
                  Text(
                    name!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: GashopperTheme.black,
                    ),
                  ),
                const Spacer(),
                if (count != null)
                  Text(
                    count!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: GashopperTheme.black,
                    ),
                  ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: GashopperTheme.black,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final String? totalSale;
  final String? name;
  final String? count;
  const HistoryItem({super.key, this.totalSale, this.name, this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: const BoxDecoration(
        color: GashopperTheme.grey2,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Row(
        children: [
          if (totalSale != null)
            Text(
              totalSale!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: GashopperTheme.black,
              ),
            ),
          const SizedBox(width: 30),
          if (name != null)
            Text(
              name!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: GashopperTheme.black,
              ),
            ),
          const Spacer(),
          if (count != null)
            Text(
              count!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: GashopperTheme.red,
              ),
            ),
        ],
      ),
    );
  }
}

class EditInventoryDialog extends StatelessWidget {
  const EditInventoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

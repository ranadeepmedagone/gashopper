import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../core/utils/widgets/custom_dropdown.dart';
import '../../../data/models/app_inputs.dart';

class MaintenanceInventoryScreen extends StatelessWidget {
  MaintenanceInventoryScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: GashopperTheme.appBackGrounColor,
      appBar: const CustomAppBar(
        showBackButton: true,
        title: 'Business Unit',
        isTitleCentered: true,
      ),
      body: SingleChildScrollView(
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
                  enabled: true,
                  controller: SearchController(),
                  decoration: InputDecoration(
                    fillColor: GashopperTheme.grey2,
                    hintText: 'Search',
                    hintStyle: const TextStyle(fontSize: 16),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
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
                      onPressed: () {},
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
                        thumbVisibility: true,
                        thickness: 6.0,
                        radius: const Radius.circular(4),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              InventoryItem(
                                name: 'Fuel',
                                count: '234',
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Edit Inventory',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.5,
                                                color: Colors.black,
                                              ),
                                            ).ltrbPadding(0, 0, 0, 24),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Fuel',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: 0.5,
                                                      color: Colors.black),
                                                ),
                                                const SizedBox(width: 24),
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: InkWell(
                                                    onTap: () {},
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
                                                      controller: TextEditingController(),
                                                      keyboardType: TextInputType.number,
                                                      textAlign: TextAlign.center,
                                                      style: const TextStyle(fontSize: 14),
                                                      decoration: InputDecoration(
                                                        isDense: true,
                                                        border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(8),
                                                          borderSide: BorderSide.none,
                                                        ),
                                                        contentPadding:
                                                            const EdgeInsets.symmetric(
                                                          vertical: 12,
                                                          horizontal: 16,
                                                        ),
                                                      ),
                                                      onChanged: (value) {},
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.green,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ).ltrbPadding(0, 0, 0, 16),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Reason',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: 0.5,
                                                      color: Colors.black),
                                                ).ltrbPadding(0, 0, 0, 4),
                                                CustomDropdownButton<IdNameRecord>(
                                                  value: null,
                                                  items: const [],
                                                  // c.requestTypes
                                                  //     .map((e) => DropdownMenuItem(
                                                  //           value: e,
                                                  //           child: Text(
                                                  //             e.name ?? '',
                                                  //             style: const TextStyle(
                                                  //               color: GashopperTheme.black,
                                                  //               fontSize: 16,
                                                  //               fontWeight: FontWeight.w700,
                                                  //               letterSpacing: 0.5,
                                                  //             ),
                                                  //           ),
                                                  //         ))
                                                  //     .toList(),
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
                                                  onChanged: (value) {
                                                    // Handle selection change
                                                    // c.selectedRequestOrReport = value;
                                                    // c.update();
                                                  },
                                                  onSaved: (value) {
                                                    // Handle value save
                                                    // c.selectedRequestOrReport = value;
                                                    // c.update();
                                                  },
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
                                                    customBackgroundColor:
                                                        GashopperTheme.appBackGrounColor,
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
                                                    customButtonHeight: 50,
                                                    title: 'Save',
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).ltrbPadding(0, 0, 12, 8),
                              const InventoryItem(name: 'Ultra', count: '4343')
                                  .ltrbPadding(0, 0, 12, 8),
                              const InventoryItem(name: 'Diesel', count: '65456')
                                  .ltrbPadding(0, 0, 12, 8),
                              const InventoryItem(name: 'Oil', count: '124214')
                                  .ltrbPadding(0, 0, 12, 8),
                              const InventoryItem(name: 'Antifreeze', count: '42')
                                  .ltrbPadding(0, 0, 12, 8),
                              const InventoryItem(name: 'Def', count: '4')
                                  .ltrbPadding(0, 0, 12, 8),
                              const InventoryItem(name: 'Washer fluid', count: '1'),
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
                  const HistoryItem(totalSale: '11/10', name: 'Diesel', count: '65456')
                      .ltrbPadding(0, 0, 0, 8),
                  const HistoryItem(totalSale: '11/10', name: 'Oil', count: '124214')
                      .ltrbPadding(0, 0, 0, 8),
                  const HistoryItem(totalSale: '11/10', name: 'Antifreeze', count: '42')
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

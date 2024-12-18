// shift_update_controller.dart

import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/modules/landing/landing_screen.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import '../../core/utils/widgets/custom_elevation_button.dart';
import '../controller/shift_update_controller.dart';

// shift_update_screen.dart

class ShiftUpdateScreen extends StatefulWidget {
  const ShiftUpdateScreen({super.key});

  @override
  State<ShiftUpdateScreen> createState() => _ShiftUpdateScreenState();
}

class _ShiftUpdateScreenState extends State<ShiftUpdateScreen> {
  final ScrollController _scrollController = ScrollController();
  final controller = Get.put(ShiftUpdateController());
  double offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset / _scrollController.position.maxScrollExtent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);

    return GetBuilder<ShiftUpdateController>(
      builder: (c) {
        final showButtons = c.isCurrentShiftComplete();

        return Scaffold(
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
            height: mQ.size.height / 6,
            decoration: BoxDecoration(color: GashopperTheme.appBackGrounColor, boxShadow: [
              BoxShadow(
                color: GashopperTheme.grey1.withOpacity(0.6),
                offset: const Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomElevatedButton(
                    title: 'End Shift',
                    onPressed: () {
                      Get.to(() => LandingScreen());
                    },
                  ).ltrbPadding(0, 0, 0, 16),
                  CustomElevatedButton(
                    title: 'Go Back',
                    onPressed: () {
                      Get.back();
                    },
                    customBackgroundColor: GashopperTheme.appBackGrounColor,
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scroll Indicator
              Container(
                decoration: BoxDecoration(
                  color: GashopperTheme.appBackGrounColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset(offset, 0),
                        child: Container(
                          width: 60.0,
                          height: 6.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Table
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor:
                      WidgetStateProperty.all(GashopperTheme.black.withOpacity(0.3)),
                  border: const TableBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    horizontalInside: BorderSide(color: GashopperTheme.grey1, width: 1),
                    verticalInside: BorderSide(color: GashopperTheme.grey1, width: 1),
                    top: BorderSide(color: GashopperTheme.grey1, width: 1),
                    bottom: BorderSide(color: GashopperTheme.grey1, width: 1),
                  ),
                  columns: [
                    dataTableTitle(title: 'Date'),
                    dataTableTitle(title: 'Start Time'),
                    dataTableTitle(title: 'End Time'),
                    dataTableTitle(title: 'Duration'),
                  ],
                  rows: c.shifts.map((shift) {
                    return DataRow(
                      cells: [
                        DataCell(
                          (shift.isSaved || shift.date.isNotEmpty)
                              ? Text(
                                  shift.date,
                                  style: const TextStyle(
                                    color: GashopperTheme.black,
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                  ),
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                    color: GashopperTheme.appYellow,
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                          builder: (BuildContext context, Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor: GashopperTheme.appYellow,
                                                colorScheme: const ColorScheme.light(
                                                  primary: GashopperTheme.appYellow,
                                                  onPrimary: GashopperTheme.black,
                                                  // surface: GashopperTheme.appYellow,
                                                  onSurface: Colors.black,
                                                ),
                                                dialogBackgroundColor:
                                                    GashopperTheme.appBackGrounColor,
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (date != null) {
                                          c.updateShiftDate(c.shifts.indexOf(shift), date);
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Text(
                                          shift.date.isEmpty ? 'Select Date' : shift.date,
                                          style: const TextStyle(
                                            color: GashopperTheme.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        DataCell(
                          (shift.isSaved || shift.startTime.isNotEmpty)
                              ? Text(
                                  shift.startTime,
                                  style: const TextStyle(
                                    color: GashopperTheme.black,
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                  ),
                                )
                              : _buildTimeButton(
                                  context: context,
                                  shift: shift,
                                  controller: c,
                                  timeType: 'start',
                                  label: shift.startTime.isEmpty ? 'Start' : shift.startTime,
                                ),
                        ),
                        DataCell(
                          (shift.isSaved || shift.endTime.isNotEmpty)
                              ? Text(
                                  shift.endTime,
                                  style: const TextStyle(
                                    color: GashopperTheme.black,
                                    fontSize: 14,
                                    letterSpacing: 0.5,
                                  ),
                                )
                              : _buildTimeButton(
                                  context: context,
                                  shift: shift,
                                  controller: c,
                                  timeType: 'end',
                                  label: shift.endTime.isEmpty ? 'End' : shift.endTime,
                                ),
                        ),
                        dataCell(shift.duration.isEmpty ? '-' : shift.duration),
                      ],
                    );
                  }).toList(),
                ),
              ),

              // Bottom Scroll Indicator
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset(offset, 0),
                        child: Container(
                          width: 60.0,
                          height: 6.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Buttons
              if (showButtons)
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        title: 'Save',
                        onPressed: () => c.saveCurrentShift(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomElevatedButton(
                        customBackgroundColor: GashopperTheme.grey2,
                        title: 'Cancel',
                        onPressed: () => c.cancelCurrentShift(),
                      ),
                    ),
                  ],
                ).ltrbPadding(24, 16, 24, 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeButton({
    required BuildContext context,
    required Shift shift,
    required ShiftUpdateController controller,
    required String timeType,
    required String label,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: GashopperTheme.appYellow,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: GashopperTheme.appYellow,
                    colorScheme: const ColorScheme.light(
                      primary: GashopperTheme.appYellow,
                      onPrimary: GashopperTheme.black,
                      // surface: GashopperTheme.appYellow,
                      onSurface: Colors.black,
                    ),
                    dialogBackgroundColor: GashopperTheme.appBackGrounColor,
                  ),
                  child: child!,
                );
              },
            );
            if (time != null) {
              controller.updateShiftTime(
                controller.shifts.indexOf(shift),
                timeType,
                time,
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              label,
              style: const TextStyle(
                color: GashopperTheme.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataCell dataCell(String data) => DataCell(
        Text(
          data,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  DataColumn dataTableTitle({required String title}) {
    return DataColumn(
      label: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600,
          color: GashopperTheme.black,
        ),
      ),
    );
  }
}

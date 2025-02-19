import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/core/utils/widgets/custom_appbar.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_button.dart';
import '../../core/utils/widgets/custom_dropdown.dart';
import '../../core/utils/widgets/custom_loader.dart';
import '../../data/models/app_inputs.dart';
import '../list/list_screen.dart';
import 'shift_update_controller.dart';

class ShiftUpdateScreen extends StatelessWidget {
  const ShiftUpdateScreen({super.key});

  Future<void> selectStartTime(BuildContext context, ShiftUpdateController controller) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.fromDateTime(now),
      );

      if (pickedTime != null) {
        controller.updateStartTime(DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        ));
      }
    }
  }

  Future<void> selectEndTime(BuildContext context, ShiftUpdateController controller) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.fromDateTime(now),
      );

      if (pickedTime != null) {
        controller.updateEndTime(DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        ));
      }
    }
  }

  Widget _buildDateTimeField({
    required String label,
    required DateTime? value,
    required Function() onTap,
    required ShiftUpdateController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: onTap,
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
            alignment: Alignment.center,
            child: Text(
              controller.formatDateTime(value),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  void showCreateAndUpdateDialog(
    BuildContext context,
    bool isEdit,
    int? shiftId,
    ShiftUpdateController controller,
  ) {
    // Reset state only when creating a new shift
    if (!isEdit) {
      controller.resetState();
    }

    showDialog(
      context: context,
      builder: (context) => GetBuilder<ShiftUpdateController>(
        builder: (controller) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isEdit ? 'Update Employee Shift' : 'Add Employee',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: GashopperTheme.black,
                    ),
                  ).ltrbPadding(0, 0, 0, 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Wrap dropdown in IgnorePointer to disable changes during update.
                      IgnorePointer(
                        ignoring: controller.isEditShiftUser,
                        child: Opacity(
                          opacity: controller.isEditShiftUser ? 0.6 : 1.0,
                          child: CustomDropdownButton<IdNameRecord>(
                            value: controller.selectedUser,
                            items: controller.homeController.appInputs?.stationUsers
                                    ?.map((e) => DropdownMenuItem(
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
                                    .toList() ??
                                [],
                            hintText: 'Select employee',
                            errorMessage: '',
                            onChanged: (value) {
                              controller.selectedUser = value;
                            },
                            onSaved: (value) {
                              controller.selectedUser = value;
                            },
                            borderRadius: BorderRadius.circular(12),
                            borderColor: GashopperTheme.black,
                            borderWidth: 1.5,
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                      ).ltrbPadding(0, 0, 0, 16),
                      _buildDateTimeField(
                        label: 'Start Time',
                        value: controller.selectedStartTime.value,
                        onTap: () => selectStartTime(context, controller),
                        controller: controller,
                      ).ltrbPadding(0, 0, 0, 16),
                      if (isEdit)
                        _buildDateTimeField(
                          label: 'End Time',
                          value: controller.selectedEndTime.value,
                          onTap: () => selectEndTime(context, controller),
                          controller: controller,
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
                          onPressed: () {
                            controller.resetState();
                            Get.back();
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomButton(
                          customButtonHeight: 50,
                          title: 'Save',
                          onPressed: () {
                            if (controller.isEditShiftUser) {
                              // Ensure shiftId is provided when updating.
                              if (shiftId != null) {
                                controller.updateUserShift(
                                  controller.selectedStartTime.value,
                                  controller.selectedEndTime.value,
                                  shiftId,
                                );
                              }
                            } else {
                              controller.createUserShift(
                                controller.selectedStartTime.value,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShiftUpdateController>(
      builder: (controller) {
        return Scaffold(
          appBar: const CustomAppBar(title: 'Business Unit'),
          body: controller.isUserShiftsLoading
              ? const Center(child: CustomLoader())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Shift Update',
                          style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: GashopperTheme.black,
                          ),
                        ).ltrbPadding(0, 0, 0, 16),
                        const Text(
                          'Jan 26, 2025',
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: GashopperTheme.black,
                          ),
                        ),
                        WeeklyHoursScroll(
                          weekHours: controller.weekDays,
                          onTapPreviousWeek: controller.goToPreviousWeek,
                          onTapNextWeek: controller.goToNextWeek,
                          isToday: DateTime.now().day == controller.currentWeekStart.day,
                        ),
                        const SizedBox(height: 16),
                        const Divider(
                          color: GashopperTheme.grey1,
                          thickness: 1,
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          title: 'New',
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
                            controller.resetState();
                            showCreateAndUpdateDialog(context, false, null, controller);
                          },
                        ).ltrbPadding(0, 0, 0, 16),
                        const Text(
                          'Employees',
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: GashopperTheme.black,
                          ),
                        ).ltrbPadding(0, 0, 0, 8),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.userShiftsList.length,
                          itemBuilder: (context, index) {
                            final userShift = controller.userShiftsList[index];
                            return ListCard(
                              isPending: false,
                              title: userShift.userName ?? '',
                              value: userShift.totalWorkingHours ?? '',
                              buttonTitle: 'Update user',
                              onTapButton: () async {
                                await controller.onUserShiftUpdate(userShift);
                                showCreateAndUpdateDialog(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  true,
                                  userShift.id,
                                  controller,
                                );
                              },
                            ).ltrbPadding(0, 0, 0, 16);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class WeeklyHoursScroll extends StatelessWidget {
  final List<Map<String, String>> weekHours;
  final Function()? onTapPreviousWeek;
  final Function()? onTapNextWeek;
  final bool isToday;

  const WeeklyHoursScroll({
    super.key,
    required this.weekHours,
    this.onTapPreviousWeek,
    this.onTapNextWeek,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTapPreviousWeek,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: weekHours.map((day) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    // color: GashopperTheme.appYellow,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    // border: Border.all(color: GashopperTheme.appYellow, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Text(
                        day['day'] ?? '',
                        style: const TextStyle(
                            fontSize: 12,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w700,
                            color: GashopperTheme.grey1),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: day['isToday'] == 'true'
                                ? GashopperTheme.appYellow
                                : GashopperTheme.appBackGrounColor,
                            borderRadius: const BorderRadius.all(Radius.circular(12))),
                        child: Text(
                          day['date'] ?? '',
                          style: const TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w700,
                              color: GashopperTheme.black),
                        ),
                      ),
                      Text(
                        day['hours'] ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTapNextWeek,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
            ),
          ),
        ),
      ],
    );
  }
}

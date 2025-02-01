// // shift_update_controller.dart

// import 'package:flutter/material.dart';
// import 'package:gashopper/app/core/utils/helpers.dart';
// import 'package:get/get.dart';

// import '../../core/theme/app_theme.dart';
// import '../../core/utils/widgets/custom_appbar.dart';
// import '../../core/utils/widgets/custom_button.dart';
// import '../../routes/app_pages.dart';
// import 'shift_update_controller.dart';

// // shift_update_screen.dart

// class ShiftUpdateScreen extends StatefulWidget {
//   const ShiftUpdateScreen({super.key});

//   @override
//   State<ShiftUpdateScreen> createState() => _ShiftUpdateScreenState();
// }

// class _ShiftUpdateScreenState extends State<ShiftUpdateScreen> {
//   final ScrollController _scrollController = ScrollController();
//   final controller = Get.put(ShiftUpdateController());
//   double offset = 0;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       setState(() {
//         offset = _scrollController.offset / _scrollController.position.maxScrollExtent;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mQ = MediaQuery.of(context);

//     return GetBuilder<ShiftUpdateController>(
//       builder: (c) {
//         final showButtons = c.isCurrentShiftComplete();

//         return Scaffold(
//           appBar: const CustomAppBar(
//             title: 'Business Unit',
//           ),
//           bottomNavigationBar: Container(
//             margin: MediaQuery.of(context).padding.bottom > 12.0
//                 ? EdgeInsets.only(
//                     bottom: MediaQuery.of(context).padding.bottom - 12.0,
//                   )
//                 : null,
//             height: mQ.size.height / 6,
//             decoration: BoxDecoration(color: GashopperTheme.appBackGrounColor, boxShadow: [
//               BoxShadow(
//                 color: GashopperTheme.grey1.withAlphaOpacity(0.6),
//                 offset: const Offset(0, 4),
//                 blurRadius: 8,
//                 spreadRadius: 0,
//               ),
//             ]),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   CustomButton(
//                     title: 'End Shift',
//                     onPressed: () {
//                       Get.toNamed(Routes.scannerScreen);
//                     },
//                   ).ltrbPadding(0, 0, 0, 16),
//                   CustomButton(
//                     title: 'Go Back',
//                     onPressed: () {
//                       Get.back();
//                     },
//                     customBackgroundColor: GashopperTheme.appBackGrounColor,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Scroll Indicator
//               Container(
//                 decoration: BoxDecoration(
//                   color: GashopperTheme.appBackGrounColor,
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 clipBehavior: Clip.antiAlias,
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Expanded(
//                       child: Align(
//                         alignment: FractionalOffset(offset, 0),
//                         child: Container(
//                           width: 60.0,
//                           height: 6.0,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: Colors.grey[300],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Table
//               SingleChildScrollView(
//                 controller: _scrollController,
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   headingRowColor:
//                       WidgetStateProperty.all(GashopperTheme.black.withAlphaOpacity(0.3)),
//                   border: const TableBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     horizontalInside: BorderSide(color: GashopperTheme.grey1, width: 1),
//                     verticalInside: BorderSide(color: GashopperTheme.grey1, width: 1),
//                     top: BorderSide(color: GashopperTheme.grey1, width: 1),
//                     bottom: BorderSide(color: GashopperTheme.grey1, width: 1),
//                   ),
//                   columns: [
//                     dataTableTitle(title: 'Date'),
//                     dataTableTitle(title: 'Start Time'),
//                     dataTableTitle(title: 'End Time'),
//                     dataTableTitle(title: 'Duration'),
//                   ],
//                   rows: c.shifts.map((shift) {
//                     return DataRow(
//                       cells: [
//                         DataCell(
//                           (shift.isSaved || shift.date.isNotEmpty)
//                               ? Text(
//                                   shift.date,
//                                   style: const TextStyle(
//                                     color: GashopperTheme.black,
//                                     fontSize: 14,
//                                     letterSpacing: 0.5,
//                                   ),
//                                 )
//                               : Container(
//                                   decoration: const BoxDecoration(
//                                     color: GashopperTheme.appYellow,
//                                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                                   ),
//                                   child: Material(
//                                     color: Colors.transparent,
//                                     child: InkWell(
//                                       borderRadius: BorderRadius.circular(12),
//                                       onTap: () async {
//                                         final date = await showDatePicker(
//                                           context: context,
//                                           initialDate: DateTime.now(),
//                                           firstDate: DateTime(2000),
//                                           lastDate: DateTime(2100),
//                                           builder: (BuildContext context, Widget? child) {
//                                             return Theme(
//                                               data: ThemeData.light().copyWith(
//                                                 primaryColor: GashopperTheme.appYellow,
//                                                 colorScheme: const ColorScheme.light(
//                                                   primary: GashopperTheme.appYellow,
//                                                   onPrimary: GashopperTheme.black,
//                                                   // surface: GashopperTheme.appYellow,
//                                                   onSurface: Colors.black,
//                                                 ),
//                                                 dialogBackgroundColor:
//                                                     GashopperTheme.appBackGrounColor,
//                                               ),
//                                               child: child!,
//                                             );
//                                           },
//                                         );
//                                         if (date != null) {
//                                           c.updateShiftDate(c.shifts.indexOf(shift), date);
//                                         }
//                                       },
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 16, vertical: 8),
//                                         child: Text(
//                                           shift.date.isEmpty ? 'Select Date' : shift.date,
//                                           style: const TextStyle(
//                                             color: GashopperTheme.black,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w700,
//                                             letterSpacing: 0.5,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                         ),
//                         DataCell(
//                           (shift.isSaved || shift.startTime.isNotEmpty)
//                               ? Text(
//                                   shift.startTime,
//                                   style: const TextStyle(
//                                     color: GashopperTheme.black,
//                                     fontSize: 14,
//                                     letterSpacing: 0.5,
//                                   ),
//                                 )
//                               : _buildTimeButton(
//                                   context: context,
//                                   shift: shift,
//                                   controller: c,
//                                   timeType: 'start',
//                                   label: shift.startTime.isEmpty ? 'Start' : shift.startTime,
//                                 ),
//                         ),
//                         DataCell(
//                           (shift.isSaved || shift.endTime.isNotEmpty)
//                               ? Text(
//                                   shift.endTime,
//                                   style: const TextStyle(
//                                     color: GashopperTheme.black,
//                                     fontSize: 14,
//                                     letterSpacing: 0.5,
//                                   ),
//                                 )
//                               : _buildTimeButton(
//                                   context: context,
//                                   shift: shift,
//                                   controller: c,
//                                   timeType: 'end',
//                                   label: shift.endTime.isEmpty ? 'End' : shift.endTime,
//                                 ),
//                         ),
//                         dataCell(shift.duration.isEmpty ? '-' : shift.duration),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),

//               // Bottom Scroll Indicator
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 clipBehavior: Clip.antiAlias,
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Expanded(
//                       child: Align(
//                         alignment: FractionalOffset(offset, 0),
//                         child: Container(
//                           width: 60.0,
//                           height: 6.0,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20.0),
//                             color: Colors.grey[300],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Bottom Buttons
//               if (showButtons)
//                 Row(
//                   children: [
//                     Expanded(
//                       child: CustomButton(
//                         title: 'Save',
//                         onPressed: () => c.saveCurrentShift(),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: CustomButton(
//                         customBackgroundColor: GashopperTheme.grey2,
//                         title: 'Cancel',
//                         onPressed: () => c.cancelCurrentShift(),
//                       ),
//                     ),
//                   ],
//                 ).ltrbPadding(24, 16, 24, 16),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildTimeButton({
//     required BuildContext context,
//     required Shift shift,
//     required ShiftUpdateController controller,
//     required String timeType,
//     required String label,
//   }) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: GashopperTheme.appYellow,
//         borderRadius: BorderRadius.all(Radius.circular(12)),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12),
//           onTap: () async {
//             final time = await showTimePicker(
//               context: context,
//               initialTime: TimeOfDay.now(),
//               builder: (BuildContext context, Widget? child) {
//                 return Theme(
//                   data: ThemeData.light().copyWith(
//                     primaryColor: GashopperTheme.appYellow,
//                     colorScheme: const ColorScheme.light(
//                       primary: GashopperTheme.appYellow,
//                       onPrimary: GashopperTheme.black,
//                       // surface: GashopperTheme.appYellow,
//                       onSurface: Colors.black,
//                     ),
//                     dialogBackgroundColor: GashopperTheme.appBackGrounColor,
//                   ),
//                   child: child!,
//                 );
//               },
//             );
//             if (time != null) {
//               controller.updateShiftTime(
//                 controller.shifts.indexOf(shift),
//                 timeType,
//                 time,
//               );
//             }
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Text(
//               label,
//               style: const TextStyle(
//                 color: GashopperTheme.black,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//                 letterSpacing: 0.5,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   DataCell dataCell(String data) => DataCell(
//         Text(
//           data,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       );

//   DataColumn dataTableTitle({required String title}) {
//     return DataColumn(
//       label: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 14,
//           letterSpacing: 0.5,
//           fontWeight: FontWeight.w600,
//           color: GashopperTheme.black,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gashopper/app/core/utils/helpers.dart';
import 'package:gashopper/app/core/utils/widgets/custom_appbar.dart';
import 'package:get/get.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/widgets/custom_button.dart';
import '../../core/utils/widgets/custom_dropdown.dart';
import '../../data/models/app_inputs.dart';
import '../list/list_screen.dart';
import 'shift_update_controller.dart';

class ShiftUpdateScreen extends StatelessWidget {
  const ShiftUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShiftUpdateController>(builder: (controller) {
      return Scaffold(
        appBar: const CustomAppBar(title: 'Business Unit'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   'Select employe',
                //   style: TextStyle(
                //     fontSize: 14,
                //     letterSpacing: 0.5,
                //     fontWeight: FontWeight.w700,
                //     color: GashopperTheme.black,
                //   ),
                // ).ltrbPadding(0, 0, 0, 8),
                // CustomDropdownButton<IdNameRecord>(
                //   value: controller.selectedEmployee,
                //   items: controller.employees
                //       .map((e) => DropdownMenuItem(
                //             value: e,
                //             child: Text(
                //               e.name ?? '',
                //               style: const TextStyle(
                //                 color: GashopperTheme.black,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w700,
                //                 letterSpacing: 0.5,
                //               ),
                //             ),
                //           ))
                //       .toList(),
                //   hintText: 'Select user',
                //   errorMessage: null,
                //   hintStyle: GashopperTheme.fontWeightApplier(
                //     FontWeight.w600,
                //     const TextStyle(
                //       fontSize: 16,
                //       letterSpacing: 0.5,
                //       color: GashopperTheme.grey1,
                //     ),
                //   ),
                //   onChanged: (value) {
                //     // Handle selection change
                //     controller.selectedEmployee = value;
                //     controller.update();
                //   },
                //   onSaved: (value) {
                //     // Handle value save
                //     controller.selectedEmployee = value;
                //     controller.update();
                //   },
                //   borderRadius: BorderRadius.circular(12),
                //   // c.errorMessage != null ? GashopperTheme.red :
                //   borderColor: GashopperTheme.black,
                //   borderWidth: 1.5,
                //   padding: const EdgeInsets.all(8),
                //   icon: const Icon(
                //     Icons.keyboard_arrow_down,
                //     color: Colors.grey,
                //   ),
                //   dropdownShadow: BoxShadow(
                //     color: Colors.grey.withAlphaOpacity(0.4),
                //     offset: const Offset(0, 4),
                //     blurRadius: 16,
                //   ),
                // ).ltrbPadding(0, 0, 0, 16),
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
                            children: [
                              const Text(
                                'Add Employee',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: Colors.black,
                                ),
                              ).ltrbPadding(0, 0, 0, 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Date: 20/01/2025',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                          color: GashopperTheme.grey1,
                                        ),
                                      ),
                                      Text(
                                        'Day: Sunday',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                          color: GashopperTheme.grey1,
                                        ),
                                      ),
                                    ],
                                  ).ltrbPadding(0, 0, 0, 16),
                                  const Text(
                                    'Employee',
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
                                    hintText: 'Select employee',
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
                                  ).ltrbPadding(0, 0, 0, 8),
                                  const Text(
                                    'Hours',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
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
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16,
                                        ),
                                      ),
                                      onChanged: (value) {},
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
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const ListCard(
                      isPending: false,
                      title: 'Employee 1',
                      value: '10:00 hrs',
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

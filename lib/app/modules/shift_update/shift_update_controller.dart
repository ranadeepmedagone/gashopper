// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class ShiftUpdateController extends GetxController {
//   List<Shift> shifts = [];
//   List<Shift> savedShifts = [];
//   bool isLoading = false;

//   @override
//   void onInit() {
//     super.onInit();
//     addEmptyShift();
//   }

//   void addEmptyShift() {
//     shifts.add(
//       Shift(
//         id: shifts.length + 1,
//         startTime: '',
//         endTime: '',
//         date: '',
//         duration: '',
//         isSaved: false,
//       ),
//     );
//     update();
//   }

//   bool isCurrentShiftComplete() {
//     if (shifts.isEmpty) return false;
//     final currentShift = shifts.last;
//     return currentShift.date.isNotEmpty &&
//         currentShift.startTime.isNotEmpty &&
//         currentShift.endTime.isNotEmpty;
//   }

//   void saveCurrentShift() {
//     if (isCurrentShiftComplete()) {
//       final currentShift = shifts.last;
//       currentShift.isSaved = true;
//       savedShifts.add(currentShift);
//       addEmptyShift();
//       update();
//     }
//   }

//   void cancelCurrentShift() {
//     if (shifts.isNotEmpty && !shifts.last.isSaved) {
//       shifts.removeLast();
//       addEmptyShift();
//       update();
//     }
//   }

//   void updateShiftDate(int index, DateTime date) {
//     if (index < shifts.length && !shifts[index].isSaved) {
//       shifts[index] = shifts[index].copyWith(
//         date: DateFormat('yyyy-MM-dd').format(date),
//       );
//       update();
//     }
//   }

//   void updateShiftTime(int index, String timeType, TimeOfDay time) {
//     if (index < shifts.length && !shifts[index].isSaved) {
//       final timeString = formatTimeOfDay(time);
//       if (timeType == 'start') {
//         shifts[index] = shifts[index].copyWith(startTime: timeString);
//       } else {
//         shifts[index] = shifts[index].copyWith(endTime: timeString);
//       }
//       _calculateDuration(index);
//       update();
//     }
//   }

//   void _calculateDuration(int index) {
//     final shift = shifts[index];
//     if (shift.startTime.isNotEmpty && shift.endTime.isNotEmpty) {
//       try {
//         final startTime = DateFormat('hh:mm a').parse(shift.startTime);
//         final endTime = DateFormat('hh:mm a').parse(shift.endTime);

//         final duration = endTime.difference(startTime);
//         final hours = duration.inHours;
//         final minutes = duration.inMinutes % 60;

//         shifts[index] = shift.copyWith(
//           duration: '${hours}h ${minutes}m',
//         );
//         update();
//       } catch (e) {}
//     }
//   }

//   String formatTimeOfDay(TimeOfDay time) {
//     final now = DateTime.now();
//     final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
//     return DateFormat('hh:mm a').format(dt);
//   }
// }

// // shift_model.dart

// class Shift {
//   final int id;
//   final String startTime;
//   final String endTime;
//   final String date;
//   final String duration;
//   bool isSaved;

//   Shift({
//     required this.id,
//     required this.startTime,
//     required this.endTime,
//     required this.date,
//     required this.duration,
//     this.isSaved = false,
//   });

//   Shift copyWith({
//     int? id,
//     String? startTime,
//     String? endTime,
//     String? date,
//     String? duration,
//     bool? isSaved,
//   }) {
//     return Shift(
//       id: id ?? this.id,
//       startTime: startTime ?? this.startTime,
//       endTime: endTime ?? this.endTime,
//       date: date ?? this.date,
//       duration: duration ?? this.duration,
//       isSaved: isSaved ?? this.isSaved,
//     );
//   }
// }

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/models/app_inputs.dart';

class ShiftUpdateController extends GetxController {
  // State variables (not Rx since we're using GetBuilder)
  List<Map<String, String>> weekDays = [];
  DateTime currentWeekStart = DateTime.now();
  List<IdNameRecord> employees = [];
  IdNameRecord? selectedEmployee;
  String? errorMessage;

  @override
  void onInit() {
    super.onInit();
    // Initialize the current week's data
    generateWeekDays();
    // Load employees (you would typically fetch this from an API)
    loadEmployees();
  }

  // Generate week days for the current selected week
  void generateWeekDays() {
    // Get the start of the week (Sunday)
    DateTime weekStart = currentWeekStart.subtract(
      Duration(days: currentWeekStart.weekday % 7),
    );

    final today = DateTime.now();

    weekDays = List.generate(7, (index) {
      DateTime currentDay = weekStart.add(Duration(days: index));
      bool isToday = currentDay.year == today.year &&
          currentDay.month == today.month &&
          currentDay.day == today.day;

      return {
        'day': DateFormat('E').format(currentDay).substring(0, 1),
        'date': DateFormat('dd').format(currentDay),
        'hours': '8:00',
        'fullDate': DateFormat('yyyy-MM-dd').format(currentDay),
        'isToday': isToday.toString(), // Add isToday flag
      };
    });

    update(); // Notify GetBuilder to rebuild
  }

  // Navigate to previous week
  void goToPreviousWeek() {
    currentWeekStart = currentWeekStart.subtract(const Duration(days: 7));
    generateWeekDays();
  }

  // Navigate to next week
  void goToNextWeek() {
    // You might want to add validation here to prevent going beyond certain date
    DateTime nextWeek = currentWeekStart.add(const Duration(days: 7));
    if (nextWeek.isBefore(DateTime.now().add(const Duration(days: 0)))) {
      currentWeekStart = nextWeek;
      generateWeekDays();
    }
  }

  // Load employees
  void loadEmployees() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      employees = [
        IdNameRecord(id: 1, name: 'John Doe'),
        IdNameRecord(id: 2, name: 'Jane Smith'),
        // Add more employees as needed
      ];
      update();
    } catch (e) {
      errorMessage = 'Failed to load employees';
      update();
    }
  }

  // Handle employee selection
  void onEmployeeSelected(IdNameRecord? employee) {
    selectedEmployee = employee;
    errorMessage = null;
    update();

    // Load the selected employee's schedule
    if (employee != null) {
      loadEmployeeSchedule(employee.id ?? 0);
    }
  }

  // Load employee schedule for the current week
  void loadEmployeeSchedule(int employeeId) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Here you would typically:
      // 1. Make API call to get employee's schedule for current week
      // 2. Update the weekDays list with actual hours
      // 3. Call update() to refresh the UI

      // For demonstration, randomly updating hours
      weekDays = weekDays.map((day) {
        return {
          ...day,
          'hours': '${(DateTime.now().millisecondsSinceEpoch % 8 + 4)}H',
        };
      }).toList();

      update();
    } catch (e) {
      errorMessage = 'Failed to load schedule';
      update();
    }
  }

  // Save updated schedule
  Future<void> saveSchedule() async {
    if (selectedEmployee == null) {
      errorMessage = 'Please select an employee';
      update();
      return;
    }

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Here you would:
      // 1. Format the data as needed by your API
      // 2. Make the API call to save the schedule
      // 3. Handle success/failure

      Get.snackbar(
        'Success',
        'Schedule updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      errorMessage = 'Failed to save schedule';
      update();
    }
  }

  // Get the week range string for display
  String get weekRangeString {
    final weekEnd = currentWeekStart.add(const Duration(days: 6));
    return '${DateFormat('MMM dd').format(currentWeekStart)} - ${DateFormat('MMM dd').format(weekEnd)}';
  }

  // Check if we can go to next week (prevent going too far into future)
  bool get canGoToNextWeek {
    DateTime nextWeek = currentWeekStart.add(const Duration(days: 7));
    return nextWeek.isBefore(DateTime.now().add(const Duration(days: 30)));
  }
}

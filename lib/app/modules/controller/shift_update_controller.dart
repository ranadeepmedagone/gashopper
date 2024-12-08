import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShiftUpdateController extends GetxController {
  List<Shift> shifts = [];
  List<Shift> savedShifts = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    addEmptyShift();
  }

  void addEmptyShift() {
    shifts.add(
      Shift(
        id: shifts.length + 1,
        startTime: '',
        endTime: '',
        date: '',
        duration: '',
        isSaved: false,
      ),
    );
    update();
  }

  bool isCurrentShiftComplete() {
    if (shifts.isEmpty) return false;
    final currentShift = shifts.last;
    return currentShift.date.isNotEmpty &&
        currentShift.startTime.isNotEmpty &&
        currentShift.endTime.isNotEmpty;
  }

  void saveCurrentShift() {
    if (isCurrentShiftComplete()) {
      final currentShift = shifts.last;
      currentShift.isSaved = true;
      savedShifts.add(currentShift);
      addEmptyShift();
      update();
    }
  }

  void cancelCurrentShift() {
    if (shifts.isNotEmpty && !shifts.last.isSaved) {
      shifts.removeLast();
      addEmptyShift();
      update();
    }
  }

  void updateShiftDate(int index, DateTime date) {
    if (index < shifts.length && !shifts[index].isSaved) {
      shifts[index] = shifts[index].copyWith(
        date: DateFormat('yyyy-MM-dd').format(date),
      );
      update();
    }
  }

  void updateShiftTime(int index, String timeType, TimeOfDay time) {
    if (index < shifts.length && !shifts[index].isSaved) {
      final timeString = formatTimeOfDay(time);
      if (timeType == 'start') {
        shifts[index] = shifts[index].copyWith(startTime: timeString);
      } else {
        shifts[index] = shifts[index].copyWith(endTime: timeString);
      }
      _calculateDuration(index);
      update();
    }
  }

  void _calculateDuration(int index) {
    final shift = shifts[index];
    if (shift.startTime.isNotEmpty && shift.endTime.isNotEmpty) {
      try {
        final startTime = DateFormat('hh:mm a').parse(shift.startTime);
        final endTime = DateFormat('hh:mm a').parse(shift.endTime);

        final duration = endTime.difference(startTime);
        final hours = duration.inHours;
        final minutes = duration.inMinutes % 60;

        shifts[index] = shift.copyWith(
          duration: '${hours}h ${minutes}m',
        );
        update();
      } catch (e) {}
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }
}

// shift_model.dart

class Shift {
  final int id;
  final String startTime;
  final String endTime;
  final String date;
  final String duration;
  bool isSaved;

  Shift({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.duration,
    this.isSaved = false,
  });

  Shift copyWith({
    int? id,
    String? startTime,
    String? endTime,
    String? date,
    String? duration,
    bool? isSaved,
  }) {
    return Shift(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

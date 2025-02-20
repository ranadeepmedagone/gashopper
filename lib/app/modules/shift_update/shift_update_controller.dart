import 'package:gashopper/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/api/dio_helpers.dart';
import '../../data/models/app_inputs.dart';
import '../../data/models/user_shift.dart';
import '../../data/services/dialog_service.dart';

class ShiftUpdateController extends GetxController {
  List<Map<String, String>> weekDays = [];
  DateTime currentWeekStart = DateTime.now();
  List<IdNameRecord> employees = [];
  String? errorMessage;

  final _dioHelper = Get.find<DioHelper>();
  final _dialogService = Get.find<DialogService>();
  final HomeController homeController = Get.find<HomeController>();

  List<DailyTotalWorkingHours> dailyTotalWorkingHours = [];

  // Observable values for datetime selection
  Rx<DateTime?> selectedStartTime = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndTime = Rx<DateTime?>(null);

  IdNameRecord? _selectedUser;
  IdNameRecord? get selectedUser => _selectedUser;

  bool _isEditShiftUser = false;
  bool get isEditShiftUser => _isEditShiftUser;

  bool isUserShiftsLoading = false;
  List<UserShift> userShiftsList = [];

  @override
  void onInit() async {
    super.onInit();
    await getAllUserShifts();
    // Get the daily working hours from the appInputs
    dailyTotalWorkingHours = homeController.appInputs?.dailyTotalWorkingHours ?? [];
    await generateWeekDays();
  }

  void resetState() {
    _isEditShiftUser = false;
    _selectedUser = null;
    selectedStartTime.value = null;
    selectedEndTime.value = null;
    update();
  }

  set selectedUser(IdNameRecord? value) {
    if (_selectedUser?.id != value?.id) {
      _selectedUser = value;
      update();
    }
  }

  set isEditShiftUser(bool value) {
    if (_isEditShiftUser != value) {
      _isEditShiftUser = value;
      update();
    }
  }

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "No date selected";
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dateTime.toUtc());
  }

  void updateStartTime(DateTime? time) {
    selectedStartTime.value = time;
    update();
  }

  void updateEndTime(DateTime? time) {
    selectedEndTime.value = time;
    update();
  }

  IdNameRecord? findMatchingUser(int? userId, String? userName) {
    if (userId == null || homeController.appInputs?.stationUsers == null) {
      return null;
    }
    return homeController.appInputs?.stationUsers?.firstWhere(
      (user) => user.id == userId,
      orElse: () => IdNameRecord(id: userId, name: userName),
    );
  }

  /// When updating a shift, auto-fill the current details.
  Future<void> onUserShiftUpdate(UserShift userShift) async {
    resetState();
    _selectedUser = findMatchingUser(userShift.userId, userShift.userName);
    // Auto-fill the start and end time fields
    selectedStartTime.value = userShift.startTime;
    selectedEndTime.value = userShift.endTime;
    _isEditShiftUser = true;
    update();
  }

  /// Generate the week days list using the daily working hours if available.
  Future<void> generateWeekDays() async {
    DateTime weekStart = currentWeekStart.subtract(
      Duration(days: currentWeekStart.weekday % 7),
    );

    final today = DateTime.now();

    weekDays = List.generate(7, (index) {
      DateTime currentDay = weekStart.add(Duration(days: index));
      bool isToday = currentDay.year == today.year &&
          currentDay.month == today.month &&
          currentDay.day == today.day;

      // Try to find matching daily working hours record.
      DailyTotalWorkingHours? record;
      try {
        record = dailyTotalWorkingHours.firstWhere((r) =>
            r.day == currentDay.day &&
            r.month == currentDay.month &&
            r.year == currentDay.year);
      } catch (e) {
        record = null;
      }
      // Use the found total working hours (or default to '0').
      String hours = record != null && record.totalWorkingHours != null
          ? record.totalWorkingHours.toString()
          : '0';

      return {
        'day': DateFormat('E').format(currentDay).substring(0, 1),
        'date': DateFormat('dd').format(currentDay),
        'hours': hours,
        'fullDate': DateFormat('yyyy-MM-dd').format(currentDay),
        'isToday': isToday.toString(),
      };
    });

    update();
  }

  void goToPreviousWeek() {
    currentWeekStart = currentWeekStart.subtract(const Duration(days: 7));
    generateWeekDays();
  }

  void goToNextWeek() {
    DateTime nextWeek = currentWeekStart.add(const Duration(days: 7));
    if (nextWeek.isBefore(DateTime.now().add(const Duration(days: 0)))) {
      currentWeekStart = nextWeek;
      generateWeekDays();
    }
  }

  String get weekRangeString {
    final weekEnd = currentWeekStart.add(const Duration(days: 6));
    return '${DateFormat('MMM dd').format(currentWeekStart)} - ${DateFormat('MMM dd').format(weekEnd)}';
  }

  bool get canGoToNextWeek {
    DateTime nextWeek = currentWeekStart.add(const Duration(days: 7));
    return nextWeek.isBefore(DateTime.now().add(const Duration(days: 30)));
  }

  Future<void> getAllUserShifts() async {
    try {
      isUserShiftsLoading = true;
      update();

      final (response, error) = await _dioHelper.getAllUserShifts();

      if (error != null || response?.data == null) {
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: error ?? 'No data received',
          buttonText: 'OK',
        );
        return;
      }

      if (response?.data is List) {
        try {
          userShiftsList = (response?.data as List)
              .map((item) => UserShift.fromJson(item as Map<String, dynamic>))
              .toList();
        } catch (e) {
          await _dialogService.showErrorDialog(
            title: 'Error',
            description: 'Failed to process shifts data',
            buttonText: 'OK',
          );
          return;
        }
      }
    } catch (e) {
      await _dialogService.showErrorDialog(
        title: 'Error',
        description: e.toString(),
        buttonText: 'OK',
      );
    } finally {
      isUserShiftsLoading = false;
      update();
    }
  }

  Future<void> createUserShift(DateTime? startTime) async {
    if (startTime != null && selectedUser != null) {
      try {
        isUserShiftsLoading = true;
        Get.back();
        update();

        final (response, error) = await _dioHelper.createUserShift(
          startTime: startTime.toUtc(),
          employeeId: selectedUser!.id!,
        );

        if (error != null || response?.data == null) {
          await _dialogService.showErrorDialog(
            title: 'Error',
            description: error ?? 'No data received',
            buttonText: 'OK',
          );
          return;
        }

        await getAllUserShifts();
      } catch (e) {
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: e.toString(),
          buttonText: 'OK',
        );
      } finally {
        isUserShiftsLoading = false;
        update();
      }
    }
  }

  Future<void> updateUserShift(DateTime? startTime, DateTime? endTime, int shiftId) async {
    if (startTime != null && endTime != null && selectedUser != null) {
      try {
        isUserShiftsLoading = true;
        Get.back();
        update();

        final (response, error) = await _dioHelper.updateUserShift(
          startTime: startTime.toUtc(),
          endTime: endTime.toUtc(),
          employeeId: selectedUser!.id!,
          shiftId: shiftId,
        );

        if (error != null || response?.data == null) {
          await _dialogService.showErrorDialog(
            title: 'Error',
            description: error ?? 'No data received',
            buttonText: 'OK',
          );
          return;
        }

        await getAllUserShifts();
      } catch (e) {
        await _dialogService.showErrorDialog(
          title: 'Error',
          description: e.toString(),
          buttonText: 'OK',
        );
      } finally {
        isUserShiftsLoading = false;
        update();
      }
    }
  }
}

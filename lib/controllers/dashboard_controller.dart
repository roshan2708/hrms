import 'dart:async';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final isCheckedIn = false.obs;
  final checkInTime = Rxn<DateTime>();
  final workedSeconds = 0.obs;
  Timer? _workedTimer;

  final userName = 'Roshan Singh'.obs;
  final role = 'Flutter Developer'.obs;
  final department = 'Engineering'.obs;
  final profileImageUrl = ''.obs;

  final pendingLeaves = 2.obs;
  final unreadNotifications = 5.obs;

  final remainingLeaveDays = 12.0.obs;
  final monthlyAttendancePercent = 98.4.obs;
  final nextPayDate = DateTime.now().add(const Duration(days: 10)).obs;

  final recentActivities = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    recentActivities.addAll([
      "Yesterday: Clocked out at 06:15 PM",
      "Tuesday: Leave request approved by Manager",
      "Monday: Clocked in at 08:45 AM",
    ]);
  }

  @override
  void onClose() {
    _workedTimer?.cancel();
    super.onClose();
  }

  void toggleCheckIn() {
    isCheckedIn.value = !isCheckedIn.value;
    if (isCheckedIn.value) {
      checkInTime.value = DateTime.now();

      workedSeconds.value = 0;
      _workedTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        workedSeconds.value++;
      });

      _addActivity("Today: Clocked in at ${_formatTime(checkInTime.value!)}");
      Get.snackbar(
        'Success',
        'Clocked in successfully',
        snackPosition: SnackPosition.TOP,
      );
    } else {
      _workedTimer?.cancel();
      _addActivity("Today: Clocked out at ${_formatTime(DateTime.now())}");
      Get.snackbar(
        'Success',
        'Clocked out successfully',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void _addActivity(String activity) {
    recentActivities.insert(0, activity);
    if (recentActivities.length > 4) {
      recentActivities.removeLast();
    }
  }

  String _formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get formattedWorkedTime {
    int hours = workedSeconds.value ~/ 3600;
    int minutes = (workedSeconds.value % 3600) ~/ 60;
    int seconds = workedSeconds.value % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void openLeaveManagement() =>
      Get.snackbar('Leaves', 'Navigating to Leave Management...');
  void openPayroll() => Get.snackbar('Payroll', 'Downloading Payslip...');
  void openNotifications() =>
      Get.snackbar('Notifications', 'Opening Notifications...');
  void openDirectory() => Get.snackbar('Directory', 'Browsing Colleagues...');
}

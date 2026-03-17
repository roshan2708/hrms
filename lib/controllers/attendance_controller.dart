import 'dart:convert';
import 'package:get/get.dart';
import '../models/attendance_model.dart';
import '../services/attendance_service.dart';

class AttendanceController extends GetxController {
  final attendanceList = <AttendanceRecord>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttendanceList();
  }

  Future<void> fetchAttendanceList() async {
    try {
      isLoading.value = true;
      final response = await AttendanceService.getAttendanceList();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        attendanceList.assignAll(
          data.map((json) => AttendanceRecord.fromJson(json)).toList(),
        );
      } else {
        Get.snackbar('Error', 'Failed to fetch attendance: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred while fetching attendance');
    } finally {
      isLoading.value = false;
    }
  }
}

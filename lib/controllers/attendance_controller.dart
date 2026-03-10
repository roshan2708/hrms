import 'package:get/get.dart';
import '../models/attendance_model.dart';
import '../services/attendance_service.dart';

class AttendanceController extends GetxController {
  final AttendanceService _attendanceService = AttendanceService();
  
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
      final list = await _attendanceService.getAttendanceList();
      attendanceList.assignAll(list);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch attendance list');
    } finally {
      isLoading.value = false;
    }
  }
}

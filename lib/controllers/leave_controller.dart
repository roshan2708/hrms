import 'dart:convert';
import 'package:get/get.dart';
import '../models/leave_model.dart';
import '../services/leave_service.dart';

class LeaveController extends GetxController {
  final leaveRequests = <LeaveRequest>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeaveRequests();
  }

  Future<void> fetchLeaveRequests() async {
    try {
      isLoading.value = true;
      final response = await LeaveService.getLeaveRequests();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        leaveRequests.assignAll(
          data.map((json) => LeaveRequest.fromJson(json)).toList(),
        );
      } else {
        Get.snackbar('Error', 'Failed to fetch leave requests: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred while fetching leave requests');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> applyLeave(LeaveRequest request) async {
    try {
      isLoading.value = true;
      final response = await LeaveService.applyLeave(request.toJson());
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.snackbar('Success', 'Leave application submitted successfully');
        await fetchLeaveRequests();
      } else {
        Get.snackbar('Error', 'Failed to submit leave application: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while applying for leave');
    } finally {
      isLoading.value = false;
    }
  }
}

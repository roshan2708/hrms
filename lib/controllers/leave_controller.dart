import 'package:get/get.dart';
import '../models/leave_model.dart';
import '../services/leave_service.dart';

class LeaveController extends GetxController {
  final LeaveService _leaveService = LeaveService();
  
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
      final list = await _leaveService.getLeaveRequests();
      leaveRequests.assignAll(list);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch leave requests');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> applyLeave(LeaveRequest request) async {
    try {
      isLoading.value = true;
      final success = await _leaveService.applyLeave(request);
      if (success) {
        Get.snackbar('Success', 'Leave application submitted successfully');
        await fetchLeaveRequests();
      } else {
        Get.snackbar('Error', 'Failed to submit leave application');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while applying for leave');
    } finally {
      isLoading.value = false;
    }
  }
}

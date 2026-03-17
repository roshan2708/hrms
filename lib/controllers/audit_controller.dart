import 'dart:convert';
import 'package:get/get.dart';
import '../../models/audit_model.dart';
import '../../services/audit_service.dart';

class AuditController extends GetxController {
  final auditLogs = <AuditLog>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLogs();
  }

  Future<void> fetchLogs() async {
    try {
      isLoading.value = true;
      // Fetching super admin logs by default for now
      final response = await AuditService.getSuperAdminAuditLogs();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        auditLogs.assignAll(
          data.map((json) => AuditLog.fromJson(json)).toList(),
        );
      } else {
        Get.snackbar('Error', 'Failed to fetch logs: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred while fetching logs');
    } finally {
      isLoading.value = false;
    }
  }
}

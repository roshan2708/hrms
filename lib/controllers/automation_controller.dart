import 'package:get/get.dart';
import '../../core/services/administration_service.dart';

class AutomationController extends GetxController {
  final rules = <dynamic>[].obs;
  final logs = <dynamic>[].obs;
  final isLoading = false.obs;
  final activeTab = 'rules'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final fetchedRules = await AdministrationService.getAutomationWorkflows();
      // Mock logs
      final fetchedLogs = [
        { 'id': 1, 'timestamp': '2026-02-25 10:30 AM', 'module': 'Leave', 'action': 'Sent Notification', 'status': 'Success' },
        { 'id': 2, 'timestamp': '2026-02-25 09:15 AM', 'module': 'Attendance', 'action': 'Auto-Marked Present', 'status': 'Success' },
      ];
      rules.assignAll(fetchedRules);
      logs.assignAll(fetchedLogs);
    } finally {
      isLoading.value = false;
    }
  }

  void toggleRule(int id) {
    final index = rules.indexWhere((r) => r['id'] == id);
    if (index != -1) {
      final rule = Map<String, dynamic>.from(rules[index]);
      rule['status'] = rule['status'] == 'Active' ? 'Paused' : 'Active';
      rules[index] = rule;
    }
  }
}

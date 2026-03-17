import 'package:get/get.dart';
import '../../core/services/administration_service.dart';

class VisitorController extends GetxController {
  final visitors = <dynamic>[].obs;
  final isLoading = false.obs;
  final activeTab = 'request'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVisitors();
  }

  Future<void> fetchVisitors() async {
    try {
      isLoading.value = true;
      final fetched = await AdministrationService.getVisitors();
      visitors.assignAll(fetched);
    } finally {
      isLoading.value = false;
    }
  }

  void updateStatus(int id, String newStatus) {
    final index = visitors.indexWhere((v) => v['id'] == id);
    if (index != -1) {
      final visitor = Map<String, dynamic>.from(visitors[index]);
      visitor['status'] = newStatus;
      visitors[index] = visitor;
    }
  }
}

import 'package:get/get.dart';
import '../../core/services/operations_service.dart';

class DailyTaskController extends GetxController {
  final tasks = <dynamic>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading.value = true;
      final fetched = await OperationsService.getDailyTasks();
      tasks.assignAll(fetched);
    } finally {
      isLoading.value = false;
    }
  }
}

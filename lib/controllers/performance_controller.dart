import 'package:get/get.dart';
import '../../core/services/hr_service.dart';

class PerformanceController extends GetxController {
  final reviews = <dynamic>[].obs;
  final isLoading = false.obs;
  final cycleFilter = 'Q1 2024'.obs;
  final deptFilter = 'All Departments'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      isLoading.value = true;
      final fetched = await HRService.getPerformanceReviews();
      reviews.assignAll(fetched);
    } finally {
      isLoading.value = false;
    }
  }
}

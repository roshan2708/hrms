import 'package:get/get.dart';
import '../../core/services/finance_service.dart';

class TravelExpenseController extends GetxController {
  final expenses = <dynamic>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    try {
      isLoading.value = true;
      final fetched = await FinanceService.getTravelExpenses();
      expenses.assignAll(fetched);
    } finally {
      isLoading.value = false;
    }
  }

  void uploadReceipts() {
    Get.snackbar('Upload', 'Receipt upload feature coming soon');
  }
}

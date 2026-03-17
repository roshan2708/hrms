import 'package:get/get.dart';
import '../../core/services/finance_service.dart';

class LoansController extends GetxController {
  final loans = <dynamic>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLoans();
  }

  Future<void> fetchLoans() async {
    try {
      isLoading.value = true;
      final fetched = await FinanceService.getLoans();
      loans.assignAll(fetched);
    } finally {
      isLoading.value = false;
    }
  }
}

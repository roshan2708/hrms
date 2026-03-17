import 'package:get/get.dart';
import '../../core/services/administration_service.dart';

class DelegationController extends GetxController {
  final delegations = <dynamic>[].obs;
  final isLoading = false.obs;
  final searchTerm = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDelegations();
  }

  Future<void> fetchDelegations() async {
    try {
      isLoading.value = true;
      final fetched = await AdministrationService.getDelegations();
      delegations.assignAll(fetched);
    } finally {
      isLoading.value = false;
    }
  }

  void cancelDelegation(int id) {
    delegations.removeWhere((d) => d['id'] == id);
    Get.snackbar('Success', 'Delegation cancelled successfully');
  }
}

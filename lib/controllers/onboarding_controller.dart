import 'package:get/get.dart';
import '../../core/services/hr_service.dart';

class OnboardingController extends GetxController {
  final activeTab = 'onboarding'.obs;
  final candidates = <dynamic>[].obs;
  final issuedCerts = <dynamic>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final fetchedCandidates = await HRService.getOnboardingCandidates();
      final fetchedCerts = await HRService.getIssuedCertificates();
      
      candidates.assignAll(fetchedCandidates);
      issuedCerts.assignAll(fetchedCerts);
    } finally {
      isLoading.value = false;
    }
  }

  void toggleTab(String tab) {
    activeTab.value = tab;
  }
}

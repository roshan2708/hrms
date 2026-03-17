import 'package:get/get.dart';
import '../../core/services/core_service.dart';

class SetupOrganizationController extends GetxController {
  final orgName = ''.obs;
  final industry = 'Select'.obs;
  final companySize = 'Select'.obs;
  final country = 'India'.obs;
  final state = 'Telangana'.obs;
  final city = 'Hyderabad'.obs;

  final isLoading = false.obs;

  final List<String> industries = ['Technology', 'Healthcare', 'Finance', 'Other'];
  final List<String> sizes = ['1-10', '11-50', '51-200', '201-500', '500+'];

  Future<void> submitSetup() async {
    if (orgName.isEmpty || industry.value == 'Select' || companySize.value == 'Select') {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    try {
      isLoading.value = true;
      final success = await CoreService.setupOrganization({
        'name': orgName.value,
        'industry': industry.value,
        'size': companySize.value,
        'country': country.value,
        'state': state.value,
        'city': city.value,
      });

      if (success) {
        Get.offAllNamed('/dashboard');
        Get.snackbar('Success', 'Organization set up successfully');
      } else {
        Get.snackbar('Error', 'Failed to set up organization');
      }
    } finally {
      isLoading.value = false;
    }
  }
}

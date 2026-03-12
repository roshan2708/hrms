import 'package:get/get.dart';
import '../../core/theme/theme_controller.dart';
import 'dashboard_controller.dart';

class SettingsController extends GetxController {
  final isLoading = false.obs;
  
  // Dummy settings state
  final isEmailNotificationEnabled = true.obs;
  final isPushNotificationEnabled = true.obs;
  final isLocationTrackingEnabled = false.obs;
  final language = 'English'.obs;

  void toggleEmailNotifications(bool value) => isEmailNotificationEnabled.value = value;
  void togglePushNotifications(bool value) => isPushNotificationEnabled.value = value;
  void toggleLocationTracking(bool value) => isLocationTrackingEnabled.value = value;
  
  void changeLanguage(String newLang) => language.value = newLang;

  void toggleTheme() {
    Get.find<ThemeController>().toggleTheme();
  }

  void saveProfileChanges(String newName, String newPhone) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call
    
    try {
      final dashboardCtrl = Get.find<DashboardController>();
      if (newName.isNotEmpty) {
        dashboardCtrl.userName.value = newName;
      }
    } catch (e) {
      // Ignore if dashboard controller not found
    }
    
    isLoading.value = false;
    Get.back();
    Get.snackbar('Success', 'Profile updated successfully');
  }
}

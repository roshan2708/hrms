import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../core/utils/validators.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validateEmail(String? value) {
    return Validators.validateEmail(value);
  }

  String? validatePassword(String? value) {
    return Validators.validatePassword(value);
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        final response = await AuthService.login(
          emailController.text.trim(),
          passwordController.text,
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {
          // Success! 
          // Note: In a real app we would parse the token from the response
          // and store it using something like GetStorage.
          Get.offAllNamed('/dashboard');
        } else {
          Get.snackbar(
            'Login Failed',
            'Invalid credentials or server error',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withValues(alpha: 0.1),
            colorText: Colors.red,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'An unexpected error occurred',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  void forgotPassword() {
    Get.snackbar(
      'Notice',
      'Password reset link sent to your email',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

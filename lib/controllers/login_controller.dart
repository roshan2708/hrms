import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
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
      await Future.delayed(const Duration(seconds: 1));
      isLoading.value = false;

      final email = emailController.text.toLowerCase();
      
      if (passwordController.text == 'password') {
        if (email == 'superadmin@hrms.com' ||
            email == 'admin@hrms.com' ||
            email == 'hr@hrms.com' ||
            email == 'manager@hrms.com' ||
            email == 'employee@hrms.com') {
          // Success! In a real app we'd get the role from the API response
          ApiService.currentUserEmail = email;
          Get.offNamed('/dashboard');
        } else {
          Get.snackbar('Error', 'Invalid credentials', snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Error', 'Invalid password', snackPosition: SnackPosition.BOTTOM);
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

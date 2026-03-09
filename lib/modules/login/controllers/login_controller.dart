import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));

      isLoading.value = false;

      if (emailController.text == 'admin@hrms.com' &&
          passwordController.text == 'password') {
        Get.offNamed('/dashboard');
      } else {
        Get.snackbar(
          'Error',
          'Invalid credentials',
          snackPosition: SnackPosition.BOTTOM,
        );
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

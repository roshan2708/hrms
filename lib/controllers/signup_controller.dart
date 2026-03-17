import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../routes/app_routes.dart';

class SignupController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();
  
  final isLoading = false.obs;
  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  Future<void> signup() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      
      final response = await AuthService.signUp({
        'first_name': firstNameController.text.trim(),
        'last_name': lastNameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text,
      });

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.toNamed(Routes.otpVerification, arguments: {'email': emailController.text.trim()});
      } else {
        Get.snackbar('Error', result['message'] ?? 'Signup failed', backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e', backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    if (otpController.text.length < 4) {
      Get.snackbar('Error', 'Please enter a valid OTP', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      final response = await AuthService.verifySignupOtp({
        'email': emailController.text.trim(),
        'otp': otpController.text.trim(),
      });

      if (response.statusCode == 200) {
        Get.offAllNamed(Routes.dashboard);
        Get.snackbar('Success', 'Account verified successfully', backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        final result = jsonDecode(response.body);
        Get.snackbar('Error', result['message'] ?? 'Verification failed', backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e', backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}

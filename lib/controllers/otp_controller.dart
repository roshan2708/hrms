import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../routes/app_routes.dart';
import 'dart:async';

class OtpController extends GetxController {
  final otpControllers = List.generate(6, (index) => TextEditingController());
  final focusNodes = List.generate(6, (index) => FocusNode());
  
  final isLoading = false.obs;
  final timeLeft = 60.obs;
  final canResend = false.obs;
  String email = '';

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments?['email'] ?? '';
    startTimer();
  }

  void startTimer() {
    canResend.value = false;
    timeLeft.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        canResend.value = true;
        _timer?.cancel();
      }
    });
  }

  Future<void> verifyOtp() async {
    final otp = otpControllers.map((e) => e.text).join();
    if (otp.length != 6) {
      Get.snackbar('Error', 'Please enter 6-digit OTP', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      final response = await AuthService.verifySignupOtp({'email': email, 'otp': otp});
      
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Verified successfully', backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed(Routes.login);
      } else {
        Get.snackbar('Error', 'Invalid OTP', backgroundColor: Colors.red, colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (!canResend.value) return;
    
    try {
      isLoading.value = true;
      // Assuming resend uses the same endpoint or similar
      final response = await AuthService.signUp({'email': email}); // Mocking resend
      if (response.statusCode == 200) {
        startTimer();
        Get.snackbar('Success', 'OTP Resent', backgroundColor: Colors.green, colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }
}

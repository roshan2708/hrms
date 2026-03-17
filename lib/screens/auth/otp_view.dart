import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/otp_controller.dart';
import '../../core/theme/app_colors.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Verify Signup OTP', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Enter the 6-digit code sent to', style: TextStyle(color: Colors.grey[600])),
              Text(controller.email, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) => _buildOtpBox(index)),
              ),
              const SizedBox(height: 32),
              Obx(() => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : () => controller.verifyOtp(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: controller.isLoading.value 
                    ? const CircularProgressIndicator(color: Colors.white) 
                    : const Text('Verify & Proceed', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              )),
              const SizedBox(height: 24),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn't receive the code? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: controller.canResend.value ? () => controller.resendOtp() : null,
                    child: Text(
                      controller.canResend.value 
                        ? "Resend" 
                        : "Resend (${controller.timeLeft.value}s)",
                      style: TextStyle(
                        color: controller.canResend.value ? AppColors.primary : Colors.grey,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 45,
      child: TextField(
        controller: controller.otpControllers[index],
        focusNode: controller.focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.grey[50],
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey[200]!)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.primary, width: 2)),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            controller.focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            controller.focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}

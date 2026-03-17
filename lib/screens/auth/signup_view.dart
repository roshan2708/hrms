import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/signup_controller.dart';
import '../../core/theme/app_colors.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/scholarly_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Create an account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Join our HRMS platform to manage your workforce seamlessly.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(controller.firstNameController, 'First Name')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildTextField(controller.lastNameController, 'Last Name')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(controller.emailController, 'Email Address', keyboardType: TextInputType.emailAddress),
                    const SizedBox(height: 16),
                    Obx(() => _buildTextField(
                          controller.passwordController,
                          'Password',
                          isPassword: true,
                          obscureText: !controller.showPassword.value,
                          onToggle: () => controller.showPassword.toggle(),
                        )),
                    const SizedBox(height: 16),
                    Obx(() => _buildTextField(
                          controller.confirmPasswordController,
                          'Confirm Password',
                          isPassword: true,
                          obscureText: !controller.showConfirmPassword.value,
                          onToggle: () => controller.showConfirmPassword.toggle(),
                        )),
                    const SizedBox(height: 32),
                    Obx(() => SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value ? null : () => controller.signup(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            ),
                            child: controller.isLoading.value ? const CircularProgressIndicator(color: Colors.white) : const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        )),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? ", style: TextStyle(color: Colors.grey)),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Text("Login here", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool isPassword = false, bool obscureText = false, VoidCallback? onToggle, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey[200]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey[200]!)),
        suffixIcon: isPassword ? IconButton(icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey), onPressed: onToggle) : null,
      ),
    );
  }
}

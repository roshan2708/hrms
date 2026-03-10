import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../controllers/login_controller.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_button.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height - MediaQuery.of(context).padding.top,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CustomHeader(
                    icon: Icons.business_center,
                    title: 'Welcome to HRMS',
                    subtitle: 'Sign in to continue',
                  ),
                  SizedBox(height: size.height * 0.08),

                  CustomTextField(
                    controller: controller.emailController,
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                  ),
                  SizedBox(height: size.height * 0.03),

                  CustomTextField(
                    controller: controller.passwordController,
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    obscureText: true,
                    validator: controller.validatePassword,
                  ),
                  SizedBox(height: size.height * 0.01),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: controller.forgotPassword,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : AppColors.primary,
                          fontSize: AppTypography.caption(context).fontSize,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),

                  Obx(
                    () => CustomButton(
                      text: 'Login',
                      onPressed: controller.login,
                      isLoading: controller.isLoading.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

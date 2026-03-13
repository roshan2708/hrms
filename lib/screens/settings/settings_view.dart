import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/settings_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/custom_text_field.dart';
import '../../core/utils/validators.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({super.key});

  final _nameController = TextEditingController(text: 'Alice Parker'); // Dummy start value
  final _phoneController = TextEditingController(text: '+1 234 567 8900'); // Dummy start value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionHeader(context, 'Personal Information'),
            _buildProfileEditForm(context),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Preferences'),
            _buildPreferencesSection(context),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Security'),
            _buildSecuritySection(context),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.saveProfileChanges(_nameController.text, _phoneController.text);
                  }
                },
                child: const Text('SAVE CHANGES'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      }),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildProfileEditForm(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _nameController,
                labelText: 'Full Name',
                prefixIcon: const Icon(Icons.person_outline),
                validator: (val) => Validators.validateRequired(val, 'Full Name'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                labelText: 'Phone Number',
                prefixIcon: const Icon(Icons.phone_outlined),
                validator: Validators.validatePhone,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferencesSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme'),
            value: isDark, // Managed globally by ThemeController but toggled via SettingsController for UI coupling
            onChanged: (val) => controller.toggleTheme(),
            secondary: const Icon(Icons.dark_mode_outlined),
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive alerts on device'),
            value: controller.isPushNotificationEnabled.value,
            onChanged: controller.togglePushNotifications,
            secondary: const Icon(Icons.notifications_active_outlined),
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('Email Notifications'),
            subtitle: const Text('Receive updates via email'),
            value: controller.isEmailNotificationEnabled.value,
            onChanged: controller.toggleEmailNotifications,
            secondary: const Icon(Icons.email_outlined),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: controller.language.value,
              underline: const SizedBox(),
              items: <String>['English', 'Spanish', 'French'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 14)),
                );
              }).toList(),
              onChanged: (val) {
                if(val != null) controller.changeLanguage(val);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Get.snackbar('Coming Soon', 'Password change feature is under development.');
            },
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('Location Tracking'),
            subtitle: const Text('Used for remote attendance'),
            value: controller.isLocationTrackingEnabled.value,
            onChanged: controller.toggleLocationTracking,
            secondary: const Icon(Icons.location_on_outlined),
            activeColor: AppColors.error,
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text('Log Out', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
            onTap: () => Get.offAllNamed('/login'),
          ),
        ],
      ),
    );
  }
}

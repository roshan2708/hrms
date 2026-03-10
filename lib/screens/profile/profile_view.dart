import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../../core/theme/app_colors.dart';

class ProfileView extends GetView<DashboardController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildProfileHeader(context),
              const SizedBox(height: 32),
              _buildInfoSection(context),
              const SizedBox(height: 24),
              _buildActionsSection(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = isDark ? Colors.white : AppColors.accent;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: accentColor.withOpacity(0.5), width: 2),
          ),
          child: const CircleAvatar(
            radius: 54,
            backgroundImage: null,
            child: Icon(Icons.person_outline_rounded, size: 50),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          controller.userName.value,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          controller.role.value,
          style: TextStyle(
            fontSize: 16,
            color: secondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            controller.department.value,
            style: TextStyle(
              fontSize: 12,
              color: accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoTile(context, Icons.mail_outline_rounded, 'Work Email', 'roshan@example.com'),
            const Divider(),
            _buildInfoTile(context, Icons.badge_outlined, 'Employee ID', 'EMP-00123'),
            const Divider(),
            _buildInfoTile(context, Icons.calendar_today_outlined, 'Joined Date', '12 Jan 2023'),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Column(
      children: [
        _buildActionButton(context, Icons.lock_outline_rounded, 'Change Password'),
        const SizedBox(height: 12),
        _buildActionButton(context, Icons.description_outlined, 'Employment Contract'),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      child: ListTile(
        leading: Icon(icon, color: isDark ? Colors.white : AppColors.primary),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () {},
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, IconData icon, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 22, color: secondaryColor),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: secondaryColor,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

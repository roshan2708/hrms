import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/info_tile.dart';
import '../../widgets/profile/profile_action_button.dart';
import '../../widgets/profile/profile_view_header.dart';

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
              ProfileViewHeader(
                userName: controller.userName.value,
                role: controller.role.value,
                department: controller.department.value,
              ),
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

  Widget _buildInfoSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const InfoTile(icon: Icons.mail_outline_rounded, label: 'Work Email', value: 'roshan@example.com'),
            const Divider(),
            const InfoTile(icon: Icons.badge_outlined, label: 'Employee ID', value: 'EMP-00123'),
            const Divider(),
            const InfoTile(icon: Icons.calendar_today_outlined, label: 'Joined Date', value: '12 Jan 2023'),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Column(
      children: [
        ProfileActionButton(
          icon: Icons.lock_outline_rounded,
          label: 'Change Password',
          onTap: () {},
        ),
        const SizedBox(height: 12),
        ProfileActionButton(
          icon: Icons.description_outlined,
          label: 'Employment Contract',
          onTap: () {},
        ),
      ],
    );
  }
}

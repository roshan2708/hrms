import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/directory_controller.dart';
import '../../core/theme/app_colors.dart';

class EmployeeProfileView extends GetView<DirectoryController> {
  const EmployeeProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // If no employee is selected (e.g., direct navigation glitch), return to previous screen
    if (controller.selectedEmployee.value == null) {
      Future.microtask(() => Get.back());
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final employee = controller.selectedEmployee.value!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final accentColor = isDark ? Colors.white : AppColors.accent;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: accentColor.withValues(alpha: 0.5), width: 2),
              ),
              child: CircleAvatar(
                radius: 54,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Text(
                  employee.name.substring(0, 1),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              employee.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              employee.role,
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
                color: accentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                employee.department,
                style: TextStyle(
                  fontSize: 12,
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Actions Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircularAction(context, Icons.mail_rounded, 'Email', AppColors.primary, () {}),
                _buildCircularAction(context, Icons.message_rounded, 'Message', AppColors.success, () {}),
                _buildCircularAction(context, Icons.call_rounded, 'Call', AppColors.warning, () {}),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Details Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoTile(context, Icons.badge_outlined, 'Employee ID', employee.id),
                    const Divider(),
                    _buildInfoTile(context, Icons.mail_outline_rounded, 'Email', employee.email),
                    const Divider(),
                    _buildInfoTile(context, Icons.business_outlined, 'Department', employee.department),
                    const Divider(),
                    _buildInfoTile(context, Icons.calendar_today_outlined, 'Joining Date', '12 Jan 2022'), // Dummy date
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularAction(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.dark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
      ],
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
          Expanded(
            child: Column(
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
          ),
        ],
      ),
    );
  }
}

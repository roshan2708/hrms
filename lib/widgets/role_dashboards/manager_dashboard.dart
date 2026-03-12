import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../stat_card.dart';
import '../dashboard_section.dart';
import '../../../core/theme/app_colors.dart';

class ManagerDashboard extends GetView<DashboardController> {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardSection(
          title: 'Team Management',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: StatCard(title: 'Team Attendance', value: '94%')),
                  Expanded(child: StatCard(title: 'Tasks Pending', value: '15')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: StatCard(title: 'Team Capacity', value: '85%')),
                  Expanded(child: StatCard(title: 'Sick Leaves', value: '2')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Direct Reports',
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildMiniProfile('Alice', 'Dev', true),
                _buildMiniProfile('Bob', 'QA', false),
                _buildMiniProfile('Charlie', 'UX', true),
                _buildMiniProfile('Dan', 'Dev', true),
                _buildMiniProfile('Eve', 'PM', false),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Manager Services',
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildServiceCardCard(context, 'Directory', Icons.groups_rounded, controller.openDirectory),
              _buildServiceCardCard(context, 'Analytics', Icons.bar_chart_rounded, controller.openAnalytics),
              _buildServiceCardCard(context, 'Departments', Icons.business_rounded, controller.openDepartments),
              _buildServiceCardCard(context, 'Announcements', Icons.campaign_rounded, controller.openAnnouncements),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCardCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: isDark ? Border.all(color: AppColors.darkBorder) : null,
          boxShadow: isDark ? [] : [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniProfile(String name, String role, bool online) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(name[0], style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: online ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Text(role, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}

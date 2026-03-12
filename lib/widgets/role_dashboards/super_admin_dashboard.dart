import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../stat_card.dart';
import '../dashboard_section.dart';
import '../action_tile.dart';

class SuperAdminDashboard extends GetView<DashboardController> {
  const SuperAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardSection(
          title: 'System Overview',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: StatCard(title: 'Total Revenue', value: '\$450,000')),
                  Expanded(child: StatCard(title: 'Active Clients', value: '1,240')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: StatCard(title: 'System Uptime', value: '99.9%')),
                  Expanded(child: StatCard(title: 'New Signups', value: '+45')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Recent System Logs',
          child: Card(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final logs = [
                  'Database backup completed successfully',
                  'New server instance deployed in us-east-1',
                  'Critical security patch applied'
                ];
                return ActionTile(
                  icon: Icons.dns,
                  iconColor: Colors.blue,
                  title: logs[index],
                  subtitle: 'Today, ${10 + index}:00 AM',
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'System Access',
          child: Column(
            children: [
              ActionTile(
                icon: Icons.bar_chart_rounded,
                title: 'Analytics & Reports',
                subtitle: 'View company-wide metrics',
                onTap: controller.openAnalytics,
              ),
              ActionTile(
                icon: Icons.business_rounded,
                title: 'Manage Departments',
                subtitle: 'Add or modify departments',
                onTap: controller.openDepartments,
              ),
              ActionTile(
                icon: Icons.campaign_rounded,
                title: 'Announcements',
                subtitle: 'Post or view broadcasts',
                onTap: controller.openAnnouncements,
              ),
              ActionTile(
                icon: Icons.groups_rounded,
                title: 'Employee Directory',
                subtitle: 'Browse all company staff',
                onTap: controller.openDirectory,
              ),
              ActionTile(
                icon: Icons.settings_rounded,
                title: 'System Settings',
                subtitle: 'Configure application preferences',
                onTap: controller.openSettings,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

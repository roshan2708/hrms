import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../stat_card.dart';
import '../dashboard_section.dart';
import '../metric_bar.dart';

class AdminDashboard extends GetView<DashboardController> {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardSection(
          title: 'Organization Insights',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: StatCard(title: 'Total Employees', value: '156')),
                  Expanded(child: StatCard(title: 'Open Positions', value: '12')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: StatCard(title: 'Utility Usage', value: '78%')),
                  Expanded(child: StatCard(title: 'Budget Util.', value: '64%')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Department Performance',
          child: Column(
            children: [
              MetricBar(label: 'Engineering', progress: 0.92, color: Colors.blue),
              MetricBar(label: 'HR & Admin', progress: 0.85, color: Colors.green),
              MetricBar(label: 'Sales', progress: 0.78, color: Colors.orange),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Admin Actions',
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.business_rounded, color: Colors.blue),
                title: const Text('Manage Departments'),
                trailing: const Icon(Icons.chevron_right),
                onTap: controller.openDepartments,
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.groups_rounded, color: Colors.orange),
                title: const Text('Employee Directory'),
                trailing: const Icon(Icons.chevron_right),
                onTap: controller.openDirectory,
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.settings_rounded, color: Colors.grey),
                title: const Text('System Settings'),
                trailing: const Icon(Icons.chevron_right),
                onTap: controller.openSettings,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

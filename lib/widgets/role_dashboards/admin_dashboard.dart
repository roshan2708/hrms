import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../stat_card.dart';
import '../dashboard_section.dart';
import '../metric_bar.dart';
import '../action_tile.dart';

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
              ActionTile(
                icon: Icons.groups_rounded,
                title: 'Employees',
                subtitle: 'Manage organization staff',
                onTap: controller.openDirectory,
              ),
              ActionTile(
                icon: Icons.calendar_month_rounded,
                title: 'Attendance',
                subtitle: 'Monitor clock-in/out records',
                onTap: controller.openAttendance,
              ),
              ActionTile(
                icon: Icons.list_alt_rounded,
                title: 'Daily Tasks',
                subtitle: 'Track operational progress',
                onTap: controller.openTasks,
              ),
              ActionTile(
                icon: Icons.payments_rounded,
                title: 'Expenses & Loans',
                subtitle: 'Manage financial requests',
                onTap: controller.openExpenses,
              ),
              ActionTile(
                icon: Icons.description_rounded,
                title: 'Pay Slips',
                subtitle: 'Generate and view salary documents',
                onTap: controller.openPaySlips,
              ),
              ActionTile(
                icon: Icons.time_to_leave_rounded,
                title: 'Leave Requests',
                subtitle: 'Approve or manage time off',
                onTap: controller.openLeaveManagement,
              ),
              ActionTile(
                icon: Icons.business_rounded,
                title: 'Departments',
                subtitle: 'Hierarchy management',
                onTap: controller.openDepartments,
              ),
              ActionTile(
                icon: Icons.settings_rounded,
                title: 'Settings',
                subtitle: 'System preferences',
                onTap: controller.openSettings,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

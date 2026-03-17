import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../stat_card.dart';
import '../dashboard_section.dart';
import '../action_tile.dart';

class HRDashboard extends GetView<DashboardController> {
  const HRDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardSection(
          title: 'HR Operations',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: StatCard(title: 'Pending Leaves', value: '24')),
                  Expanded(child: StatCard(title: 'New Requests', value: '8')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: StatCard(title: 'Active Payroll', value: 'Sept 2023')),
                  Expanded(child: StatCard(title: 'Interviews', value: '5 Today')),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Quick Access',
          child: Column(
            children: [
              ActionTile(
                icon: Icons.person_add_rounded,
                title: 'Onboarding',
                subtitle: 'Manage new hire workflows',
                onTap: () {},
              ),
              ActionTile(
                icon: Icons.event_note_rounded,
                title: 'Leave Tracker',
                subtitle: 'Monitor organization leaves',
                onTap: controller.openLeaveManagement,
              ),
              ActionTile(
                icon: Icons.calendar_month_rounded,
                title: 'Attendance',
                subtitle: 'Manage staff clock-in records',
                onTap: controller.openAttendance,
              ),
              ActionTile(
                icon: Icons.insights_rounded,
                title: 'Performance',
                subtitle: 'Employee appraisals and metrics',
                onTap: controller.openAnalytics,
              ),
              ActionTile(
                icon: Icons.assignment_rounded,
                title: 'Tasks',
                subtitle: 'Track operational goals',
                onTap: controller.openTasks,
              ),
              ActionTile(
                icon: Icons.description_rounded,
                title: 'HR Letters',
                subtitle: 'Generate employment documents',
                onTap: () {},
              ),
              ActionTile(
                icon: Icons.groups_rounded,
                title: 'Employee Directory',
                subtitle: 'Staff info and profiles',
                onTap: controller.openDirectory,
              ),
              ActionTile(
                icon: Icons.person_off_rounded,
                title: 'Offboarding',
                subtitle: 'Separation and exit management',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

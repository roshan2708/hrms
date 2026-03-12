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
          title: 'Pending Actions',
          child: Card(
            child: Column(
              children: [
                ActionTile(
                  icon: Icons.person_add,
                  title: 'Finish Onboarding: Alice Smith',
                  subtitle: 'Due tomorrow',
                  onTap: () {},
                ),
                ActionTile(
                  icon: Icons.payments,
                  title: 'Approve Payroll: Batch #45',
                  subtitle: 'Due in 2 days',
                  onTap: () {},
                ),
                ActionTile(
                  icon: Icons.event_note,
                  title: 'Review Leave Policy 2024',
                  subtitle: 'Optional',
                  onTap: () {},
                ),
                ActionTile(
                  icon: Icons.groups_rounded,
                  title: 'Employee Directory',
                  subtitle: 'Quick access to staff info',
                  onTap: controller.openDirectory,
                ),
                ActionTile(
                  icon: Icons.bar_chart_rounded,
                  title: 'HR Analytics',
                  subtitle: 'View attendance & leave stats',
                  onTap: controller.openAnalytics,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

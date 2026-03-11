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
      ],
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

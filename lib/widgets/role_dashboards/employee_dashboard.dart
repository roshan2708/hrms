import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_controller.dart';
import '../stat_card.dart';
import '../attendance_action_card.dart';
import '../service_card.dart';
import '../recent_activity_list.dart';
import '../dashboard_section.dart';

class EmployeeDashboard extends GetView<DashboardController> {
  const EmployeeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardSection(
          title: 'Your Stats',
          child: _buildQuickStatsList(context),
        ),
        const SizedBox(height: 24),
        _buildAttendanceActionCard(context),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Quick Services',
          actionLabel: 'See All',
          onActionTap: () {},
          child: _buildServicesGrid(context),
        ),
        const SizedBox(height: 24),
        DashboardSection(
          title: 'Recent Activity',
          child: _buildRecentActivity(context),
        ),
      ],
    );
  }

  Widget _buildQuickStatsList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.openLeaveManagement,
            child: Obx(() => StatCard(
              title: 'Leaves Left',
              value: '${controller.remainingLeaveDays.value}',
            )),
          ),
          GestureDetector(
            onTap: controller.openAttendance,
            child: Obx(() => StatCard(
              title: 'Attendance',
              value: '${controller.monthlyAttendancePercent.value}%',
            )),
          ),
          Obx(() => StatCard(
            title: 'Next Pay',
            value: '${controller.nextPayDate.value.difference(DateTime.now()).inDays} Days',
          )),
        ],
      ),
    );
  }

  Widget _buildAttendanceActionCard(BuildContext context) {
    return Obx(() => AttendanceActionCard(
      isCheckedIn: controller.isCheckedIn.value,
      formattedWorkedTime: controller.formattedWorkedTime,
      onToggleCheckIn: controller.toggleCheckIn,
    ));
  }

  Widget _buildServicesGrid(BuildContext context) {
    return Obx(() => GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: [
        ServiceCard(
          title: 'Leave',
          icon: Icons.calendar_month_rounded,
          onTap: controller.openLeaveManagement,
          badgeStat: controller.pendingLeaves.value > 0
              ? '${controller.pendingLeaves.value}'
              : null,
        ),
        ServiceCard(
          title: 'Attendance',
          icon: Icons.fact_check_rounded,
          onTap: controller.openAttendance,
        ),
        ServiceCard(
          title: 'Payroll',
          icon: Icons.account_balance_wallet_rounded,
          onTap: controller.openPayroll,
        ),
        ServiceCard(
          title: 'Colleagues',
          icon: Icons.diversity_3_rounded,
          onTap: controller.openDirectory,
        ),
      ],
    ));
  }

  Widget _buildRecentActivity(BuildContext context) {
    return RecentActivityList(
      activities: controller.recentActivities,
    );
  }
}

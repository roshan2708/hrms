import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/theme_controller.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/profile_header.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/attendance_action_card.dart';
import '../../widgets/service_card.dart';
import '../../widgets/recent_activity_list.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('HRMS Dashboard'),
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                themeController.isDarkTheme
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            ),
            onPressed: themeController.toggleTheme,
          ),
          IconButton(
            icon: Obx(
              () => Badge(
                label: Text('${controller.unreadNotifications.value}'),
                isLabelVisible: controller.unreadNotifications.value > 0,
                child: const Icon(Icons.notifications),
              ),
            ),
            onPressed: controller.openNotifications,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.offAllNamed('/login'),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProfileHeader(context, size),
                SizedBox(height: size.height * 0.03),
                _buildQuickStatsList(context, size),
                SizedBox(height: size.height * 0.03),
                _buildAttendanceActionCard(context, size),
                SizedBox(height: size.height * 0.03),
                _buildServicesGrid(context, size),
                SizedBox(height: size.height * 0.03),
                _buildRecentActivity(context, size),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, Size size) {
    return GestureDetector(
      onTap: controller.openProfile,
      child: Obx(
        () => ProfileHeader(
          userName: controller.userName.value,
          role: controller.role.value,
          department: controller.department.value,
        ),
      ),
    );
  }

  Widget _buildQuickStatsList(BuildContext context, Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.openLeaveManagement,
            child: StatCard(
              title: 'Leaves Left',
              value: '${controller.remainingLeaveDays.value}',
            ),
          ),
          GestureDetector(
            onTap: controller.openAttendance,
            child: StatCard(
              title: 'Attendance',
              value: '${controller.monthlyAttendancePercent.value}%',
            ),
          ),
          StatCard(
            title: 'Next Pay',
            value: '${controller.nextPayDate.value.difference(DateTime.now()).inDays} Days',
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceActionCard(BuildContext context, Size size) {
    return AttendanceActionCard(
      isCheckedIn: controller.isCheckedIn.value,
      formattedWorkedTime: controller.formattedWorkedTime,
      onToggleCheckIn: controller.toggleCheckIn,
    );
  }

  Widget _buildServicesGrid(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Services',
              style: AppTypography.subtitle(context).copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.count(
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
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: AppTypography.subtitle(context).copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        RecentActivityList(
          activities: controller.recentActivities,
        ),
      ],
    );
  }
}

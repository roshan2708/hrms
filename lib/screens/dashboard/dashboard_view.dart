import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/theme_controller.dart';
import '../../controllers/dashboard_controller.dart';

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
        child: SingleChildScrollView(
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
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, Size size) {
    return Row(
      children: [
        CircleAvatar(
          radius: size.width * 0.08,
          backgroundColor: AppColors.primary.withValues(alpha: 0.2),
          child: Icon(
            Icons.person,
            size: size.width * 0.1,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: size.width * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  controller.userName.value,
                  style: AppTypography.title(context),
                ),
              ),
              Obx(
                () => Text(
                  '${controller.role.value} | ${controller.department.value}',
                  style: AppTypography.body(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStatsList(BuildContext context, Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStatCard(
            context,
            size,
            title: 'Leaves Left',
            value: '${controller.remainingLeaveDays.value}',
          ),
          _buildStatCard(
            context,
            size,
            title: 'Attendance',
            value: '${controller.monthlyAttendancePercent.value}%',
          ),
          _buildStatCard(context, size, title: 'Next Pay', value: '10 Days'),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    Size size, {
    required String title,
    required String value,
  }) {
    return Card(
      margin: EdgeInsets.only(right: size.width * 0.03),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.015,
          horizontal: size.width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.caption(context)),
            SizedBox(height: size.height * 0.005),
            Text(
              value,
              style: AppTypography.subtitle(
                context,
              ).copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceActionCard(BuildContext context, Size size) {
    return Obx(() {
      final isCheckedIn = controller.isCheckedIn.value;
      return Container(
        padding: EdgeInsets.all(size.width * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: isCheckedIn
                ? [Colors.teal.shade400, Colors.teal.shade700]
                : [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              isCheckedIn ? 'Currently Clocked In' : 'Ready to Start?',
              style: AppTypography.title(context).copyWith(color: Colors.white),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              isCheckedIn
                  ? 'Hours Worked Today: ${controller.formattedWorkedTime}'
                  : 'Clock in to begin tracking time',
              style: AppTypography.body(
                context,
              ).copyWith(color: Colors.white70),
            ),
            SizedBox(height: size.height * 0.03),
            ElevatedButton(
              onPressed: controller.toggleCheckIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: isCheckedIn
                    ? Colors.red.shade400
                    : Colors.white,
                foregroundColor: isCheckedIn ? Colors.white : AppColors.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1,
                  vertical: size.height * 0.015,
                ),
              ),
              child: Text(
                isCheckedIn ? 'CLOCK OUT' : 'CLOCK IN',
                style: AppTypography.button(context).copyWith(
                  color: isCheckedIn ? Colors.white : AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildServicesGrid(BuildContext context, Size size) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: size.width * 0.04,
      crossAxisSpacing: size.width * 0.04,
      childAspectRatio: 1.2,
      children: [
        _buildServiceCard(
          context,
          size,
          title: 'Leave',
          icon: Icons.beach_access,
          onTap: controller.openLeaveManagement,
          badgeStat: '${controller.pendingLeaves.value} Pending',
        ),
        _buildServiceCard(
          context,
          size,
          title: 'Payroll',
          icon: Icons.request_quote,
          onTap: controller.openPayroll,
        ),
        _buildServiceCard(
          context,
          size,
          title: 'Notices',
          icon: Icons.campaign,
          onTap: controller.openNotifications,
          badgeStat: '${controller.unreadNotifications.value} New',
        ),
        _buildServiceCard(
          context,
          size,
          title: 'Directory',
          icon: Icons.groups,
          onTap: controller.openDirectory,
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    Size size, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    String? badgeStat,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: size.width * 0.08, color: AppColors.primary),
              SizedBox(height: size.height * 0.01),
              Text(
                title,
                style: AppTypography.body(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
              if (badgeStat != null) ...[
                SizedBox(height: size.height * 0.005),
                Text(
                  badgeStat,
                  style: AppTypography.caption(
                    context,
                  ).copyWith(color: AppColors.error),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: AppTypography.subtitle(
            context,
          ).copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: size.height * 0.01),
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.recentActivities.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.history,
                  color: AppColors.primary,
                  size: size.width * 0.05,
                ),
                title: Text(
                  controller.recentActivities[index],
                  style: AppTypography.body(context),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

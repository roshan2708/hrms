import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/constants/enums.dart';
import '../../controllers/dashboard_controller.dart';
import '../../widgets/profile_header.dart';
import '../../widgets/role_dashboards/super_admin_dashboard.dart';
import '../../widgets/role_dashboards/admin_dashboard.dart';
import '../../widgets/role_dashboards/hr_dashboard.dart';
import '../../widgets/role_dashboards/manager_dashboard.dart';
import '../../widgets/role_dashboards/employee_dashboard.dart';

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
                _buildRoleBasedDashboard(),
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

  Widget _buildRoleBasedDashboard() {
    switch (controller.userRole.value) {
      case UserRole.superAdmin:
        return const SuperAdminDashboard();
      case UserRole.admin:
        return const AdminDashboard();
      case UserRole.hr:
        return const HRDashboard();
      case UserRole.manager:
        return const ManagerDashboard();
      case UserRole.employee:
        return const EmployeeDashboard();
    }
  }
}

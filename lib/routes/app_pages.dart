import 'package:get/get.dart';
import '../screens/login/login_binding.dart';
import '../screens/login/login_view.dart';
import '../screens/dashboard/dashboard_binding.dart';
import '../screens/dashboard/dashboard_view.dart';
import '../screens/attendance/attendance_binding.dart';
import '../screens/attendance/attendance_view.dart';
import '../screens/leave/leave_binding.dart';
import '../screens/leave/leave_requests_view.dart';
import '../screens/leave/leave_application_view.dart';
import '../screens/profile/profile_view.dart';

// New Screens
import '../screens/directory/directory_binding.dart';
import '../screens/directory/directory_view.dart';
import '../screens/directory/employee_profile_view.dart';
import '../screens/department/department_binding.dart';
import '../screens/department/department_view.dart';
import '../screens/notifications/notifications_binding.dart';
import '../screens/notifications/notifications_view.dart';
import '../screens/analytics/analytics_binding.dart';
import '../screens/analytics/analytics_view.dart';
import '../screens/settings/settings_binding.dart';
import '../screens/settings/settings_view.dart';
import '../screens/announcements/announcements_binding.dart';
import '../screens/announcements/announcements_view.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.attendance,
      page: () => const AttendanceView(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: Routes.leaveRequests,
      page: () => const LeaveRequestsView(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: Routes.applyLeave,
      page: () => const LeaveApplicationView(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
      binding: DashboardBinding(),
    ),
    // New GetPages
    GetPage(
      name: Routes.employeeDirectory,
      page: () => const DirectoryView(),
      binding: DirectoryBinding(),
    ),
    GetPage(
      name: Routes.employeeProfile,
      page: () => const EmployeeProfileView(),
    ),
    GetPage(
      name: Routes.departmentManage,
      page: () => const DepartmentView(),
      binding: DepartmentBinding(),
    ),
    GetPage(
      name: Routes.notifications,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: Routes.analytics,
      page: () => const AnalyticsView(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.announcements,
      page: () => const AnnouncementsView(),
      binding: AnnouncementsBinding(),
    ),
  ];
}

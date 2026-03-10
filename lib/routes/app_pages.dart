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
  ];
}

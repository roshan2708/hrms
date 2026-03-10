import 'package:get/get.dart';
import '../screens/login/login_binding.dart';
import '../screens/login/login_view.dart';
import '../screens/dashboard/dashboard_binding.dart';
import '../screens/dashboard/dashboard_view.dart';
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
  ];
}

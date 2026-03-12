import 'package:get/get.dart';

class AnalyticsController extends GetxController {
  final isLoading = false.obs;

  // Dummy analytics metrics
  final totalEmployees = 90.obs;
  final presentToday = 82.obs;
  final onLeave = 5.obs;
  final absent = 3.obs;

  // Dummy data for department distribution (Pie Chart simulation)
  // Format: Map<DepartmentName, EmployeeCount>
  final departmentDistribution = <String, int>{
    'Engineering': 45,
    'Sales': 20,
    'Marketing': 12,
    'Finance': 8,
    'HR': 5,
  }.obs;

  // Dummy data for last 7 days attendance trend (Bar/Line Chart simulation)
  // Format: Map<Day, PresentCount>
  final attendanceTrend = <String, int>{
    'Mon': 85,
    'Tue': 88,
    'Wed': 86,
    'Thu': 84,
    'Fri': 82,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    loadAnalytics();
  }

  void loadAnalytics() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 700));
    // Data is already assigned dummy values
    isLoading.value = false;
  }
}

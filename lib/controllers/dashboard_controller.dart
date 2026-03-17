import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../services/employee_service.dart';
import '../models/employee_model.dart';
import '../routes/app_routes.dart';
import '../core/constants/enums.dart';

class DashboardController extends GetxController {
  
  final isCheckedIn = false.obs;
  final checkInTime = Rxn<DateTime>();
  final workedSeconds = 0.obs;
  Timer? _workedTimer;

  final isLoading = true.obs;
  final userName = ''.obs;
  final role = ''.obs;
  final department = ''.obs;
  final profileImageUrl = ''.obs;
  final userRole = UserRole.employee.obs;

  final pendingLeaves = 2.obs;
  final unreadNotifications = 5.obs;

  final remainingLeaveDays = 12.0.obs;
  final monthlyAttendancePercent = 98.4.obs;
  final nextPayDate = DateTime.now().add(const Duration(days: 10)).obs;

  final recentActivities = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployeeData();
    recentActivities.addAll([
      "Yesterday: Clocked out at 06:15 PM",
      "Tuesday: Leave request approved by Manager",
      "Monday: Clocked in at 08:45 AM",
    ]);
  }

  Future<void> fetchEmployeeData() async {
    try {
      isLoading.value = true;
      // In a real app we'd get the current user's ID from storage
      // For now, we'll just fetch all and take the first one as a demonstration
      final response = await EmployeeService.getAllEmployees();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          final employee = Employee.fromJson(data[0]);
          userName.value = employee.name;
          role.value = employee.role;
          department.value = employee.department;
          
          // Map string role to UserRole enum
          switch (employee.role.toLowerCase()) {
            case 'super admin':
              userRole.value = UserRole.superAdmin;
              break;
            case 'admin':
              userRole.value = UserRole.admin;
              break;
            case 'hr':
              userRole.value = UserRole.hr;
              break;
            case 'manager':
              userRole.value = UserRole.manager;
              break;
            default:
              userRole.value = UserRole.employee;
          }
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch employee data: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred while fetching data');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _workedTimer?.cancel();
    super.onClose();
  }

  void toggleCheckIn() {
    isCheckedIn.value = !isCheckedIn.value;
    if (isCheckedIn.value) {
      checkInTime.value = DateTime.now();

      workedSeconds.value = 0;
      _workedTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        workedSeconds.value++;
      });

      _addActivity("Today: Clocked in at ${_formatTime(checkInTime.value!)}");
      Get.snackbar(
        'Success',
        'Clocked in successfully',
        snackPosition: SnackPosition.TOP,
      );
    } else {
      _workedTimer?.cancel();
      _addActivity("Today: Clocked out at ${_formatTime(DateTime.now())}");
      Get.snackbar(
        'Success',
        'Clocked out successfully',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void _addActivity(String activity) {
    recentActivities.insert(0, activity);
    if (recentActivities.length > 4) {
      recentActivities.removeLast();
    }
  }

  String _formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get formattedWorkedTime {
    int hours = workedSeconds.value ~/ 3600;
    int minutes = (workedSeconds.value % 3600) ~/ 60;
    int seconds = workedSeconds.value % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void openLeaveManagement() => Get.toNamed(Routes.leaveRequests);
  void openPayroll() => Get.snackbar('Payroll', 'Downloading Payslip...');
  void openNotifications() => Get.toNamed(Routes.notifications);
  void openDirectory() => Get.toNamed(Routes.employeeDirectory);
  void openAttendance() => Get.toNamed(Routes.attendance);
  void openProfile() => Get.toNamed(Routes.settings); // Use settings view for profile actions
  
  // New navigation actions
  void openSettings() => Get.toNamed(Routes.settings);
  void openAnnouncements() => Get.toNamed(Routes.announcements);
  void openAnalytics() => Get.toNamed(Routes.analytics);
  void openDepartments() => Get.toNamed(Routes.departmentManage);
  
  void openCompanies() => Get.toNamed(Routes.companies);
  void openBranches() => Get.toNamed(Routes.branches);
  void openAssets() => Get.toNamed(Routes.assets);
  void openSalary() => Get.toNamed(Routes.salary);
  void openAuditLogs() => Get.toNamed(Routes.auditLogs);
  void openTasks() => Get.toNamed(Routes.tasks);
  void openExpenses() => Get.toNamed(Routes.expenses);
  void openPaySlips() => Get.toNamed(Routes.paySlips);

  void openWFHRequests() => Get.toNamed(Routes.wfhRequests);
  void openSetupOrganization() => Get.toNamed(Routes.setupOrganization);
  void openUserManagement() => Get.toNamed(Routes.users);
  void openTraining() => Get.toNamed(Routes.training);
  void openRecruitment() => Get.toNamed(Routes.recruitment);
  void openPerformance() => Get.toNamed(Routes.performance);
  void openOnboarding() => Get.toNamed(Routes.onboarding);
  void openVisitorTracking() => Get.toNamed(Routes.visitorTracking);
  void openDeskManagement() => Get.toNamed(Routes.deskManagement);
  void openAutomationCenter() => Get.toNamed(Routes.automationCenter);
  void openLoans() => Get.toNamed(Routes.loanManagement);
  void openTravelExpenses() => Get.toNamed(Routes.travelExpenses);
  void openCalendar() => Get.toNamed(Routes.calendar);
  void openDailyTasks() => Get.toNamed(Routes.dailyTasks);
  void openHelpdesk() => Get.toNamed(Routes.helpdesk);
  void openKnowledgeBase() => Get.toNamed(Routes.knowledgeBase);
  void openFeedback() => Get.toNamed(Routes.feedback);
}

import 'package:flutter/material.dart';
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
import '../screens/company/company_binding.dart';
import '../screens/company/company_view.dart';
import '../screens/branch/branch_binding.dart';
import '../screens/branch/branch_view.dart';
import '../screens/asset/asset_binding.dart';
import '../screens/asset/asset_view.dart';
import '../screens/audit/audit_binding.dart';
import '../screens/audit/audit_view.dart';
import '../screens/finance/finance_binding.dart';
import '../screens/finance/finance_view.dart';
import '../screens/setup_organization/setup_organization_binding.dart';
import '../screens/setup_organization/setup_organization_view.dart';
import '../screens/user_management/user_management_binding.dart';
import '../screens/user_management/user_management_view.dart';
import '../screens/wfh/wfh_binding.dart';
import '../screens/wfh/wfh_view.dart';
import '../screens/recruitment/recruitment_binding.dart';
import '../screens/recruitment/recruitment_view.dart';
import '../screens/training/training_binding.dart';
import '../screens/training/training_view.dart';
import '../screens/performance/performance_binding.dart';
import '../screens/performance/performance_view.dart';
import '../screens/onboarding/onboarding_binding.dart';
import '../screens/onboarding/onboarding_view.dart';
import '../screens/delegation/delegation_binding.dart';
import '../screens/delegation/delegation_view.dart';
import '../screens/visitor/visitor_binding.dart';
import '../screens/visitor/visitor_view.dart';
import '../screens/desk/desk_binding.dart';
import '../screens/desk/desk_view.dart';
import '../screens/automation/automation_binding.dart';
import '../screens/automation/automation_view.dart';
import '../screens/loans/loans_binding.dart';
import '../screens/loans/loans_view.dart';
import '../screens/travel/travel_expense_binding.dart';
import '../screens/travel/travel_expense_view.dart';
import '../screens/calendar/calendar_binding.dart';
import '../screens/calendar/calendar_view.dart';
import '../screens/daily_task/daily_task_binding.dart';
import '../screens/daily_task/daily_task_view.dart';
import '../screens/helpdesk/helpdesk_binding.dart';
import '../screens/helpdesk/helpdesk_view.dart';
import '../screens/auth/signup_binding.dart';
import '../screens/auth/signup_view.dart';
import '../screens/auth/otp_binding.dart';
import '../screens/auth/otp_view.dart';

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
    GetPage(
      name: Routes.companies,
      page: () => const CompanyListView(),
      binding: CompanyBinding(),
    ),
    GetPage(
      name: Routes.branches,
      page: () => const BranchListView(),
      binding: BranchBinding(),
    ),
    GetPage(
      name: Routes.assets,
      page: () => const AssetListView(),
      binding: AssetBinding(),
    ),
    GetPage(
      name: Routes.auditLogs,
      page: () => const AuditLogView(),
      binding: AuditBinding(),
    ),
    GetPage(
      name: Routes.salary,
      page: () => const FinanceDashboardView(),
      binding: FinanceBinding(),
    ),
    GetPage(
      name: Routes.paySlips,
      page: () => const FinanceDashboardView(),
      binding: FinanceBinding(),
    ),
    GetPage(
      name: Routes.expenses,
      page: () => const FinanceDashboardView(),
      binding: FinanceBinding(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: Routes.otpVerification,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: Routes.setupOrganization,
      page: () => const SetupOrganizationView(),
      binding: SetupOrganizationBinding(),
    ),
    GetPage(
      name: Routes.users,
      page: () => const UserManagementView(),
      binding: UserManagementBinding(),
    ),
    GetPage(
      name: Routes.wfhRequests,
      page: () => const WFHRequestsView(),
      binding: WFHBinding(),
    ),
    GetPage(
      name: Routes.recruitment,
      page: () => const RecruitmentView(),
      binding: RecruitmentBinding(),
    ),
    GetPage(
      name: Routes.training,
      page: () => const TrainingView(),
      binding: TrainingBinding(),
    ),
    GetPage(
      name: Routes.performance,
      page: () => const PerformanceView(),
      binding: PerformanceBinding(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.delegation,
      page: () => const DelegationView(),
      binding: DelegationBinding(),
    ),
    GetPage(
      name: Routes.visitorTracking,
      page: () => const VisitorTrackingView(),
      binding: VisitorBinding(),
    ),
    GetPage(
      name: Routes.deskManagement,
      page: () => const DeskManagementView(),
      binding: DeskBinding(),
    ),
    GetPage(
      name: Routes.automationCenter,
      page: () => const AutomationCenterView(),
      binding: AutomationBinding(),
    ),
    GetPage(
      name: Routes.loanManagement,
      page: () => const LoansView(),
      binding: LoansBinding(),
    ),
    GetPage(
      name: Routes.travelExpenses,
      page: () => const TravelExpenseView(),
      binding: TravelExpenseBinding(),
    ),
    GetPage(
      name: Routes.calendar,
      page: () => const CalendarView(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: Routes.dailyTasks,
      page: () => const DailyTaskView(),
      binding: DailyTaskBinding(),
    ),
    GetPage(
      name: Routes.helpdesk,
      page: () => const HelpdeskView(),
      binding: HelpdeskBinding(),
    ),
    // Placeholder for KnowledgeBase and Feedback
    GetPage(
      name: Routes.knowledgeBase,
      page: () => Scaffold(appBar: AppBar(title: const Text('Knowledge Base')), body: const Center(child: const Text('Coming Soon'))),
    ),
    GetPage(
      name: Routes.feedback,
      page: () => Scaffold(appBar: AppBar(title: const Text('Feedback')), body: const Center(child: const Text('Coming Soon'))),
    ),
  ];
}

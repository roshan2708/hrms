import '../models/department_model.dart';
import '../models/announcement_model.dart';
import '../models/notification_model.dart';
import '../models/employee_model.dart';

class DummyData {
  static List<Department> departments = [
    Department(id: 'D01', name: 'Engineering', head: 'Alice Parker', employeeCount: 45),
    Department(id: 'D02', name: 'Human Resources', head: 'Bob Smith', employeeCount: 5),
    Department(id: 'D03', name: 'Marketing', head: 'Charlie Davis', employeeCount: 12),
    Department(id: 'D04', name: 'Sales', head: 'Diana Moore', employeeCount: 20),
    Department(id: 'D05', name: 'Finance', head: 'Ethan Hunt', employeeCount: 8),
  ];

  static List<Announcement> announcements = [
    Announcement(
      id: 'A01',
      title: 'Q4 Townhall Meeting',
      content: 'Join us for the Q4 Townhall tomorrow at 10 AM. We will discuss the new roadmap and upcoming product releases.',
      datePosted: DateTime.now().subtract(const Duration(hours: 4)),
      author: 'HR Department',
      isImportant: true,
    ),
    Announcement(
      id: 'A02',
      title: 'New Health Insurance Policy',
      content: 'We have upgraded our corporate health insurance. Check your email for details regarding dependents and coverage limits.',
      datePosted: DateTime.now().subtract(const Duration(days: 2)),
      author: 'HR Department',
    ),
    Announcement(
      id: 'A03',
      title: 'Welcome New Hires!',
      content: 'Please welcome Sarah and John to the Engineering team. They will be joining the frontend squad starting Monday.',
      datePosted: DateTime.now().subtract(const Duration(days: 5)),
      author: 'Engineering VP',
    ),
    Announcement(
      id: 'A04',
      title: 'Office Relocation Update',
      content: 'The 3rd-floor renovations are complete. Affected staff can begin moving back to their original desks on Friday.',
      datePosted: DateTime.now().subtract(const Duration(days: 8)),
      author: 'Facilities',
    ),
  ];

  static List<AppNotification> notifications = [
    AppNotification(
      id: 'N01',
      title: 'Leave Approved',
      message: 'Your sick leave request for 15 Oct has been approved.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      type: 'leave',
    ),
    AppNotification(
      id: 'N02',
      title: 'Attendance Alert',
      message: 'You missed your check-out yesterday.',
      timestamp: DateTime.now().subtract(const Duration(hours: 18)),
      isRead: false,
      type: 'attendance',
    ),
    AppNotification(
      id: 'N03',
      title: 'System Update',
      message: 'The HRMS will undergo maintenance this Sunday at 2 AM.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
      type: 'system',
    ),
    AppNotification(
      id: 'N04',
      title: 'Leave Rejected',
      message: 'Your casual leave request for next week was rejected due to project deadlines.',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
      type: 'leave',
    ),
  ];

  static List<Employee> employees = [
    Employee(id: 'EMP001', name: 'Alice Parker', email: 'alice.parker@company.com', department: 'Engineering', role: 'Team Lead'),
    Employee(id: 'EMP002', name: 'Bob Smith', email: 'bob.smith@company.com', department: 'Human Resources', role: 'HR Manager'),
    Employee(id: 'EMP003', name: 'Charlie Davis', email: 'charlie.davis@company.com', department: 'Marketing', role: 'Marketing Executive'),
    Employee(id: 'EMP004', name: 'Diana Moore', email: 'diana.moore@company.com', department: 'Sales', role: 'Sales Rep'),
    Employee(id: 'EMP005', name: 'Ethan Hunt', email: 'ethan.hunt@company.com', department: 'Finance', role: 'Accountant'),
    Employee(id: 'EMP006', name: 'Frank White', email: 'frank.white@company.com', department: 'Engineering', role: 'Software Engineer'),
    Employee(id: 'EMP007', name: 'Grace Lee', email: 'grace.lee@company.com', department: 'Engineering', role: 'QA Engineer'),
  ];
}

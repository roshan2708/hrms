import '../api/api_client.dart';

class AdministrationService {
  static Future<List<dynamic>> getDelegations() async {
    // Simulate API call
    return [
      {
        'id': 1,
        'delegated_by': 'Admin User',
        'delegated_by_role': 'admin',
        'delegated_to': 'John Manager',
        'module': 'Payroll Approval',
        'start_date': '2026-02-20',
        'end_date': '2026-02-25',
        'status': 'Active'
      },
      {
        'id': 2,
        'delegated_by': 'Super Admin',
        'delegated_by_role': 'superadmin',
        'delegated_to': 'Sarah HR',
        'module': 'Leave Approval',
        'start_date': '2026-01-10',
        'end_date': '2026-01-15',
        'status': 'Expired'
      },
    ];
  }

  static Future<List<dynamic>> getVisitors() async {
    return [
      { 'id': 1, 'name': 'Michael Scott', 'purpose': 'Client Meeting', 'host': 'Dwight Schrute', 'entry': '09:00 AM', 'exit': '11:00 AM', 'status': 'Checked Out' },
      { 'id': 2, 'name': 'Jim Halpert', 'purpose': 'Interview', 'host': 'Pam Beesly', 'entry': '10:30 AM', 'exit': '-', 'status': 'In Premise' },
    ];
  }

  static Future<List<dynamic>> getDesks() async {
    return [
      { 'id': 'D01', 'name': 'Desk 101', 'floor': '1st Floor', 'status': 'Available', 'type': 'Hot Desk' },
      { 'id': 'D02', 'name': 'Desk 102', 'floor': '1st Floor', 'status': 'Booked', 'type': 'Hot Desk', 'bookedBy': 'John Doe' },
      { 'id': 'D03', 'name': 'Desk 103', 'floor': '2nd Floor', 'status': 'Assigned', 'type': 'Permanent', 'bookedBy': 'Alice Smith' },
    ];
  }

  static Future<List<dynamic>> getDeskBookings() async {
    return [
      { 'id': 'B01', 'deskId': 'D02', 'employee': 'John Doe', 'date': '2026-02-25', 'time': '10:00 AM', 'status': 'Confirmed' },
    ];
  }

  static Future<List<dynamic>> getAutomationWorkflows() async {
    return [
      { 'id': 1, 'name': 'Leave Approval Workflow', 'trigger': 'On Leave Request', 'steps': 3, 'status': 'Active' },
      { 'id': 2, 'name': 'Onboarding Notification', 'trigger': 'On Candidate Join', 'steps': 2, 'status': 'Draft' },
    ];
  }
}

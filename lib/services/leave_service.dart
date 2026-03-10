import '../models/leave_model.dart';

class LeaveService {
  Future<List<LeaveRequest>> getLeaveRequests() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return [
      LeaveRequest(
        id: 'LV001',
        employeeId: 'EMP001',
        leaveType: 'Sick Leave',
        startDate: DateTime.now().subtract(const Duration(days: 10)),
        endDate: DateTime.now().subtract(const Duration(days: 9)),
        status: 'Approved',
        reason: 'Flu',
      ),
      LeaveRequest(
        id: 'LV002',
        employeeId: 'EMP001',
        leaveType: 'Casual Leave',
        startDate: DateTime.now().add(const Duration(days: 5)),
        endDate: DateTime.now().add(const Duration(days: 6)),
        status: 'Pending',
        reason: 'Family event',
      ),
    ];
  }

  Future<bool> applyLeave(LeaveRequest request) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would send data to the server
    return true;
  }
}

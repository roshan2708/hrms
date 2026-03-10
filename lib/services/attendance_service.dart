import '../models/attendance_model.dart';

class AttendanceService {
  Future<List<AttendanceRecord>> getAttendanceList() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final now = DateTime.now();
    return [
      AttendanceRecord(
        id: 'ATT001',
        employeeId: 'EMP001',
        date: now.subtract(const Duration(days: 0)),
        checkInTime: DateTime(now.year, now.month, now.day, 9, 0),
        status: 'Present',
      ),
      AttendanceRecord(
        id: 'ATT002',
        employeeId: 'EMP001',
        date: now.subtract(const Duration(days: 1)),
        checkInTime: DateTime(now.year, now.month, now.day - 1, 8, 55),
        checkOutTime: DateTime(now.year, now.month, now.day - 1, 18, 5),
        status: 'Present',
      ),
      AttendanceRecord(
        id: 'ATT003',
        employeeId: 'EMP001',
        date: now.subtract(const Duration(days: 2)),
        checkInTime: DateTime(now.year, now.month, now.day - 2, 9, 10),
        checkOutTime: DateTime(now.year, now.month, now.day - 2, 18, 15),
        status: 'Present',
      ),
    ];
  }
}

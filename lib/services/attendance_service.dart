import '../models/attendance_model.dart';
import 'api_service.dart';

class AttendanceService {
  final ApiService _apiService = ApiService();

  Future<List<AttendanceRecord>> getAttendanceList() async {
    final List<dynamic> response = await _apiService.get("/attendance");
    return response.map((json) => AttendanceRecord.fromJson(json)).toList();
  }
}

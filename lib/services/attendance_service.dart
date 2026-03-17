import 'package:http/http.dart' as http;
import '../core/api/api_client.dart';

class AttendanceService {
  static Future<http.Response> getAttendanceList() async {
    return await ApiClient.get('/attendance');
  }

  static Future<http.Response> checkIn(Map<String, dynamic> data) async {
    return await ApiClient.post('/attendance/manual', data);
  }

  static Future<http.Response> getMyAttendance() async {
    return await ApiClient.get('/attendance/me');
  }
}

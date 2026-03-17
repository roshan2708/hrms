import 'package:http/http.dart' as http;
import '../core/api/api_client.dart';

class LeaveService {
  static Future<http.Response> getLeaveRequests() async {
    return await ApiClient.get('/leaves');
  }

  static Future<http.Response> applyLeave(Map<String, dynamic> leaveData) async {
    return await ApiClient.post('/leave', leaveData);
  }
}

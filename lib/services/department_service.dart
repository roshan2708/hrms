import 'package:http/http.dart' as http;
import '../core/api/api_client.dart';

class DepartmentService {
  static Future<http.Response> getAllDepartments() async {
    return await ApiClient.get('/superadmin/departments');
  }

  static Future<http.Response> createDepartment(Map<String, dynamic> departmentData) async {
    return await ApiClient.post('/superadmin/departments', departmentData);
  }

  static Future<http.Response> updateDepartment(String id, Map<String, dynamic> updates) async {
    return await ApiClient.put('/superadmin/departments/$id', updates);
  }

  static Future<http.Response> toggleDepartmentStatus(String id) async {
    return await ApiClient.put('/superadmin/departments/$id/toggle-status', {});
  }
}

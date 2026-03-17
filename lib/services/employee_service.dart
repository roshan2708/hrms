import 'package:http/http.dart' as http;
import '../core/api/api_client.dart';

class EmployeeService {
  static Future<http.Response> getAllEmployees() async {
    return await ApiClient.get('/admin/employees');
  }

  static Future<http.Response> getEmployeeById(String id) async {
    return await ApiClient.get('/admin/employees/$id');
  }

  static Future<http.Response> createEmployee(Map<String, dynamic> employeeData) async {
    return await ApiClient.post('/admin/create-employee', employeeData);
  }

  static Future<http.Response> updateEmployee(String id, Map<String, dynamic> updates) async {
    return await ApiClient.put('/admin/employees/$id', updates);
  }

  static Future<http.Response> deleteEmployee(String id) async {
    return await ApiClient.delete('/superadmin/employees/$id');
  }

  static Future<http.Response> getEmployeesForSelection() async {
    return await ApiClient.get('/employees');
  }
}

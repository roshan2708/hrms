import 'package:http/http.dart' as http;
import '../core/api/api_client.dart';

class FinanceService {
  static Future<http.Response> getSalaryAssignments() async {
    return await ApiClient.get('/superadmin/salary-assignments');
  }

  static Future<http.Response> createSalaryAssignment(Map<String, dynamic> data) async {
    return await ApiClient.post('/superadmin/salary-assignments', data);
  }

  static Future<http.Response> getPaySlips() async {
    // Note: Endpoint not explicitly listed in api_integrations.txt but needed for UI parity
    return await ApiClient.get('/finance/payslips');
  }

  static Future<http.Response> getExpenses() async {
    return await ApiClient.get('/finance/expenses');
  }
}

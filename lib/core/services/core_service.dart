import '../api/api_client.dart';

class CoreService {
  static Future<bool> setupOrganization(Map<String, dynamic> data) async {
    final response = await ApiClient.post('/superadmin/create-company', data);
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  static Future<List<dynamic>> getUsers() async {
    // Falls back to employee list if user-specific list is missing on backend
    final response = await ApiClient.get('/admin/employees');
    if (response.statusCode == 200) {
      // Logic to parse users
      return []; 
    }
    return [];
  }

  static Future<List<dynamic>> getRoles() async {
    // Mock roles matching React implementation until backend endpoint is clarified
    return [
      {'id': 1, 'name': 'Super Admin', 'description': 'Full access to all modules'},
      {'id': 2, 'name': 'HR', 'description': 'Manage employees, attendance, and payroll'},
      {'id': 3, 'name': 'Manager', 'description': 'Team management and approvals'},
      {'id': 4, 'name': 'Accountant', 'description': 'Financial management access'},
      {'id': 5, 'name': 'Employee', 'description': 'Standard employee access'},
    ];
  }
}

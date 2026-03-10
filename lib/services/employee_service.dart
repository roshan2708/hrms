import '../models/employee_model.dart';
import 'api_service.dart';

class EmployeeService {
  final ApiService _apiService = ApiService();

  Future<Employee> getEmployee() async {
    final response = await _apiService.get("/employee");
    return Employee.fromJson(response);
  }
}

import '../models/employee_model.dart';

class EmployeeService {
  Future<Employee> getEmployee() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return Employee(
      id: 'EMP001',
      name: 'Roshan Singh',
      email: 'roshan@example.com',
      department: 'Engineering',
      role: 'Flutter Developer',
    );
  }
}

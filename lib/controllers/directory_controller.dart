import 'package:get/get.dart';
import '../models/employee_model.dart';

class DirectoryController extends GetxController {
  final isLoading = false.obs;
  
  // Total unfiltered list
  final List<Employee> _allEmployees = Employee.dummyEmployees;
  
  // Observable list for the UI
  final employees = <Employee>[].obs;
  
  // Currently selected employee for profile view
  final selectedEmployee = Rx<Employee?>(null);

  @override
  void onInit() {
    super.onInit();
    loadEmployees();
  }

  void loadEmployees() async {
    isLoading.value = true;
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    employees.assignAll(_allEmployees);
    isLoading.value = false;
  }

  void searchEmployees(String query) {
    if (query.isEmpty) {
      employees.assignAll(_allEmployees);
      return;
    }
    
    final lowerQuery = query.toLowerCase();
    final results = _allEmployees.where((emp) {
      return emp.name.toLowerCase().contains(lowerQuery) ||
             emp.department.toLowerCase().contains(lowerQuery) ||
             emp.role.toLowerCase().contains(lowerQuery);
    }).toList();
    
    employees.assignAll(results);
  }

  void selectEmployee(Employee employee) {
    selectedEmployee.value = employee;
  }
}

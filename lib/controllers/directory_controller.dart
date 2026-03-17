import 'dart:convert';
import 'package:get/get.dart';
import '../models/employee_model.dart';
import '../services/employee_service.dart';

class DirectoryController extends GetxController {
  final isLoading = false.obs;
  
  // Total unfiltered list
  final List<Employee> _allEmployees = <Employee>[];
  
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
    try {
      isLoading.value = true;
      final response = await EmployeeService.getAllEmployees();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        _allEmployees.clear();
        _allEmployees.addAll(
          data.map((json) => Employee.fromJson(json)).toList(),
        );
        employees.assignAll(_allEmployees);
      } else {
        Get.snackbar('Error', 'Failed to load directory: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred while loading directory');
    } finally {
      isLoading.value = false;
    }
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

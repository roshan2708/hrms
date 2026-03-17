import 'dart:convert';
import 'package:get/get.dart';
import '../models/department_model.dart';
import '../services/department_service.dart';

class DepartmentController extends GetxController {
  final isLoading = false.obs;
  final departments = <Department>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDepartments();
  }

  void loadDepartments() async {
    try {
      isLoading.value = true;
      final response = await DepartmentService.getAllDepartments();
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = jsonDecode(response.body);
        departments.assignAll(
          data.map((json) => Department.fromJson(json)).toList(),
        );
      } else {
        Get.snackbar('Error', 'Failed to load departments: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred while loading departments');
    } finally {
      isLoading.value = false;
    }
  }
}
